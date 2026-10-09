# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 仓库定位

本仓库不是一个应用工程，而是 **qm_health 项目的本地开发环境编排**：用一份 `compose.yaml` 拉起 PostgreSQL 16.3、Redis 8.6.0，以及两个应用容器——`qm-health-rust`（Rust，`ghcr.io/zhouxingma/qm-health-rust`）和 `qm-health-ai`（Java/Spring Boot，`ghcr.io/zhouxingma/qm-health-ai`）。两者镜像都不在本仓库构建。PostgreSQL 首次启动时灌入建表脚本与基础数据。若还有别的仓库要接入，它们通过 `external: true` 复用本仓库创建的固定网络。

仓库不含构建、测试或 lint 流程——"运行"即启动容器，验证靠连库查表或请求应用端口。

## 常用命令

```bash
cp .env.example .env    # 首次使用；.env 不入库
docker compose up -d
docker compose ps
docker compose logs -f postgres
```

```bash
docker compose logs -f qm-health-rust
```

```bash
docker compose logs -f qm-health-ai
```

清空数据重来（会丢失所有数据）：

```bash
docker compose down && docker volume rm qm_health
```

连接数据库（宿主机端口取自 `.env`，默认 5432 / 6379）：

```bash
docker exec -it postgres16.3 psql -U postgres -d qm_health
```

```bash
docker exec -it redis8.6.0 redis-cli -a books123
```

## 编排架构

六个关键设计点，改 `compose.yaml` 前必须先理解：

1. **单卷多服务**：PostgreSQL 和 Redis 共用同一个命名卷 `qm_health`，靠各自容器内的子目录隔离——Postgres 通过 `PGDATA=/var/lib/postgresql/data/pgdata` 落到 `pgdata/`，Redis 用 `--dir /data/redis` 落到 `redis/`。所以删卷会同时清掉两边的数据；新增有状态服务时应沿用同样的"子目录隔离"约定。
2. **固定网络名**：网络和卷都显式指定 `name:`，不随 compose 项目名前缀变化。`qm_health_docker_start` 网络是给外部业务容器 `external: true` 接入用的，改名会打断依赖方。
3. **初始化只跑一次**：`./init-sql` 以只读方式挂到 `/docker-entrypoint-initdb.d`，PostgreSQL 官方镜像**仅在数据目录为空时**按文件名顺序执行一次。因此 `init-sql/` 里的修改对已存在的卷无效——要生效必须删卷重建。文件数字前缀（`01-`、`02-`…）就是执行顺序，新增文件要顺延编号。
4. **应用用独立卷**：`qm-health-rust` 跑在 uid 10001，其日志与上传文件挂独立命名卷 `qm_health_rust_data`（→ 容器 `/data`），不与数据库卷混用，两边可分别重置。镜像内 `/data` 已属 uid 10001，新建卷时 docker 会连属主一起复制，因此首启即可写。该服务通过 `depends_on: condition: service_healthy` 等数据库和 Redis 就绪后才启动，`DB_URL` / `REDIS_URL` 由 `.env` 变量拼装、走服务名 `postgres` / `redis` 互访。
5. **版本走变量**：四个镜像的 tag 分别由 `POSTGRES_VERSION` / `REDIS_VERSION` / `RUST_VERSION` / `AI_VERSION` 控制，Postgres 与 Redis 的 `container_name` 也内插了版本号（如 `postgres${POSTGRES_VERSION}`），所以改版本时容器名不会与实际版本脱节。改版本后 `docker compose up -d` 只会重建版本变化的那一个服务——compose 按"期望配置 vs 运行中容器"做差量重建，**`depends_on` 的依赖方不会被连带重建**（实测重建 rust 时 ai 保持运行；升级 rust 后要让 ai 重拉 MCP 索引需 `docker compose up -d --force-recreate qm-health-ai`）。注意 `up` 默认拉取策略是 `missing`，`:latest` 这类可变 tag 需先 `docker compose pull <服务名>`。另：**PostgreSQL 数据目录不跨大版本兼容**，改 `POSTGRES_VERSION` 的大版本号（16→17）会导致旧卷启动失败，需 `pg_dump` 迁移或删卷重建。
6. **ai 依赖 rust，且有两个不同的 rust 地址**：`qm-health-ai` 启动时要连 rust 拉 MCP 工具列表，所以 `depends_on` 里排在 rust 之后，但只能用 `condition: service_started`——rust 镜像内没有任何 http 客户端（`curl`/`wget`/`nc` 都没有），做不了 healthcheck。ai 启动期强依赖 Postgres / Redis / rust，任一不可用就退出，靠 `restart: unless-stopped` 自愈。两个地址别混：`QMHEALTH_URL`（默认 `http://qm-health-rust:8080`）是**容器间**调用用的；`APP_API_RUSTBASE`（默认取 `RUST_PUBLIC_URL`，即 `http://localhost:8080`）是下发给**浏览器**的（`GET /app-config.js` 的 `rustApiBase`），必须是浏览器能解析的地址，填容器名会导致前端调不通。两个应用都用 `LOG_LEVEL` 这个同名环境变量，所以 compose 里分别注入 `RUST_LOG_LEVEL` / `AI_LOG_LEVEL`，不要合并成一个。`QMHEALTH_SECURITY_KEY` 故意不注入（缺省用镜像内置的测试密钥，与 `02-seed.sql` 里 `sys_app(app_code='qmhealth_ai').security_key` 的内置值相同）。它是 **ai 请求 rust 时的签名密钥**，rust 用 `sys_app.security_key` 校验签名，所以这两处必须一致；要自定义就同时改 `02-seed.sql` 的 `sys_app.security_key`（已建库则直接 `UPDATE`）和 ai 的 `QMHEALTH_SECURITY_KEY`。**与 rust 的 `ENCRYPTION_KEY` 无关**——后者是 rust 自己加密用的，不用跟着改。注意空字符串会覆盖掉镜像默认值而非回退。

`.env` 中 `POSTGRES_DB` 必须与业务侧 `envs/.env.*` 里 `db.url` 的库名（`.../qm_health`）一致；Postgres 与 Redis 密码默认同为 `books123`。

## 数据库 Schema 约定

`init-sql/01-schema.sql` 是全部表结构的唯一来源，新增表时严格沿用现有约定：

- 每表都有 `pk_id bigserial` 物理主键 + `id varchar(36)` 业务主键（UUID/ULID），业务查询走 `id`。
- **软删除**：`is_deleted smallint default 0` + `gmt_deleted timestamp`，后者默认哨兵值 `'9999-12-31 23:59:59.999999'`；另有 `gmt_created`、`gmt_modified`。唯一索引通常建在业务键上，需要"删除后重建"语义的才用 `WHERE is_deleted = 0` 的部分索引（参考 `users_metadata`）。
- 表、字段全部带中文 `comment on`，取值枚举写在注释里（如 `frequency_type`：1-每天, 2-循环定时…）。新增字段时同步补注释。
- 命名前缀区分归属：`users_*` 用户数据、`medical_*` 就诊相关、`sys_*` 系统配置、`ai_*` AI 对话与追踪。

按业务域分组：

- **用户基础**：`users`、`users_concat`（联系方式）、`users_identity`（证件）、`users_auth`（登录/三方）、`users_tag`、`users_metadata` / `users_metadata_records`（静态属性 vs 动态事件）、`sys_files`、`sys_user_config`。
- **健康数据**：`users_health_indicator`（用户指标记录，`file_id` 为文件 id 数组）、`sys_health_indicators`（指标字典，`indicator_code_en` 是 GIN 索引的别名数组，用于中英文编码归一）、`sys_health_indicators_config`（按 `indicator_code` 存前端表单/图表配置的 JSON 文本）。
- **就诊**：`medical_visit`（含预约与已就诊，`status` 区分）、`medical_report`、`medical_conversation`（录音转写）、`medical_medicine_plan`、`medical_visit_disease`。
- **用药与慢病**：`users_medicine`、`users_medicine_plan`（频次规则用 `frequency_type` + `taking_info` JSONB 表达）、`users_disease`、`users_allergy` / `users_allergy_records`、`users_health_curve_plan`。
- **任务与消息**：`users_daily_task`、`sys_user_schedule_task_times`、`sys_user_message`、`ai_notice`（AI 主动关怀事件，`event_id` 唯一索引做幂等）。
- **AI 运行时**：`ai_conversation`、`ai_chat_message`（含 token 计数）、`ai_run_trace` / `ai_run_step`（每次 Agent 运行与每步事件的追踪）、`ai_model_provider` / `ai_agent_model`（Provider 配置与 `agent_key` → `provider_code` 绑定；两者之间**不建外键约束**，靠 `ModelConfigBootstrap` 在启动期维护绑定）。
- **后台**：`sys_admin`（BCrypt 密码、`failed_count` + `locked_until` 锁定）、`sys_config`、`sys_app`。

`users_model_config` 与 `ai_model_provider` / `ai_agent_model` 是两套并行的模型配置（前者按 `user_id` 存用户自带 key，后者是系统级 Provider + Agent 绑定），改模型相关逻辑时先确认改的是哪一套。

## 种子数据

- `02-seed.sql`：`sys_app` 里 `app_code='qmhealth_ai'` 那条记录（其 `security_key` 是 ai 请求 rust 的签名密钥，内置测试值，与 ai 镜像的 `qmhealth.security_key` 默认值相同）、内置管理员 `admin`（默认密码 `admin123`）、以及四条 `ai_agent_model` 绑定，后者的 `provider_code` 故意留空，由 `ModelConfigBootstrap` 启动时补齐。
- `03-sys_health_indicators.sql` / `04-sys_health_indicators_config.sql`：指标字典与前端配置，逐行 `INSERT`。注意 `03` 里部分指标（如 `bmi`、`whr`）的 `is_deleted` 为 1，属有意下线而非错误。

两张表通过 `indicator_code` 关联，新增指标需同时补 `03` 和 `04`（`04` 的 `pk_id` 手工指定，追加时顺延最大值）。
