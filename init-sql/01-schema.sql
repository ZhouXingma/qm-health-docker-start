create table users
(
    pk_id          bigserial    not null primary key,
    id             varchar(36)  not null,
    nickname       varchar(60)  not null,
    name           varchar(100) null,
    gender         smallint     null,
    birthday       date         null,
    status         smallint              default 0,
    certification  smallint              default 0,
    header_img     varchar(100) null,
    job            varchar(100) NULL,
    city           varchar(100) NULL,
    blood          smallint     NULL,
    blood_rh       smallint     NULL,
    nationality    smallint     NULL,
    marital_status smallint     NULL,
    gmt_created    timestamp    not null,
    gmt_modified   timestamp    not null,
    gmt_deleted    timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted     smallint              default 0
);
create index idx_users_id on users (id);
comment on table users is '用户表';
comment on column users.id is '用户id';
comment on column users.name is '姓名';
comment on column users.nickname is '昵称';
comment on column users.gender is '性别 1:男，2:女';
comment on column users.birthday is '生日';
comment on column users.status is '用户状态';
comment on column users.certification is '实名认证，0:否，1：是';
comment on column users.header_img is '用户头像信息';
comment on column users.job is '工作';
comment on column users.city is '城市';
comment on column users.blood is '血型';
comment on column users.blood_rh is '血型-rh';
comment on column users.nationality is '民族';
comment on column users.marital_status is '婚姻状况';
comment on column users.gmt_created is '创建时间';
comment on column users.gmt_modified is '修改时间';
comment on column users.gmt_deleted is '删除时间';
comment on column users.is_deleted is '是否删除，0否，1是';



create table users_concat
(
    pk_id        bigserial    not null primary key,
    id           varchar(36)  not null,
    user_id      varchar(36)  not null,
    concat_type  smallint     not null,
    concat_value varchar(100) not null,
    gmt_created  timestamp    not null,
    gmt_modified timestamp    not null,
    gmt_deleted  timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted   smallint              default 0
);
create index idx_users_concat_id on users_concat (id);
create index idx_users_concat_user_id on users_concat (user_id);
create index idx_users_concat_concat_value on users_concat (concat_value);
comment on table users_concat is '用户联系方式';
comment on column users_concat.id is 'id';
comment on column users_concat.user_id is '用户id';
comment on column users_concat.concat_type is '联系方式类型';
comment on column users_concat.concat_value is '联系内容';
comment on column users_concat.gmt_created is '创建时间';
comment on column users_concat.gmt_modified is '修改时间';
comment on column users_concat.gmt_deleted is '删除时间';
comment on column users_concat.is_deleted is '是否删除，0否，1是';


create table users_identity
(
    pk_id          bigserial    not null primary key,
    id             varchar(36)  not null,
    user_id        varchar(36)  not null,
    identity_type  smallint     not null,
    identity_value varchar(200) not null,
    identity_other varchar(500) not null,
    gmt_created    timestamp    not null,
    gmt_modified   timestamp    not null,
    gmt_deleted    timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted     smallint              default 0
);
create index idx_users_identity_id on users_identity (id);
create index idx_users_identity_user_id on users_identity (user_id);
create index idx_users_identity_identity_value on users_identity (identity_value);
comment on table users_identity is '用户身份标识，身份证，医保编码，其它证件等信息';
comment on column users_identity.id is 'id';
comment on column users_identity.user_id is '用户id';
comment on column users_identity.identity_type is '标识类型';
comment on column users_identity.identity_value is '标识值';
comment on column users_identity.identity_other is '标识的其它信息';
comment on column users_identity.gmt_created is '创建时间';
comment on column users_identity.gmt_modified is '修改时间';
comment on column users_identity.gmt_deleted is '删除时间';
comment on column users_identity.is_deleted is '是否删除，0否，1是';



create table users_auth
(
    pk_id        bigserial    not null primary key,
    user_id      varchar(36)  not null,
    auth_type    varchar(20)  not null,
    auth_value   varchar(300) not null,
    open_id      varchar(200) null,
    auth_other   varchar(500) null,
    gmt_created  timestamp    not null,
    gmt_modified timestamp    not null,
    gmt_deleted  timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted   smallint              default 0
);
create index idx_user_auth_user_id on users_auth (user_id);
create index idx_user_auth_user_id_auth_type on users_auth (user_id, auth_type);
comment on table users_auth is '用户身份验证，第三方登录等';
comment on column users_auth.user_id is '用户id';
comment on column users_auth.auth_type is '站内登录类型 (密码) 或第三方应用名称 (微信, 微博等)';
comment on column users_auth.auth_value is '站内账号是密码, 第三方登录是token等';
comment on column users_auth.open_id is '第三方应用的唯一标识';
comment on column users_auth.auth_other is '身份验证其它信息';
comment on column users_auth.gmt_created is '创建时间';
comment on column users_auth.gmt_modified is '修改时间';
comment on column users_auth.gmt_deleted is '删除时间';
comment on column users_auth.is_deleted is '是否删除，0否，1是';


create table sys_files
(
    pk_id               bigserial    not null primary key,
    id                  varchar(36)  not null,
    user_id             varchar(36)  null,
    file_name           varchar(100) not null,
    file_path           varchar(300) not null,
    file_source_name    varchar(300) not null,
    file_size           bigint       not null,
    file_type           varchar(20)  not null,
    source_code         varchar(20)  not null,
    file_temp_id        varchar(36)  null,
    temp_id_expire_time timestamp    null,
    file_hash           varchar(64)  null,
    gmt_created         timestamp    not null,
    gmt_modified        timestamp    not null,
    gmt_deleted         timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted          smallint              default 0
);
create unique index idx_sys_files_id on sys_files (id);
create index idx_sys_files_user_id on sys_files (user_id);
create index idx_sys_files_file_hash on sys_files (file_hash);
comment on table sys_files is '系统文件';
comment on column sys_files.id is 'id';
comment on column sys_files.user_id is '上传用户id';
comment on column sys_files.file_name is '文件名字';
comment on column sys_files.file_path is '文件路径';
comment on column sys_files.file_source_name is '原文件名称';
comment on column sys_files.file_size is '文件大小';
comment on column sys_files.file_type is '文件类型';
comment on column sys_files.source_code is '文件来源编码';
comment on column sys_files.file_temp_id is '文件临时id';
comment on column sys_files.temp_id_expire_time is '临时文件的过期时间';
comment on column sys_files.file_hash is '文件哈希（用于秒传去重）';
comment on column sys_files.gmt_created is '创建时间';
comment on column sys_files.gmt_modified is '修改时间';
comment on column sys_files.gmt_deleted is '删除时间';
comment on column sys_files.is_deleted is '是否删除，0否，1是';



create table users_health_indicator
(
    pk_id            bigserial    not null primary key,
    id               varchar(36)  not null,
    user_id          varchar(36)  not null,
    indicator_code   varchar(36)  not null,
    indicator_value  VARCHAR(255) NULL,
    reference_range  varchar(100) null,
    indicator_status varchar(32)  null,
    hospital_name    VARCHAR(100) null,
    data_source      VARCHAR(20)  not null,
    measure_time     timestamp    not null,
    file_id          varchar(64)[]  null,
    label            smallint  null,
    other_label      smallint  null,
    other_desc       varchar(100)  null,
    biz_id           varchar(36)  null,
    gmt_created      timestamp    not null,
    gmt_modified     timestamp    not null,
    gmt_deleted      timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted       smallint              default 0
);
create unique index idx_users_health_indicator_id on users_health_indicator (id);
create index idx_users_health_indicator_user_id on users_health_indicator (user_id);
create index idx_users_health_indicator_indicator_code on users_health_indicator (indicator_code);
comment on table users_health_indicator is '用户健康指标';
comment on column users_health_indicator.id is 'id';
comment on column users_health_indicator.user_id is '用户id';
comment on column users_health_indicator.indicator_code is '编码';
comment on column users_health_indicator.indicator_value is '结果';
comment on column users_health_indicator.reference_range is '正常范围描述-原始';
comment on column users_health_indicator.indicator_status is '指标状态';
comment on column users_health_indicator.hospital_name is '医院名称';
comment on column users_health_indicator.data_source is '数据来源';
comment on column users_health_indicator.file_id is '文件id数组';
comment on column users_health_indicator.label is '标签';
comment on column users_health_indicator.other_label is '其它标签';
comment on column users_health_indicator.other_desc is '其它描述';
comment on column users_health_indicator.measure_time is '检测时间';
comment on column users_health_indicator.biz_id is '业务id';
comment on column users_health_indicator.gmt_created is '创建时间';
comment on column users_health_indicator.gmt_modified is '修改时间';
comment on column users_health_indicator.gmt_deleted is '删除时间';
comment on column users_health_indicator.is_deleted is '是否删除，0否，1是';



CREATE TABLE sys_health_indicators
(
    pk_id          bigserial     not null primary key,
    indicator_code VARCHAR(64)   NOT NULL,
    indicator_name VARCHAR(64)   NOT NULL,
    indicator_code_en VARCHAR(64)[],
    category_code  VARCHAR(64)   NOT NULL,
    category_name  VARCHAR(64)   NOT NULL,
    unit           VARCHAR(64),
    result_type    smallint NOT NULL,
    description    varchar(200),
    gmt_created    timestamp     not null,
    gmt_modified   timestamp     not null,
    gmt_deleted    timestamp     not null default '9999-12-31 23:59:59.999999',
    is_deleted     smallint               default 0
);
create unique index idx_sys_health_indicators_indicator_code on sys_health_indicators (indicator_code);
create index idx_sys_health_indicators_category_code on sys_health_indicators (category_code);
create index idx_sys_health_indicators_indicator_code_en on sys_health_indicators using gin(indicator_code_en);
comment on table sys_health_indicators is '用户健康指标';
comment on column sys_health_indicators.indicator_code is '指标编码';
comment on column sys_health_indicators.indicator_name is '指标名称';
comment on column sys_health_indicators.indicator_code_en is '指标英文编码';
comment on column sys_health_indicators.category_code is '分类编码';
comment on column sys_health_indicators.category_name is '分类名称';
comment on column sys_health_indicators.unit is '默认单位';
comment on column sys_health_indicators.result_type is '数值类型';
comment on column sys_health_indicators.description is '描述信息';
comment on column sys_health_indicators.gmt_created is '创建时间';
comment on column sys_health_indicators.gmt_modified is '修改时间';
comment on column sys_health_indicators.gmt_deleted is '删除时间';
comment on column sys_health_indicators.is_deleted is '是否删除，0否，1是';



create table users_tag
(
    pk_id            bigserial    not null primary key,
    id               varchar(36)  not null,
    user_id          varchar(36)  not null,
    tag_type         varchar(36)  not null,
    tag_name         varchar(36) not null,
    gmt_created      timestamp    not null,
    gmt_modified     timestamp    not null,
    gmt_deleted      timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted       smallint              default 0
);
create unique index idx_users_tag_id on users_tag (id);
create index idx_users_tag_user_id on users_tag (user_id);
comment on table users_tag is '用户标签';
comment on column users_tag.id is 'id';
comment on column users_tag.user_id is '用户id';
comment on column users_tag.tag_type is '标签类型';
comment on column users_tag.tag_name is '标签名称';
comment on column users_tag.gmt_created is '创建时间';
comment on column users_tag.gmt_modified is '修改时间';
comment on column users_tag.gmt_deleted is '删除时间';
comment on column users_tag.is_deleted is '是否删除，0否，1是';





create table users_disease
(
    pk_id               bigserial    not null primary key,
    id                  varchar(36)  not null,
    user_id             varchar(36)  not null,
    name                varchar(100) not null,
    first_visit_time    date         null,
    severity            smallint     not null,
    status              smallint     not null,
    doctor              varchar(26)  null,
    hospital            varchar(100) null,
    followup_visit_time date         null,
    treatment           varchar(300) null,
    remarks             varchar(300) null,
    gmt_created         timestamp    not null,
    gmt_modified        timestamp    not null,
    gmt_deleted         timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted          smallint              default 0
);
create unique index idx_users_disease_id on users_disease (id);
create index idx_users_disease_user_id on users_disease (user_id);
comment on table users_disease is '用户疾病信息';
comment on column users_disease.id is 'id';
comment on column users_disease.user_id is '用户id';
comment on column users_disease.name is '疾病名称';
comment on column users_disease.first_visit_time is '首次确诊时间';
comment on column users_disease.severity is '严重程度';
comment on column users_disease.status is '当前状态';
comment on column users_disease.doctor is '主治医生';
comment on column users_disease.hospital is '医院';
comment on column users_disease.followup_visit_time is '复诊时间';
comment on column users_disease.treatment is '治疗计划';
comment on column users_disease.remarks is '备注信息';
comment on column users_disease.gmt_created is '创建时间';
comment on column users_disease.gmt_modified is '修改时间';
comment on column users_disease.gmt_deleted is '删除时间';
comment on column users_disease.is_deleted is '是否删除，0否，1是';



-- 创建用户服药信息表
CREATE TABLE users_medicine
(
    pk_id              bigserial    NOT NULL PRIMARY KEY,
    id                 varchar(36)  NOT NULL,
    user_id            varchar(36)  NOT NULL,
    medicine_name      varchar(100) NOT NULL,
    medicine_id        varchar(36)  NULL,
    dose               varchar(50)  NULL,
    dose_unit          varchar(20)  NULL,
    specification      varchar(100) NULL,
    specification_unit varchar(20)  NULL,
    remarks            varchar(300) NULL,
    taking_time        timestamp    NULL,
    adverse_reactions  varchar(500) NULL,
    gmt_created        timestamp    NOT NULL,
    gmt_modified       timestamp    NOT NULL,
    gmt_deleted        timestamp    NOT NULL default '9999-12-31 23:59:59.999999',
    is_deleted         smallint              DEFAULT 0
);

-- 创建索引
CREATE UNIQUE INDEX idx_users_medicine_id ON users_medicine (id);
CREATE INDEX idx_users_medicine_user_id ON users_medicine (user_id);
-- 为按月份查询优化：复合索引(user_id, is_deleted, taking_time)
CREATE INDEX idx_users_medicine_user_taking_time ON users_medicine (user_id, is_deleted, taking_time);

-- 添加表和字段注释
COMMENT ON TABLE users_medicine IS '用户服药信息';
COMMENT ON COLUMN users_medicine.id IS 'ID';
COMMENT ON COLUMN users_medicine.user_id IS '用户ID';
COMMENT ON COLUMN users_medicine.medicine_name IS '药品名称';
COMMENT ON COLUMN users_medicine.medicine_id IS '药品id';
COMMENT ON COLUMN users_medicine.dose IS '剂量';
COMMENT ON COLUMN users_medicine.dose_unit IS '剂量单位';
COMMENT ON COLUMN users_medicine.specification IS '规格';
COMMENT ON COLUMN users_medicine.specification_unit IS '规格单位';
COMMENT ON COLUMN users_medicine.remarks IS '备注';
COMMENT ON COLUMN users_medicine.taking_time IS '用药时间';
COMMENT ON COLUMN users_medicine.adverse_reactions IS '不良反应';
COMMENT ON COLUMN users_medicine.gmt_created IS '创建时间';
COMMENT ON COLUMN users_medicine.gmt_modified IS '修改时间';
COMMENT ON COLUMN users_medicine.gmt_deleted IS '删除时间';
COMMENT ON COLUMN users_medicine.is_deleted IS '是否删除，0否，1是';




create table users_allergy
(
    pk_id        bigserial    not null primary key,
    id           varchar(36)  not null,
    user_id      varchar(36)  not null,
    name         varchar(100) not null,
    severity     smallint     null,
    treatment    varchar(300) null,
    remarks      varchar(300) null,
    gmt_created  timestamp    not null,
    gmt_modified timestamp    not null,
    gmt_deleted  timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted   smallint              default 0
);
create unique index idx_users_allergy_id on users_allergy (id);
create index idx_users_allergy_user_id on users_allergy (user_id);
comment on table users_allergy is '用户过敏源信息';
comment on column users_allergy.id is 'id';
comment on column users_allergy.user_id is '用户id';
comment on column users_allergy.name is '过敏源名称';
comment on column users_allergy.severity is '严重程度';
comment on column users_allergy.treatment is '治疗/缓解方案';
comment on column users_allergy.remarks is '备注信息';
comment on column users_allergy.gmt_created is '创建时间';
comment on column users_allergy.gmt_modified is '修改时间';
comment on column users_allergy.gmt_deleted is '删除时间';
comment on column users_allergy.is_deleted is '是否删除，0否，1是';


create table users_allergy_records
(
    pk_id              bigserial    not null primary key,
    id                 varchar(36)  not null,
    user_id            varchar(36)  not null,
    allergy_id         varchar(36)  not null,
    onset_time         timestamp    not null,
    symptoms           varchar(500) null,
    severity           smallint     null,
    treatment_method   varchar(300) null,
    remarks            varchar(300) null,
    gmt_created        timestamp    not null,
    gmt_modified       timestamp    not null,
    gmt_deleted        timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted         smallint              default 0
);

create unique index idx_users_allergy_records_id on users_allergy_records (id);
create index idx_users_allergy_records_user_id on users_allergy_records (user_id);
create index idx_users_allergy_records_allergy_id on users_allergy_records (allergy_id);
create index idx_users_allergy_records_onset_time on users_allergy_records (onset_time);

comment on table users_allergy_records is '用户过敏记录';
comment on column users_allergy_records.id is 'id';
comment on column users_allergy_records.user_id is '用户id';
comment on column users_allergy_records.allergy_id is '过敏源id，关联users_allergy表';
comment on column users_allergy_records.onset_time is '过敏发作时间';
comment on column users_allergy_records.symptoms is '过敏症状描述';
comment on column users_allergy_records.severity is '严重程度';
comment on column users_allergy_records.treatment_method is '治疗/缓解方式';
comment on column users_allergy_records.remarks is '备注信息';
comment on column users_allergy_records.gmt_created is '创建时间';
comment on column users_allergy_records.gmt_modified is '修改时间';
comment on column users_allergy_records.gmt_deleted is '删除时间';
comment on column users_allergy_records.is_deleted is '是否删除，0否，1是';



CREATE TABLE sys_health_indicators_config
(
    pk_id          bigserial     not null primary key,
    indicator_code VARCHAR(64)   NOT NULL,
    config_info    text          not null,
    gmt_created    timestamp     not null,
    gmt_modified   timestamp     not null,
    gmt_deleted    timestamp     not null default '9999-12-31 23:59:59.999999',
    is_deleted     smallint               default 0
);
create unique index idx_sys_health_indicators_config_indicator_code on sys_health_indicators_config (indicator_code);
comment on table sys_health_indicators_config is '健康指标配置信息';
comment on column sys_health_indicators_config.indicator_code is '指标编码';
comment on column sys_health_indicators_config.config_info is '配置信息';
comment on column sys_health_indicators_config.gmt_created is '创建时间';
comment on column sys_health_indicators_config.gmt_modified is '修改时间';
comment on column sys_health_indicators_config.gmt_deleted is '删除时间';
comment on column sys_health_indicators_config.is_deleted is '是否删除，0否，1是';







CREATE TABLE users_health_curve_plan
(
    pk_id         bigserial    not null primary key,
    id            varchar(36)  not null,
    user_id       varchar(36)  not null,
    start_height  varchar(10)  not null,
    start_weight  varchar(10)  not null,
    target_weight varchar(10)  not null,
    plan_duration smallint     not null,
    plan_type     smallint     not null,
    plan          text         null,
    plan_desc     varchar(100) null,
    data_source   varchar(36)   not null,
    status_code   smallint     not null,
    start_date    timestamp    not null,
    end_date      timestamp    not null,
    gmt_created   timestamp    not null,
    gmt_modified  timestamp    not null,
    gmt_deleted   timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted    smallint              default 0
);
create unique index idx_users_health_curve_plan_id on users_health_curve_plan (id);
create index idx_users_health_curve_plan_user_id on users_health_curve_plan (user_id);
comment on table users_health_curve_plan is '健康曲线计划';
comment on column users_health_curve_plan.user_id is '用户id';
comment on column users_health_curve_plan.start_height is '开始身高';
comment on column users_health_curve_plan.start_weight is '开始体重';
comment on column users_health_curve_plan.target_weight is '目标体重';
comment on column users_health_curve_plan.plan_duration is '计划执行周数';
comment on column users_health_curve_plan.plan_type is '计划方案类型';
comment on column users_health_curve_plan.plan is '计划方案具体内容';
comment on column users_health_curve_plan.plan_desc is '计划备注描述';
comment on column users_health_curve_plan.data_source is '计划来源';
comment on column users_health_curve_plan.status_code is '计划状态';
comment on column users_health_curve_plan.start_date is '开始时间';
comment on column users_health_curve_plan.end_date is '结束时间';
comment on column users_health_curve_plan.gmt_created is '创建时间';
comment on column users_health_curve_plan.gmt_modified is '修改时间';
comment on column users_health_curve_plan.gmt_deleted is '删除时间';
comment on column users_health_curve_plan.is_deleted is '是否删除，0否，1是';


CREATE TABLE users_metadata
(
    pk_id         bigserial    NOT NULL PRIMARY KEY,
    id            varchar(36)  NOT NULL,
    user_id       varchar(36)  NOT NULL,
    metadata_code  varchar(50)  NOT NULL,
    metadata_value varchar(500) NOT NULL,
    data_source    VARCHAR(20)  not null,
    biz_label        smallint  null,
    gmt_created   timestamp    NOT NULL,
    gmt_modified  timestamp    NOT NULL,
    gmt_deleted   timestamp    NOT NULL default '9999-12-31 23:59:59.999999',
    is_deleted    smallint              DEFAULT 0
);
create unique index idx_users_metadata_id on users_metadata (id);
CREATE UNIQUE INDEX idx_users_metadata_user_key ON users_metadata (user_id, metadata_code) WHERE is_deleted = 0;
CREATE INDEX idx_users_metadata_user_id ON users_metadata (user_id);
COMMENT ON TABLE users_metadata IS '用户元数据表（静态属性）';
COMMENT ON COLUMN users_metadata.user_id IS '用户ID';
COMMENT ON COLUMN users_metadata.metadata_code IS '元数据键（如 smoking_status）';
COMMENT ON COLUMN users_metadata.metadata_value IS '元数据值';
COMMENT ON COLUMN users_metadata.data_source IS '数据来源';
COMMENT ON COLUMN users_metadata.biz_label IS '业务发生来源';
COMMENT ON COLUMN users_metadata.is_deleted IS '是否删除，0否，1是';





CREATE TABLE users_metadata_records
(
    pk_id         bigserial    NOT NULL PRIMARY KEY,
    id            varchar(36)  NOT NULL,
    user_id       varchar(36)  NOT NULL,
    metadata_code  varchar(50)  NOT NULL,
    metadata_value varchar(500) NOT NULL,
    occurred_at   timestamp    NOT NULL,
    data_source   VARCHAR(20)   not null,
    biz_label        smallint  null,
    gmt_created   timestamp    NOT NULL,
    gmt_modified  timestamp    NOT NULL,
    gmt_deleted   timestamp    NOT NULL default '9999-12-31 23:59:59.999999',
    is_deleted    smallint              DEFAULT 0
);

-- 索引：按用户和记录类型快速查询
create unique index idx_users_metadata_records_id on users_metadata_records (id);
CREATE INDEX idx_users_metadata_records_user_code ON users_metadata_records (user_id, metadata_code);
COMMENT ON TABLE users_metadata_records IS '用户元数据记录表（动态事件）';
COMMENT ON COLUMN users_metadata_records.user_id IS '用户ID';
COMMENT ON COLUMN users_metadata_records.metadata_code IS '记录类型，如 surgery、allergy';
COMMENT ON COLUMN users_metadata_records.metadata_value IS '详细信息';
COMMENT ON COLUMN users_metadata_records.occurred_at IS '事件发生时间';
COMMENT ON COLUMN users_metadata_records.data_source IS '数据来源';
COMMENT ON COLUMN users_metadata_records.biz_label IS '业务发生来源';
COMMENT ON COLUMN users_metadata_records.is_deleted IS '是否删除，0否，1是';




CREATE TABLE users_water_intake_records
(
    id            varchar(36)  NOT NULL,
    user_id       varchar(36)  NOT NULL,
    intake_ml     integer      NOT NULL CHECK (intake_ml > 0),
    data_source   VARCHAR(20)   not null,
    biz_label        smallint  null,
    gmt_created   timestamp    NOT NULL,
    gmt_modified  timestamp    NOT NULL,
    gmt_deleted   timestamp    NOT NULL default '9999-12-31 23:59:59.999999',
    is_deleted    smallint              DEFAULT 0
) PARTITION BY RANGE (gmt_modified);

CREATE TABLE users_water_intake_records_2025_2028 PARTITION OF users_water_intake_records
    FOR VALUES FROM ('2025-01-01 00:00:00') TO ('2027-12-31 23:59:59');

create index idx_users_water_intake_records_id on users_water_intake_records (id);
create index idx_users_water_intake_records_gmt_modified_user_id on users_water_intake_records (gmt_modified,user_id);
comment on table users_water_intake_records is '用户饮水记录表';
COMMENT ON COLUMN users_water_intake_records.user_id IS '用户ID';
COMMENT ON COLUMN users_water_intake_records.intake_ml IS '记录类型,饮水数量';
COMMENT ON COLUMN users_water_intake_records.data_source IS '数据来源';
COMMENT ON COLUMN users_water_intake_records.biz_label IS '业务发生来源';
COMMENT ON COLUMN users_water_intake_records.is_deleted IS '是否删除，0否，1是';




create table medical_visit
(
    pk_id        bigserial    not null primary key,
    id           varchar(36)  not null,
    user_id      varchar(36)  not null,
    hospital     varchar(200) not null,                     -- 医院名称
    department   varchar(100) not null,                     -- 科室
    doctor_name  varchar(100) not null,                     -- 医生姓名
    visit_date   timestamp    not null,                     -- 就诊或预约日期
    symptom_description text   null,                        -- 症状描述（可为空）
    diagnosis    text         null,                         -- 诊断信息（可为空，预约时可能无）
    status       smallint     not null default 0,           -- 就诊状态：0=预约中，1=已就诊
    remarks      varchar(500) null,                         -- 备注
    gmt_created  timestamp    not null,
    gmt_modified timestamp    not null,
    gmt_deleted  timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted   smallint              default 0
);

create unique index idx_medical_visit_id on medical_visit (id);
create index idx_medical_visit_user_id on medical_visit (user_id);
create index idx_medical_visit_visit_date on medical_visit (visit_date);
create index idx_medical_visit_status on medical_visit (status);

comment on table medical_visit is '用户就诊记录（含预约和已就诊）';
comment on column medical_visit.id is '主键ID';
comment on column medical_visit.user_id is '用户ID';
comment on column medical_visit.hospital is '医院名称';
comment on column medical_visit.department is '科室';
comment on column medical_visit.doctor_name is '医生姓名';
comment on column medical_visit.visit_date is '就诊/预约日期时间';
comment on column medical_visit.symptom_description is '症状描述（可为空）';
comment on column medical_visit.diagnosis is '诊断结果（可为空）';
comment on column medical_visit.status is '就诊状态：0=预约中，1=已就诊';
comment on column medical_visit.remarks is '备注';
comment on column medical_visit.gmt_created is '创建时间';
comment on column medical_visit.gmt_modified is '最后修改时间';
comment on column medical_visit.gmt_deleted is '逻辑删除时间';
comment on column medical_visit.is_deleted is '是否删除：0=否，1=是';


create table medical_report
(
    pk_id        bigserial    not null primary key,
    id           varchar(36)  not null,
    visit_id     varchar(36)  not null,
    report_type  varchar(50)  not null,                     -- 报告类型：如 血常规、CT、MRI 等
    file_url     varchar(500) not null,                     -- 报告文件或图片的存储路径（OSS/S3等）
    file_name    varchar(200) not null,                     -- 原始文件名
    description  varchar(300) null,                         -- 报告简要描述
    is_image     smallint     not null default 0,           -- 是否图片：0=否，1=是
    gmt_created  timestamp    not null,
    gmt_modified timestamp    not null,
    gmt_deleted  timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted   smallint              default 0
);

create unique index idx_medical_report_id on medical_report (id);
create index idx_medical_report_visit_id on medical_report (visit_id);

comment on table medical_report is '就诊关联的检查/检验报告';
comment on column medical_report.visit_id is '关联的就诊记录ID';
comment on column medical_report.report_type is '报告类型';
comment on column medical_report.file_url is '报告文件URL（图片/PDF等）';
comment on column medical_report.file_name is '原始文件名';
comment on column medical_report.description is '报告说明';
comment on column medical_report.is_image is '是否图片：0=否，1=是';



create table medical_conversation
(
    pk_id        bigserial    not null primary key,
    id           varchar(36)  not null,
    visit_id     varchar(36)  not null,
    content      text         not null,                     -- 对话文本（录音转写后的内容）
    gmt_speak    timestamp    not null,                     -- 发言时间（按实际对话时间）
    gmt_created  timestamp    not null,
    gmt_modified timestamp    not null,
    gmt_deleted  timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted   smallint              default 0
);

create unique index idx_medical_conversation_id on medical_conversation (id);
create index idx_medical_conversation_visit_id on medical_conversation (visit_id);
create index idx_medical_conversation_gmt_speak on medical_conversation (gmt_speak);

comment on table medical_conversation is '医患对话记录（含录音转文本）';
comment on column medical_conversation.visit_id is '关联的就诊记录ID';
comment on column medical_conversation.content is '对话文本内容';
comment on column medical_conversation.gmt_speak is '实际对话发生时间';



create table medical_medicine_plan
(
    pk_id        bigserial    not null primary key,
    id           varchar(36)  not null,
    visit_id     varchar(36)  not null,
    medicine_name      varchar(100) NOT NULL,
    medicine_form      varchar(20)  NULL,           -- 剂型：片剂、胶囊、液体、软膏、乳液、注射液等
    specification      varchar(50)  NULL,           -- 规格数值（如：0.25、100、5）。注：若需参与数学计算建议改numeric，仅作展示varchar即可
    specification_unit varchar(20)  NULL,           -- 规格单位（如：g，片、ml，瓶、g，支）
    frequency_type     smallint     NOT NULL,       -- 频次模式：1-每天, 2-循环定时, 3-每周特定日, 4-每隔N天, 5-按需
    taking_info        jsonb        NULL,           -- 服药详情（JSON结构，根据frequency_type不同而不同）
    source_type        smallint     DEFAULT 1,      -- 来源类型：1-医院处方, 2-药店购买, 3-自行添加
    medical_advice     varchar(500) NULL,           -- 医嘱/备注（如：忌辛辣、饭后服用）
    medicine_id        varchar(36)  not null,
    gmt_created  timestamp    not null,
    gmt_modified timestamp    not null,
    gmt_deleted  timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted   smallint              default 0
);

create unique index idx_medical_medicine_plan_id on medical_medicine_plan (id);
create index idx_medical_medicine_plan_visit_id on medical_medicine_plan (visit_id);
create index idx_medical_medicine_plan_medicine_id on medical_medicine_plan (medicine_id);

comment on table medical_medicine_plan is '就诊关联的药品信息';
comment on column medical_medicine_plan.visit_id is '关联的就诊记录ID';
comment on column medical_medicine_plan.medicine_name is '药品名称';
comment on column medical_medicine_plan.medicine_form is '剂型';
comment on column medical_medicine_plan.specification is '规格数值';
comment on column medical_medicine_plan.specification_unit is '规格单位';
comment on column medical_medicine_plan.frequency_type is '频次模式';
comment on column medical_medicine_plan.taking_info is '服药详情';
comment on column medical_medicine_plan.source_type is '来源类型';
comment on column medical_medicine_plan.medical_advice is '医嘱/备注';
comment on column medical_medicine_plan.medicine_id is '用药计划的id';




create table ai_chat_message
(
    pk_id           bigserial    not null primary key,
    id              varchar(36)  not null,                     -- 提醒ID（UUID）
    conversation_id varchar(36)  not null,                     -- 会话ID
    run_id          varchar(36)  null,                         -- 单次会话id
    user_id         varchar(36)  null,                         -- 用户ID
    message         text         null,                         -- 聊天内容
    message_time    timestamp    not null,                     -- 消息时间
    role            varchar(36)  not null,                     -- 消息角色
    purpose         varchar(36)  not null,                      -- 用途
    message_index   integer      default  0,
    model           varchar(36)   null,                     -- 模型
    parent_id       varchar(36)  null,
    prompt_tokens   integer   null,
    completion_tokens   integer   null,
    total_tokens   integer   null,
    gmt_created     timestamp    not null,
    gmt_modified    timestamp    not null,
    gmt_deleted     timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted      smallint     not null default 0
);

-- 索引
create unique index idx_ai_chat_message_id on ai_chat_message (id);
create index idx_ai_chat_message_user_id on ai_chat_message (user_id);
create index idx_ai_chat_message_conversation_id on ai_chat_message (conversation_id);

-- 注释
comment on table ai_chat_message is 'AI聊天信息';
comment on column ai_chat_message.id is '消息id';
comment on column ai_chat_message.conversation_id is '会话id';
comment on column ai_chat_message.user_id is '用户id';
comment on column ai_chat_message.run_id is '单次会话id';
comment on column ai_chat_message.message is '聊天内容';
comment on column ai_chat_message.message_time is '消息时间';
comment on column ai_chat_message.role is '角色';
comment on column ai_chat_message.purpose is '用途';
comment on column ai_chat_message.message_index is '消息位';
comment on column ai_chat_message.model is '使用模型';
comment on column ai_chat_message.parent_id is '父消息id';
comment on column ai_chat_message.prompt_tokens is '提示词token消息';
comment on column ai_chat_message.completion_tokens is '输出token消息';
comment on column ai_chat_message.total_tokens is '总共token消息';


create table ai_conversation
(
    pk_id           bigserial    not null primary key,
    id              varchar(36)  not null,                     -- 提醒ID（UUID）
    user_id         varchar(36)  null,                         -- 用户ID
    title           varchar(100)  not null,                     -- 聊天标题
    gmt_active      timestamp    not null,
    gmt_created     timestamp    not null,
    gmt_modified    timestamp    not null,
    gmt_deleted     timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted      smallint     not null default 0
);
create unique index idx_ai_conversation_id on ai_conversation (id);
create index idx_ai_conversation_user_id on ai_conversation (user_id);

comment on table ai_conversation is 'AI聊天会话信息';
comment on column ai_conversation.id is '会话id';
comment on column ai_conversation.user_id is '用户ID';
comment on column ai_conversation.gmt_active is '最后激活时间';


create table medical_visit_disease
(
    pk_id        bigserial   not null primary key,
    id           varchar(36) not null,
    user_id      varchar(36) not null,
    visit_id     varchar(36) not null, -- 就诊记录id
    disease_id   varchar(36) not null, -- 疾病id
    disease_name varchar(100) not null,  -- 疾病名称
    severity     smallint    not null, -- 疾病严重程度
    status       smallint    not null, -- 疾病状态
    gmt_created  timestamp   not null,
    gmt_modified timestamp   not null,
    gmt_deleted  timestamp   not null default '9999-12-31 23:59:59.999999',
    is_deleted   smallint             default 0
);

create unique index idx_medical_visit_disease_id on medical_visit_disease (id);
create index idx_medical_visit_disease_user_id on medical_visit_disease (user_id);
create index idx_medical_visit_disease_visit_id on medical_visit_disease (visit_id);
create index idx_medical_visit_disease_disease_id on medical_visit_disease (disease_id);

comment on table medical_visit_disease is '就诊记录和疾病的关系表';
comment on column medical_visit_disease.id is '主键ID';
comment on column medical_visit_disease.user_id is '用户ID';
comment on column medical_visit_disease.visit_id is '就诊记录id';
comment on column medical_visit_disease.disease_id is '疾病id';
comment on column medical_visit_disease.disease_name is '疾病名称';
comment on column medical_visit_disease.severity is '疾病严重程度';
comment on column medical_visit_disease.status is '疾病状态';
comment on column medical_visit_disease.gmt_created is '创建时间';
comment on column medical_visit_disease.gmt_modified is '最后修改时间';
comment on column medical_visit_disease.gmt_deleted is '逻辑删除时间';
comment on column medical_visit_disease.is_deleted is '是否删除：0=否，1=是';



CREATE TABLE sys_app
(
    pk_id        bigserial    not null primary key,
    app_code     varchar(36)  not null,
    app_desc     varchar(100) null,
    security_key varchar(100) not null,
    config jsonb null,
    disabled     smallint              default 0 not null,
    gmt_created  timestamp    not null,
    gmt_modified timestamp    not null,
    gmt_deleted  timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted   smallint              default 0  not null
);
create unique index idx_sys_app_app_code on sys_app (app_code);
comment on table sys_app is '系统应用';
comment on column sys_app.app_code is '应用编码';
comment on column sys_app.app_desc is '应用描述';
comment on column sys_app.security_key is '安全密钥';
comment on column sys_app.config is '配置信息';
comment on column sys_app.disabled is '是否禁用，0:否，1:是';
comment on column sys_app.gmt_created is '创建时间';
comment on column sys_app.gmt_modified is '修改时间';
comment on column sys_app.gmt_deleted is '删除时间';
comment on column sys_app.is_deleted is '是否删除，0否，1是';



CREATE TABLE ai_notice
(
    pk_id         bigserial    not null primary key,
    id            varchar(36)  not null,
    message       text         not null,
    user_id       varchar(36)  not null,
    event_id      varchar(256) null,
    entity_type   varchar(64)  null,
    action        varchar(32)  null,
    record_id     varchar(64)  null,
    occurred_at   timestamp    null,
    handle_status smallint     default 0 not null,
    handle_time   timestamp    null,
    gmt_created   timestamp    not null,
    gmt_modified  timestamp    not null,
    gmt_deleted   timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted    smallint              default 0  not null
);
create unique index idx_ai_notice_id on ai_notice (id);
create index idx_ai_notice_user_id on ai_notice (user_id);
create index idx_ai_notice_uh on ai_notice (user_id, handle_status);
create index idx_ai_notice_gmt_modified on ai_notice (gmt_modified);
create unique index idx_ai_notice_event_id on ai_notice (event_id) where event_id is not null;
create index idx_ai_notice_entity_lookup on ai_notice (user_id, entity_type, record_id);
comment on table ai_notice is 'AI主动关怀事件表';
comment on column ai_notice.message is '提醒消息';
comment on column ai_notice.user_id is '用户id';
comment on column ai_notice.event_id is '事件幂等键；相同event_id仅写入一次';
comment on column ai_notice.entity_type is '实体类型 Disease/Allergy/HealthIndicator/MedicalVisit/MedicalReport/MedicinePlan/Medicine/WaterIntake/UserBasic/UserTag/Metadata/MetadataRecord/FamilyHistory/HealthCurvePlan/DailyTaskGeneration';
comment on column ai_notice.action is '动作类型 Created/Updated/Deleted';
comment on column ai_notice.record_id is '实体记录id';
comment on column ai_notice.occurred_at is '业务发生时间（用户侧时间，可能晚于事件触发时间，例如补录）';
comment on column ai_notice.handle_status is '处理状态 0:未处理/重试，1:已完成，2:处理中';
comment on column ai_notice.handle_time is '处理完成时间';
comment on column ai_notice.gmt_created is '创建时间';
comment on column ai_notice.gmt_modified is '修改时间';
comment on column ai_notice.gmt_deleted is '删除时间';
comment on column ai_notice.is_deleted is '是否删除，0否，1是';


create table users_daily_task
(
    pk_id            bigserial    not null primary key,
    id               varchar(36)  not null,
    user_id          varchar(36)  not null,
    task_type        smallint     not null,           -- 任务类型
    task_desc        varchar(100),                    -- 任务描述
    target_value     varchar(100),                    -- 目标值
    current_value    varchar(100),                    -- 当前完成值
    task_date        date         not null,           -- 任务所属日期
    plan_start_time  timestamp,                       -- 计划开始时间
    plan_end_time    timestamp,                       -- 计划结束时间
    completed_time   timestamp,                       -- 完成时间
    status           smallint     not null,           -- 完成状态
    priority         smallint     not null default 3, -- 优先级
    ext_json         jsonb,                           -- 扩展信息
    task_source      varchar(100),                    -- 任务来源
    gmt_created      timestamp    not null,
    gmt_modified     timestamp    not null,
    gmt_deleted      timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted       smallint              default 0
);
comment on table users_daily_task is '用户每天任务';
create unique index idx_users_daily_task_id on users_daily_task (id);
create index idx_users_daily_task_user_id on users_daily_task (user_id);
create index idx_users_daily_task_date on users_daily_task (user_id, task_date);
create index idx_users_daily_task_status on users_daily_task (status);
create index idx_users_daily_task_type on users_daily_task (task_type);

CREATE TABLE sys_user_message
(
    pk_id           bigserial    not null primary key,
    id              varchar(36)  not null,
    sender_id       varchar(36)  null,
    sender_type     varchar(20)  not null default 'system',
    receiver_id     varchar(36)  not null,
    msg_title       varchar(150) not null,
    msg_content     text         not null,
    is_read         smallint              default 0 not null,
    gmt_read        timestamp    null,
    redirect_type   varchar(50)  null,
    redirect_params jsonb        null,
    disabled        smallint              default 0 not null,
    gmt_created     timestamp    not null,
    gmt_modified    timestamp    not null,
    gmt_deleted     timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted      smallint              default 0 not null
);

-- 唯一索引（针对业务ID）
create unique index idx_sys_user_msg_id on sys_user_message (id);
-- 常用查询索引优化：收件人+未读状态、创建时间（用于列表排序）
create index idx_sys_user_msg_receiver on sys_user_message (receiver_id, is_read);
create index idx_sys_user_msg_created  on sys_user_message (gmt_created);

-- 表与字段注释
comment on table sys_user_message is '用户站内信消息表';
comment on column sys_user_message.pk_id is '自增主键ID';
comment on column sys_user_message.id is '业务消息ID（如雪花ID/UUID）';
comment on column sys_user_message.sender_id is '发件人ID（系统/AI发送可为空）';
comment on column sys_user_message.sender_type is '发件人类型，例如：system:系统, ai:AI助手, user:普通用户';
comment on column sys_user_message.receiver_id is '收件人用户ID';
comment on column sys_user_message.msg_title is '消息标题';
comment on column sys_user_message.msg_content is '消息内容';
comment on column sys_user_message.is_read is '是否阅读，0:未读, 1:已读';
comment on column sys_user_message.gmt_read is '阅读时间';
comment on column sys_user_message.redirect_type is '跳转位置/类型（如：order_detail, user_center）';
comment on column sys_user_message.redirect_params is '跳转额外参数（JSON格式，如：{"order_id": "123"}）';
comment on column sys_user_message.disabled is '是否禁用，0:否，1:是';
comment on column sys_user_message.gmt_created is '发送时间/创建时间';
comment on column sys_user_message.gmt_modified is '修改时间';
comment on column sys_user_message.gmt_deleted is '删除时间';
comment on column sys_user_message.is_deleted is '是否删除，0否，1是';

-- 创建用户用药计划表
CREATE TABLE users_medicine_plan
(
    pk_id              bigserial    NOT NULL PRIMARY KEY,
    id                 varchar(36)  NOT NULL,
    user_id            varchar(36)  NOT NULL,
    medicine_name      varchar(100) NOT NULL,
    medicine_form      varchar(20)  NULL,           -- 剂型：片剂、胶囊、液体、软膏、乳液、注射液等
    specification      varchar(50)  NULL,           -- 规格数值（如：0.25、100、5）。注：若需参与数学计算建议改numeric，仅作展示varchar即可
    specification_unit varchar(20)  NULL,           -- 规格单位（如：g，片、ml，瓶、g，支）
    frequency_type     smallint     NOT NULL,       -- 频次模式：1-每天, 2-循环定时, 3-每周特定日, 4-每隔N天, 5-按需
    taking_info        jsonb        NULL,           -- 服药详情（JSON结构，根据frequency_type不同而不同）
    start_date         date         NOT NULL,       -- 计划开始日期
    end_date           date         NULL,           -- 计划结束日期（为空表示长期服药）
    source_type        smallint     DEFAULT 1,      -- 来源类型：1-医院处方, 2-药店购买, 3-自行添加
    medical_advice     varchar(500) NULL,           -- 医嘱/备注（如：忌辛辣、饭后服用）
    gmt_created        timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified       timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_deleted        timestamp    NOT NULL default '9999-12-31 23:59:59.999999',
    is_deleted         smallint     DEFAULT 0
);
CREATE UNIQUE INDEX idx_plan_id ON users_medicine_plan (id);
CREATE INDEX idx_plan_user_id ON users_medicine_plan (user_id);
CREATE INDEX idx_plan_task_gen ON users_medicine_plan (start_date, end_date)
    WHERE is_deleted = 0;
CREATE INDEX idx_plan_medicine_name ON users_medicine_plan (medicine_name);
COMMENT ON TABLE users_medicine_plan IS '用户用药计划表（核心频次规则采用JSONB存储）';
COMMENT ON COLUMN users_medicine_plan.pk_id IS '物理主键';
COMMENT ON COLUMN users_medicine_plan.id IS '业务主键(UUID)';
COMMENT ON COLUMN users_medicine_plan.user_id IS '用户ID';
COMMENT ON COLUMN users_medicine_plan.medicine_name IS '药品名称';
COMMENT ON COLUMN users_medicine_plan.medicine_form IS '剂型（片剂、胶囊、液体、软膏等）';
COMMENT ON COLUMN users_medicine_plan.specification IS '规格数值（如0.25）';
COMMENT ON COLUMN users_medicine_plan.specification_unit IS '规格单位（如g/片、ml/瓶）';
COMMENT ON COLUMN users_medicine_plan.frequency_type IS '频次模式：1-每天, 2-循环定时, 3-每周特定日, 4-每隔N天, 5-按需';
COMMENT ON COLUMN users_medicine_plan.taking_info IS '服药详情JSON';
COMMENT ON COLUMN users_medicine_plan.start_date IS '计划开始日期';
COMMENT ON COLUMN users_medicine_plan.end_date IS '计划结束日期（NULL表示长期）';
COMMENT ON COLUMN users_medicine_plan.source_type IS '来源：1-医院处方, 2-药店, 3-自行添加';
COMMENT ON COLUMN users_medicine_plan.medical_advice IS '医嘱/备注';
COMMENT ON COLUMN users_medicine_plan.gmt_created IS '创建时间';
COMMENT ON COLUMN users_medicine_plan.gmt_modified IS '修改时间';
COMMENT ON COLUMN users_medicine_plan.gmt_deleted IS '删除时间（逻辑删除标记）';
COMMENT ON COLUMN users_medicine_plan.is_deleted IS '是否删除：0-否, 1-是';



create table sys_user_schedule_task_times
(
    pk_id          bigserial    not null primary key,
    id             varchar(36)  not null,
    user_id        varchar(36)  not null,
    task_type      varchar(36)  not null,
    recent_time    timestamp    not null,
    next_time      timestamp    not null,
    gmt_created    timestamp    not null,
    gmt_modified   timestamp    not null,
    gmt_deleted    timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted     smallint              default 0
);
create index idx_sys_user_schedule_task_times_id on sys_user_schedule_task_times (id);
create index idx_sys_user_schedule_task_times_user_id on sys_user_schedule_task_times (user_id);
create index idx_sys_user_schedule_task_times_u1 on sys_user_schedule_task_times (user_id, task_type, next_time);
comment on table sys_user_schedule_task_times is '用户定时任务，执行时间表';
comment on column sys_user_schedule_task_times.id is 'id';
comment on column sys_user_schedule_task_times.user_id is '用户id';
comment on column sys_user_schedule_task_times.task_type is '任务类型';
comment on column sys_user_schedule_task_times.recent_time is '最近执行时间';
comment on column sys_user_schedule_task_times.next_time is '下次执行时间';
comment on column sys_user_schedule_task_times.gmt_created is '创建时间';
comment on column sys_user_schedule_task_times.gmt_modified is '修改时间';
comment on column sys_user_schedule_task_times.gmt_deleted is '删除时间';
comment on column sys_user_schedule_task_times.is_deleted is '是否删除，0否，1是';




create table sys_user_config
(
    pk_id          bigserial    not null primary key,
    id             varchar(36)  not null,
    user_id        varchar(36)  not null,
    auto_create_daily_task bool default true not null,
    gmt_modified   timestamp    not null,
    gmt_deleted    timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted     smallint              default 0
);
create index idx_sys_user_config_id on sys_user_config (id);
create index idx_sys_user_config_user_id on sys_user_config (user_id);
comment on table sys_user_config is '用户定时任务，执行时间表';
comment on column sys_user_config.id is 'id';
comment on column sys_user_config.user_id is '用户id';
comment on column sys_user_config.auto_create_daily_task is '自动创建每日任务';
comment on column sys_user_config.gmt_modified is '修改时间';
comment on column sys_user_config.gmt_deleted is '删除时间';
comment on column sys_user_config.is_deleted is '是否删除，0否，1是';



create table users_model_config
(
    pk_id            bigserial    not null primary key,
    id               varchar(36)  not null,                          -- 业务ID（UUID）
    user_id          varchar(36)  not null,                          -- 用户id
    model_type       varchar(36)  not null,                          -- 模型类型：deepseek/openai/glm/kimi/minimax 等
    model_name       varchar(100) not null,                          -- 模型名称（如 deepseek-chat、gpt-4o、glm-4-plus 等）
    base_url         varchar(300) not null,                          -- 模型请求地址
    api_key          varchar(500) not null,                          -- 模型访问密钥
    purpose          smallint              default 1 not null,      -- 用途：1=主模型，2=OCR，3=标题生成
    is_multimodal    smallint              default 0 not null,      -- 是否支持多模态：0否，1是
    enabled          smallint              default 1 not null,      -- 是否启用：0禁用，1启用
    extra_config     jsonb                 null,                     -- 扩展配置（jsonb）：如 timeout_seconds/max_tokens/temperature/is_default 等
    remarks          varchar(300)          null,                     -- 备注信息
    gmt_created      timestamp    not null,
    gmt_modified     timestamp    not null,
    gmt_deleted      timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted       smallint              default 0
);
create unique index idx_users_model_config_id on users_model_config (id);
create index idx_users_model_config_user_id on users_model_config (user_id);
create index idx_users_model_config_user_type on users_model_config (user_id, model_type);
create index idx_users_model_config_model_name on users_model_config (model_name);
comment on table users_model_config is '用户模型访问配置表';
comment on column users_model_config.id is '业务主键ID';
comment on column users_model_config.user_id is '用户ID';
comment on column users_model_config.model_type is '模型类型：deepseek/openai/glm/kimi/minimax';
comment on column users_model_config.model_name is '模型名称';
comment on column users_model_config.base_url is '模型请求地址';
comment on column users_model_config.api_key is '模型访问密钥';
comment on column users_model_config.purpose is '用途：1=主模型，2=OCR，3=标题生成';
comment on column users_model_config.is_multimodal is '是否支持多模态：0否，1是';
comment on column users_model_config.enabled is '是否启用：0禁用，1启用';
comment on column users_model_config.extra_config is '扩展配置（jsonb）：如 timeout_seconds/max_tokens/temperature/is_default 等';
comment on column users_model_config.remarks is '备注信息';
comment on column users_model_config.gmt_created is '创建时间';
comment on column users_model_config.gmt_modified is '修改时间';
comment on column users_model_config.gmt_deleted is '删除时间';
comment on column users_model_config.is_deleted is '是否删除，0否，1是';




create table sys_config
(
    pk_id            bigserial    not null primary key,
    code             varchar(36)  not null,                          -- 配置编码
    sub_code         varchar(36)  not null,                          -- 子配置编码
    config           varchar(300) null,
    json_config     jsonb                 null,                     -- 扩展配置
    order_number     smallint     not null default 0,
    enabled          smallint              default 1 not null,      -- 是否启用：0禁用，1启用
    remarks          varchar(300)          null,                     -- 备注信息
    gmt_created      timestamp    not null,
    gmt_modified     timestamp    not null,
    gmt_deleted      timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted       smallint              default 0
);
create unique index idx_sys_config_code_subcode on sys_config(code, sub_code);
comment on table sys_config is '系统配置表';
comment on column sys_config.code is '配置编码';
comment on column sys_config.sub_code is '子配置编码';
comment on column sys_config.config is '普通配置信息';
comment on column sys_config.json_config is 'json配置信息';
comment on column sys_config.enabled is '是否启用：0禁用，1启用';
comment on column sys_config.remarks is '备注信息';
comment on column sys_config.gmt_created is '创建时间';
comment on column sys_config.gmt_modified is '修改时间';
comment on column sys_config.gmt_deleted is '删除时间';
comment on column sys_config.is_deleted is '是否删除，0否，1是';


create table ai_run_trace
(
    pk_id              bigserial    not null primary key,
    id                 varchar(36)  not null,
    conversation_id    varchar(36)  not null,
    parent_run_id      varchar(36)  null,
    user_id            varchar(36)  not null,
    agent_type         varchar(32)  not null,
    instance_id        varchar(36)  not null,
    mode               varchar(16)  null,
    model              varchar(64)  null,
    status             varchar(16)  not null,
    prompt_chars       int          null,
    skill_load_count   int          null,
    prompt_tokens      int          null,
    completion_tokens  int          null,
    cached_tokens      int          null,
    total_tokens       int          null,
    tool_call_count    int          not null default 0,
    model_call_count   int          not null default 0,
    start_at           timestamp    not null,
    end_at             timestamp    null,
    duration_ms        int          null,
    error_message      varchar(2000) null,
    gmt_created        timestamp    not null,
    gmt_modified       timestamp    not null,
    gmt_deleted        timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted         smallint              default 0
);

create unique index idx_ai_run_trace_id on ai_run_trace (id);
create index idx_ai_run_trace_conv on ai_run_trace (conversation_id);
create index idx_ai_run_trace_user on ai_run_trace (user_id, start_at desc);
create index idx_ai_run_trace_agent on ai_run_trace (agent_type, start_at desc);
create index idx_ai_run_trace_parent on ai_run_trace (parent_run_id);
create index idx_ai_run_trace_instance on ai_run_trace (instance_id);

comment on table ai_run_trace is 'AI 对话跟踪 - 运行总览（每次 Agent 运行一行）';
comment on column ai_run_trace.id is '运行 ID（ULID）';
comment on column ai_run_trace.conversation_id is '所属会话 ID';
comment on column ai_run_trace.parent_run_id is '父运行 ID（标题生成等子任务关联主 run）';
comment on column ai_run_trace.user_id is '用户 ID';
comment on column ai_run_trace.agent_type is 'Agent 类型：main / title / ocr / notice';
comment on column ai_run_trace.instance_id is '处理实例 ULID（分布式兼容）';
comment on column ai_run_trace.mode is '运行模式：response / proactive';
comment on column ai_run_trace.model is '使用的大模型名称';
comment on column ai_run_trace.status is '终态：RUNNING / COMPLETED / INTERRUPTED / ERROR / ABORTED';
comment on column ai_run_trace.prompt_chars is '系统提示词字符数';
comment on column ai_run_trace.skill_load_count is 'skill加载次数';
comment on column ai_run_trace.prompt_tokens is '累计输入 token';
comment on column ai_run_trace.completion_tokens is '累计输出 token';
comment on column ai_run_trace.cached_tokens is '累计缓存命中 token';
comment on column ai_run_trace.total_tokens is '累计总 token';
comment on column ai_run_trace.tool_call_count is '工具调用次数';
comment on column ai_run_trace.model_call_count is '模型调用次数';
comment on column ai_run_trace.start_at is '开始时间';
comment on column ai_run_trace.end_at is '结束时间';
comment on column ai_run_trace.duration_ms is '耗时毫秒';
comment on column ai_run_trace.error_message is '失败信息';



create table ai_run_step
(
    pk_id             bigserial    not null primary key,
    id                varchar(36)  not null,
    run_id            varchar(36)  not null,
    conversation_id   varchar(36)  not null,
    instance_id       varchar(36)  not null,
    seq               int          not null,
    type              varchar(32)  not null,
    block_id          varchar(64)  null,
    tool_call_id      varchar(64)  null,
    tool_call_name    varchar(64)  null,
    payload           text         null,
    input_tokens      int          null,
    output_tokens     int          null,
    cached_tokens     int          null,
    total_tokens      int          null,
    cost_ms           int          null,
    created_at        timestamp    not null,
    gmt_created       timestamp    not null,
    gmt_modified      timestamp    not null,
    gmt_deleted       timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted        smallint              default 0
);

create unique index idx_ai_run_step_id on ai_run_step (id);
create index idx_ai_run_step_run on ai_run_step (run_id, seq);
create index idx_ai_run_step_type on ai_run_step (type);
create index idx_ai_run_step_created on ai_run_step (created_at desc);
create index idx_ai_run_step_tool on ai_run_step (tool_call_name);

comment on table ai_run_step is 'AI 对话跟踪 - 步骤明细（每次 Agent 事件一行）';
comment on column ai_run_step.id is '事件 ULID（保证重复写入幂等）';
comment on column ai_run_step.run_id is '关联运行 ID（ai_run_trace.id）';
comment on column ai_run_step.conversation_id is '所属会话 ID';
comment on column ai_run_step.instance_id is '处理实例 ULID';
comment on column ai_run_step.seq is '事件在 run 内的顺序号';
comment on column ai_run_step.type is '事件类型：RUN_STARTED / PROMPT_LOADED / SKILLS_LOADED / TOOLS_REGISTERED / MODEL_CALL_START / MODEL_CALL_END / TOOL_CALL_START / TOOL_CALL_END / TOOL_RESULT / THINKING_END / TEXT_END / RUN_FINISHED';
comment on column ai_run_step.block_id is '流式块 ID';
comment on column ai_run_step.tool_call_id is '工具调用 ID';
comment on column ai_run_step.tool_call_name is '工具名称';
comment on column ai_run_step.payload is 'JSON 内容（args / result / thinking）';
comment on column ai_run_step.input_tokens is '本次模型调用输入 token';
comment on column ai_run_step.output_tokens is '本次模型调用输出 token';
comment on column ai_run_step.cached_tokens is '本次模型调用缓存命中 token';
comment on column ai_run_step.total_tokens is '本次模型调用总 token';
comment on column ai_run_step.cost_ms is '本步耗时毫秒';
comment on column ai_run_step.created_at is '事件业务发生时间';



create table sys_admin
(
    pk_id           bigserial    not null primary key,
    id              varchar(36)  not null, -- 业务主键 ULID
    username        varchar(64)  not null,                          -- 登录名
    password_hash   varchar(128) not null,                          -- BCrypt 哈希
    display_name    varchar(64)          null,                     -- 昵称
    email           varchar(128)         null,                     -- 邮箱
    status          smallint    not null default 0,                -- 0=正常 1=禁用 2=锁定
    failed_count    smallint             default 0,                -- 连续登录失败次数
    locked_until    timestamp            null,                     -- 锁定截止时间
    last_login_at   timestamp            null,                     -- 最近登录时间
    last_login_ip   varchar(64)          null,                     -- 最近登录 IP
    gmt_created     timestamp    not null,
    gmt_modified    timestamp    not null,
    gmt_deleted     timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted      smallint             default 0
);
create unique index idx_sys_admin_id       on sys_admin(id);
create unique index idx_sys_admin_username on sys_admin(username);

comment on table  sys_admin is '系统管理员账号表';
comment on column sys_admin.id            is '业务主键 ULID';
comment on column sys_admin.username      is '登录名（唯一）';
comment on column sys_admin.password_hash is 'BCrypt 哈希';
comment on column sys_admin.display_name  is '昵称';
comment on column sys_admin.email         is '邮箱（预留找回密码）';
comment on column sys_admin.status        is '账号状态：0=正常 1=禁用 2=锁定';
comment on column sys_admin.failed_count  is '连续登录失败次数，达阈值触发锁定';
comment on column sys_admin.locked_until  is '锁定截止时间（与 failed_count 配套）';
comment on column sys_admin.last_login_at is '最近一次登录时间';
comment on column sys_admin.last_login_ip is '最近一次登录 IP';

create table ai_model_provider
(
    pk_id               bigserial    not null primary key,
    code                varchar(64)  not null,                    -- 业务编码：minimax_main / deepseek_ocr，全局唯一，供 ai_agent_model.provider_code 引用
    provider            varchar(32)  not null,                    -- 厂商族：minimax / deepseek / openai / glm
    display_name        varchar(64)  not null,                    -- 中文名：「MiniMax 主对话」
    base_url            varchar(256) not null,                    -- 厂商 API baseUrl
    endpoint_path       varchar(256),                             -- OpenAI 兼容接口路径，如 /v1/chat/completions；null = AgentScope 默认值
    api_key             varchar(512) not null,                    -- AES 加密后的 API Key（复用 qmhealth.security_key 派生）
    model_name          varchar(128) not null,                    -- 厂商侧模型标识：DefaultModel-M3 / deepseek-chat / glm-4
    formatter           varchar(64)  not null,                    -- Formatter 短编码，见 FormatterType：
    --   OPENAI / OPENAI_MULTI
    --   DEEP_SEEK / DEEP_SEEK_MULTI
    --   GLM / GLM_MULTI
    --   MINIMAX / MINIMAX_MULTI
    -- ===== 生成参数（null = 用 AgentScope 默认值）=====
    temperature         numeric(4, 3),                            -- 0.000 ~ 2.000
    top_p               numeric(4, 3),
    top_k               integer,
    max_tokens          integer,
    thinking_budget     integer,                                  -- 思考预算（推理类模型）
    reasoning_effort    varchar(16),                              -- low / medium / high
    seed                bigint,
    frequency_penalty   numeric(4, 3),
    presence_penalty    numeric(4, 3),
    parallel_tool_calls smallint,                                  -- 0/1
    cache_control       smallint,                                  -- 0/1
    -- ===== 兜底扩展：厂商私有 KV 参数（JSON 字符串）=====
    extra_body_json     text,                                      -- 并入 GenerateOptions.additionalBodyParams
    extra_headers_json  text,                                      -- 并入 additionalHeaders
    extra_query_json    text,                                      -- 并入 additionalQueryParams
    supports_vision     smallint              default 0 not null,  -- 是否支持视觉/图片识别：0=否 1=是
    -- isMainModelSupportOcr 要求 supports_vision=1 且 ocr/main 绑定到同一 provider
    enabled             smallint              default 1 not null,
    order_number        smallint              default 0 not null,
    remarks             varchar(300),
    gmt_created         timestamp    not null,
    gmt_modified        timestamp    not null,
    gmt_deleted         timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted          smallint              default 0
);
create unique index idx_ai_model_provider_code     on ai_model_provider(code);
create index        idx_ai_model_provider_enabled  on ai_model_provider(enabled);

comment on table  ai_model_provider                       is 'AI 模型/Provider 配置表';
comment on column ai_model_provider.code                 is '业务编码，全局唯一，供 ai_agent_model.provider_code 引用';
comment on column ai_model_provider.provider             is '厂商族：minimax / deepseek / openai / glm';
comment on column ai_model_provider.base_url             is '厂商 API baseUrl';
comment on column ai_model_provider.endpoint_path        is 'OpenAI 兼容接口路径（如 /v1/chat/completions）；为空时使用 AgentScope 默认值 /v1/chat/completions';
comment on column ai_model_provider.api_key              is '加密后的 API Key（AES，密钥派生自 qmhealth.security_key）';
comment on column ai_model_provider.model_name           is '厂商侧模型标识，如 DefaultModel-M3';
comment on column ai_model_provider.formatter            is 'Formatter 短编码，启动期由 FormatterType 反射加载全限定类名';
comment on column ai_model_provider.temperature          is '采样温度，0.000 ~ 2.000';
comment on column ai_model_provider.top_p                is '核采样概率';
comment on column ai_model_provider.top_k                is 'Top-K 采样';
comment on column ai_model_provider.max_tokens           is '单次生成最大 token 数';
comment on column ai_model_provider.thinking_budget      is '思考预算（推理类模型）';
comment on column ai_model_provider.reasoning_effort     is '推理力度：low / medium / high';
comment on column ai_model_provider.seed                 is '随机种子';
comment on column ai_model_provider.frequency_penalty    is '频率惩罚';
comment on column ai_model_provider.presence_penalty     is '存在惩罚';
comment on column ai_model_provider.parallel_tool_calls  is '是否允许并行工具调用：0=否 1=是';
comment on column ai_model_provider.cache_control        is '是否启用缓存控制：0=否 1=是';
comment on column ai_model_provider.extra_body_json      is '厂商私有请求体参数（JSON），并入 GenerateOptions.additionalBodyParams';
comment on column ai_model_provider.extra_headers_json   is '厂商私有请求头（JSON），并入 additionalHeaders';
comment on column ai_model_provider.extra_query_json     is '厂商私有查询参数（JSON），并入 additionalQueryParams';
comment on column ai_model_provider.supports_vision      is '是否支持视觉/图片识别：0=否 1=是；isMainModelSupportOcr 要求 supports_vision=1 且 ocr/main 绑定到同一 provider';
comment on column ai_model_provider.enabled              is '是否启用：0=禁用 1=启用';
comment on column ai_model_provider.order_number         is '显示顺序';
comment on column ai_model_provider.remarks              is '备注';

-- ====================== ai_agent_model ======================
create table ai_agent_model
(
    pk_id          bigserial    not null primary key,
    agent_key      varchar(64)  not null,                       -- Agent 标识：main / ocr / mcp / generate_title
    display_name   varchar(64)  not null,                       -- 中文名：「主对话」「标题生成」
    provider_code  varchar(64)  not null,                       -- 逻辑外键 → ai_model_provider.code（不建 FK 约束，便于运维手工 insert 与种子数据顺序灵活）
    enabled        smallint              default 1 not null,
    order_number   smallint              default 0 not null,
    remarks        varchar(300),
    gmt_created    timestamp    not null,
    gmt_modified   timestamp    not null,
    gmt_deleted    timestamp    not null default '9999-12-31 23:59:59.999999',
    is_deleted     smallint              default 0
);
create unique index idx_ai_agent_model_agent_key on ai_agent_model(agent_key);

comment on table  ai_agent_model               is 'Agent 与模型 Provider 的绑定关系';
comment on column ai_agent_model.agent_key     is 'Agent 标识：main / ocr / mcp / generate_title';
comment on column ai_agent_model.display_name  is '中文名：「主对话」「标题生成」';
comment on column ai_agent_model.provider_code is '逻辑外键 → ai_model_provider.code';
comment on column ai_agent_model.enabled       is '是否启用：0=禁用 1=启用';
comment on column ai_agent_model.order_number  is '显示顺序';
