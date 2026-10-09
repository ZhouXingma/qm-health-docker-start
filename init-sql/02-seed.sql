-- App密钥，注意更改密钥
INSERT INTO sys_app (app_code, app_desc, security_key, config, disabled, gmt_created, gmt_modified, gmt_deleted, is_deleted) VALUES
('qmhealth_ai', 'ai应用', 'UbHBjvQwes304px3b7XrV1YMLo2t4Tcxq4q0', '{"role": "ai"}', 0, '2026-06-15 21:12:54.000000', '2026-06-15 21:12:55.000000', '9999-12-31 23:59:59.000000', 0);

-- 管理员信息，密码默认：admin123，注意更改密码
INSERT INTO sys_admin (
    id, username, password_hash, display_name, status,
    gmt_created, gmt_modified, gmt_deleted, is_deleted
) VALUES (
             '01M3A1PW91A1ZQBK1211YN8ZNK',
             'admin',
             '$2a$10$XIqnF/W3KzPjy7mmvQYOD.IviYO56ARcq1ri9IoL4wCWVxmaOodJ6',
             '系统管理员', 0,
             now(), now(), '9999-12-31 23:59:59.999999', 0
         );

-- 模型配置信息
INSERT INTO "ai_agent_model" ("agent_key", "display_name", "provider_code", "enabled", "order_number", "remarks", "gmt_created", "gmt_modified", "gmt_deleted", "is_deleted") VALUES
('main', '主对话', '', 1, 0, '由 ModelConfigBootstrap 自动建绑定', '2026-09-30 21:40:52.305774', '2026-10-02 23:48:03.985585', '9999-12-31 23:59:59.999999', 0),
('ocr', 'OCR 识别', '', 1, 1, '由 ModelConfigBootstrap 自动建绑定', '2026-09-30 21:40:52.307379', '2026-10-02 23:48:04.652529', '9999-12-31 23:59:59.999999', 0),
('mcp', 'MCP 元数据整理', '', 1, 2, '由 ModelConfigBootstrap 自动建绑定', '2026-09-30 21:40:52.308501', '2026-10-02 23:48:05.323911', '9999-12-31 23:59:59.999999', 0),
('generate_title', '标题生成', '', 1, 3, '由 ModelConfigBootstrap 自动建绑定', '2026-09-30 21:40:52.30975', '2026-10-02 23:48:06.003527', '9999-12-31 23:59:59.999999', 0);
