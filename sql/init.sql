CREATE DATABASE `console-server`
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

USE `console-server`;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '字典名称',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用 )',
  `value` varchar(20) NOT NULL COMMENT '字典值',
  `sort` int NOT NULL COMMENT '显示顺序',
  `type_id` int NOT NULL COMMENT '字典类型id',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典信息';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` (`id`, `name`, `status`, `value`, `sort`, `type_id`, `remark`) VALUES (1, '启用', 1, 'enable', 1, 1, NULL);
INSERT INTO `sys_dict` (`id`, `name`, `status`, `value`, `sort`, `type_id`, `remark`) VALUES (2, '禁用', 1, 'disabled', 1, 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no` varchar(20) NOT NULL COMMENT '编号',
  `name` varchar(20) NOT NULL COMMENT '类型名称',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用 )',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`id`, `no`, `name`, `status`, `remark`) VALUES (1, 'status', '状态', 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '任务名称',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态(0:停止,1:运行中 )',
  `service` varchar(100) NOT NULL COMMENT '调用服务',
  `immediate` tinyint NOT NULL DEFAULT '0' COMMENT '是否立即执行（0:否，1:是）',
  `cron` varchar(50) NOT NULL COMMENT '任务表达式',
  `params` text COMMENT '定时表达式执行参数',
  `remark` varchar(200) DEFAULT NULL COMMENT '任务描述',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '任务开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '任务结束时间',
  `last_exec_time` timestamp NULL DEFAULT NULL COMMENT '最后执行时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` (`id`, `name`, `status`, `service`, `immediate`, `cron`, `params`, `remark`, `start_time`, `end_time`, `last_exec_time`) VALUES (1, '测试', 0, 'TestJob.test', 0, '0 0/3 * * * ? ', NULL, NULL, NULL, NULL, '2024-06-14 17:00:00');
INSERT INTO `sys_job` (`id`, `name`, `status`, `service`, `immediate`, `cron`, `params`, `remark`, `start_time`, `end_time`, `last_exec_time`) VALUES (2, '访问百度', 0, 'baiduJob.handle', 0, '0 0/2 * * * ? ', '{\n    \"url\": \"https://www.baidu.com\",\n    \"method\": \"get\"\n}', NULL, NULL, NULL, '2024-06-14 17:02:00');
INSERT INTO `sys_job` (`id`, `name`, `status`, `service`, `immediate`, `cron`, `params`, `remark`, `start_time`, `end_time`, `last_exec_time`) VALUES (3, '测试2', 0, 'Test2Job.test', 0, '0 0/1 * * * ? ', NULL, NULL, NULL, NULL, '2024-07-17 16:49:14');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL COMMENT '任务id',
  `job_name` varchar(255) NOT NULL COMMENT '任务名称',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '执行状态（0：失败, 1：成功）',
  `err` text COMMENT '错误日志',
  `consume_time` int DEFAULT '0' COMMENT '消耗时间',
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务执行记录';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `moduleName` varchar(20) NOT NULL COMMENT '模块名',
  `action_message` varchar(50) NOT NULL COMMENT '操作描述',
  `action_type` varchar(10) NOT NULL COMMENT '操作类型',
  `action_name` varchar(20) NOT NULL COMMENT '操作人',
  `action_ip` varchar(20) NOT NULL COMMENT '操作人ip',
  `action_address` varchar(50) NOT NULL COMMENT '操作人地址',
  `action_function` varchar(100) NOT NULL COMMENT '操作方法',
  `browser` varchar(20) NOT NULL COMMENT '浏览器',
  `os` varchar(20) NOT NULL COMMENT '操作系统',
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `request_method` varchar(20) NOT NULL COMMENT '请求方式',
  `request_url` varchar(100) NOT NULL COMMENT '请求地址',
  `requestParams` text NOT NULL COMMENT '请求参数',
  `costTime` int NOT NULL COMMENT '花费时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (25, '菜单管理', '修改菜单', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.update', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 15:26:23.746000', 'PUT', '/api/system/menu', '{\"name\":\"新增用户\",\"sort\":1,\"icon\":null,\"component\":\"\",\"display\":0,\"type\":2,\"status\":1,\"openType\":0,\"fixed\":1,\"id\":16,\"code\":\"system_user_add\",\"parentId\":6,\"url\":null,\"params\":null,\"deleteTime\":null}', 556);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (26, '角色管理', '通过角色菜单授权', 'create', '超级管理员', '127.0.0.1', ' 本机地址', 'RoleController.authorize', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 15:31:50.984000', 'POST', '/api/system/role/authorize', '{\"roleId\":1,\"menuIds\":[1,2,3,25,26,22,5,6,16,17,18,7,9,8,12,14,24,21,23],\"defaultNavigate\":\"/dashboard/analysis\"}', 58);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (27, '角色管理', '通过角色菜单授权', 'create', '超级管理员', '127.0.0.1', ' 本机地址', 'RoleController.authorize', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 16:38:44.898000', 'POST', '/api/system/role/authorize', '{\"roleId\":1,\"menuIds\":[1,2,3,25,26,22,31,35,37,43,48,5,6,16,17,18,45,47,7,27,36,38,44,9,28,34,39,8,29,32,41,42,46,49,50,51,12,30,33,40,14,24,21,23],\"defaultNavigate\":\"/dashboard/analysis\"}', 629);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (28, '角色管理', '通过角色菜单授权', 'create', '超级管理员', '127.0.0.1', ' 本机地址', 'RoleController.authorize', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 16:39:09.167000', 'POST', '/api/system/role/authorize', '{\"roleId\":1,\"menuIds\":[1,2,3,25,26,22,5,6,16,17,18,45,47,7,27,36,38,44,9,28,34,39,8,29,32,41,42,46,49,50,51,12,30,33,40,14,24,21,23],\"defaultNavigate\":\"/dashboard/analysis\"}', 14);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (29, '角色管理', '通过角色菜单授权', 'create', '超级管理员', '127.0.0.1', ' 本机地址', 'RoleController.authorize', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 16:41:21.250000', 'POST', '/api/system/role/authorize', '{\"roleId\":1,\"menuIds\":[1,2,3,25,26,22,5,6,16,17,18,7,9,8,12,14,24,21,23],\"defaultNavigate\":\"/dashboard/analysis\"}', 48);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (30, '角色管理', '通过角色菜单授权', 'create', '超级管理员', '127.0.0.1', ' 本机地址', 'RoleController.authorize', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 16:41:49.527000', 'POST', '/api/system/role/authorize', '{\"roleId\":1,\"menuIds\":[1,2,3,25,26,22,5,6,16,17,18,7,9,8,12,14,24,21,23],\"defaultNavigate\":\"/dashboard/analysis\"}', 36);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (31, '角色管理', '通过角色菜单授权', 'create', '超级管理员', '127.0.0.1', ' 本机地址', 'RoleController.authorize', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 16:50:57.497000', 'POST', '/api/system/role/authorize', '{\"roleId\":1,\"menuIds\":[1,2,3,25,26,22,31,35,37,43,48,5,6,16,17,18,45,47,7,27,36,38,44,9,28,34,39,8,29,32,41,42,46,49,50,51,12,30,33,40,14,24,21,23],\"defaultNavigate\":\"/dashboard/analysis\"}', 295);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (32, '菜单管理', '修改菜单', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.update', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 16:53:07.119000', 'PUT', '/api/system/menu', '{\"name\":\"启用、禁用 字典类型\",\"sort\":4,\"icon\":\"\",\"component\":\"\",\"display\":0,\"type\":2,\"status\":1,\"openType\":0,\"fixed\":1,\"id\":42,\"code\":\"system_dict_type_status\",\"parentId\":8,\"url\":null,\"params\":null,\"deleteTime\":null}', 48);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (33, '菜单管理', '修改菜单', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.update', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 16:57:18.557000', 'PUT', '/api/system/menu', '{\"name\":\"启用、禁用 字典类型\",\"sort\":4,\"icon\":\"\",\"component\":\"\",\"display\":0,\"type\":2,\"status\":1,\"openType\":0,\"fixed\":1,\"id\":42,\"code\":\"system_dict_type_status\",\"parentId\":8,\"url\":null,\"params\":null,\"deleteTime\":null}', 48);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (34, '菜单管理', '修改菜单', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.update', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 17:06:19.963000', 'PUT', '/api/system/menu', '{\"name\":\"日志管理\",\"sort\":4,\"icon\":\"icon-park-outline:log\",\"component\":\"\",\"display\":0,\"type\":0,\"status\":1,\"openType\":0,\"fixed\":1,\"id\":24,\"code\":null,\"parentId\":null,\"url\":\"\",\"params\":null,\"deleteTime\":null}', 43);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (35, '菜单管理', '修改菜单', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.update', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 17:09:30.963000', 'PUT', '/api/system/menu', '{\"name\":\"日志管理\",\"sort\":4,\"icon\":\"icon-park-outline:log\",\"component\":\"\",\"display\":0,\"type\":0,\"status\":0,\"openType\":0,\"fixed\":1,\"id\":24,\"code\":null,\"parentId\":null,\"url\":\"\",\"params\":null,\"deleteTime\":null}', 3688);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (36, '菜单管理', '修改菜单', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.update', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 17:10:10.308000', 'PUT', '/api/system/menu', '{\"name\":\"日志管理\",\"sort\":4,\"icon\":\"icon-park-outline:log\",\"component\":\"\",\"display\":0,\"type\":0,\"status\":1,\"openType\":0,\"fixed\":1,\"id\":24,\"code\":null,\"parentId\":null,\"url\":\"\",\"params\":null,\"deleteTime\":null}', 42);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (37, '菜单管理', '修改菜单', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.update', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 17:10:32.714000', 'PUT', '/api/system/menu', '{\"name\":\"操作日志\",\"sort\":1,\"icon\":null,\"component\":\"log/actionLog/actionLog\",\"display\":0,\"type\":1,\"status\":0,\"openType\":0,\"fixed\":1,\"id\":21,\"code\":null,\"parentId\":24,\"url\":\"/log/action\",\"params\":null,\"deleteTime\":null}', 30);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (38, '菜单管理', '修改菜单', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.update', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 17:11:01.432000', 'PUT', '/api/system/menu', '{\"name\":\"操作日志\",\"sort\":1,\"icon\":null,\"component\":\"log/actionLog/actionLog\",\"display\":0,\"type\":1,\"status\":1,\"openType\":0,\"fixed\":1,\"id\":21,\"code\":null,\"parentId\":24,\"url\":\"/log/action\",\"params\":null,\"deleteTime\":null}', 29);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (39, '角色管理', '通过角色菜单授权', 'create', '超级管理员', '127.0.0.1', ' 本机地址', 'RoleController.authorize', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 17:14:52.457000', 'POST', '/api/system/role/authorize', '{\"roleId\":2,\"menuIds\":[1,2,3,25,26,22,5,6,7,9,8,29,32,41,42,46,49,50,51,12,14,13,24,21,23],\"defaultNavigate\":\"/dashboard/analysis\"}', 482);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (40, '菜单管理', '修改菜单', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.update', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 17:15:19.687000', 'PUT', '/api/system/menu', '{\"name\":\"外链\",\"sort\":4,\"icon\":\"icon-park-outline:link-cloud\",\"component\":\"\",\"display\":0,\"type\":1,\"status\":0,\"openType\":2,\"fixed\":1,\"id\":13,\"code\":\"\",\"parentId\":null,\"url\":\"https://www.baidu.com\",\"params\":\"\",\"deleteTime\":null}', 47);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (41, '菜单管理', '删除菜单', 'delete', '超级管理员', '127.0.0.1', ' 本机地址', 'MenuController.remove', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 17:15:22.481000', 'DELETE', '/api/system/menu/13', '{}', 38);
INSERT INTO `sys_log` (`id`, `moduleName`, `action_message`, `action_type`, `action_name`, `action_ip`, `action_address`, `action_function`, `browser`, `os`, `create_time`, `request_method`, `request_url`, `requestParams`, `costTime`) VALUES (42, '用户管理', '修改密码', 'update', '超级管理员', '127.0.0.1', ' 本机地址', 'UserController.updatePassword', 'Chrome 126.0.0', 'Mac OS X 10.15.7', '2024-07-26 17:17:16.903000', 'POST', '/api/system/user/update_password', '{\"oldPassword\":\"759408fcee6e4636c775bc2b5ca07d275478cbf5144a7a8b8709000ab8c9133b0134efc6f858000f4e2208750adcd267070c9a22b06d3d5a569db2c658de4da0fef11f222b1884b40a598ca4250b44140cc76dc1cd6f076efb492f153b1a7836cfec08388e7fbecfb777\",\"newPassword\":\"c4c395d4cd3f9e974a57c4cbb833a225aa21f6625a676ed77937b3bfb3a7e8a234f24d6238ca0422ac90b8bb489ddd9872f435cee55760aecef9a6ca6f1a2162d36ba5b33151f0ea4bd88ab21aa9e43ea6a129709d5bc81f243bb6087e68d51a0e615fb616beaf87c74aa0f1\"}', 124);
COMMIT;

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL COMMENT '用户名',
  `login_ip` varchar(255) NOT NULL COMMENT '登录ip',
  `login_addr` varchar(255) NOT NULL COMMENT '登录地址',
  `login_time` timestamp NOT NULL COMMENT '登录时间',
  `browser` varchar(255) NOT NULL COMMENT '浏览器',
  `os` varchar(255) NOT NULL COMMENT '操作系统',
  `status` tinyint NOT NULL COMMENT '登录状态(0:成功，1：失败)',
  `message` varchar(255) NOT NULL COMMENT '消息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='登录日志';

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_login_log` (`id`, `account`, `login_ip`, `login_addr`, `login_time`, `browser`, `os`, `status`, `message`) VALUES (89, 'cszh1', '127.0.0.1', ' 本机地址', '2024-07-26 17:12:09', 'Chrome 126.0.0', 'Mac OS X 10.15.7', 0, '登录成功');
INSERT INTO `sys_login_log` (`id`, `account`, `login_ip`, `login_addr`, `login_time`, `browser`, `os`, `status`, `message`) VALUES (90, 'cszh1', '127.0.0.1', ' 本机地址', '2024-07-26 17:12:24', 'Chrome 126.0.0', 'Mac OS X 10.15.7', 1, '验证码已过期');
INSERT INTO `sys_login_log` (`id`, `account`, `login_ip`, `login_addr`, `login_time`, `browser`, `os`, `status`, `message`) VALUES (91, 'cszh1', '127.0.0.1', ' 本机地址', '2024-07-26 17:12:28', 'Chrome 126.0.0', 'Mac OS X 10.15.7', 0, '登录成功');
INSERT INTO `sys_login_log` (`id`, `account`, `login_ip`, `login_addr`, `login_time`, `browser`, `os`, `status`, `message`) VALUES (92, 'admin', '127.0.0.1', ' 本机地址', '2024-07-26 17:13:24', 'Chrome 126.0.0', 'Mac OS X 10.15.7', 0, '登录成功');
INSERT INTO `sys_login_log` (`id`, `account`, `login_ip`, `login_addr`, `login_time`, `browser`, `os`, `status`, `message`) VALUES (93, 'cszh1', '127.0.0.1', ' 本机地址', '2024-07-26 17:13:47', 'Chrome 126.0.0', 'Mac OS X 10.15.7', 1, '验证码错误');
INSERT INTO `sys_login_log` (`id`, `account`, `login_ip`, `login_addr`, `login_time`, `browser`, `os`, `status`, `message`) VALUES (94, 'cszh1', '127.0.0.1', ' 本机地址', '2024-07-26 17:13:52', 'Chrome 126.0.0', 'Mac OS X 10.15.7', 1, '验证码错误');
INSERT INTO `sys_login_log` (`id`, `account`, `login_ip`, `login_addr`, `login_time`, `browser`, `os`, `status`, `message`) VALUES (95, 'cszh1', '127.0.0.1', ' 本机地址', '2024-07-26 17:13:57', 'Chrome 126.0.0', 'Mac OS X 10.15.7', 0, '登录成功');
INSERT INTO `sys_login_log` (`id`, `account`, `login_ip`, `login_addr`, `login_time`, `browser`, `os`, `status`, `message`) VALUES (96, 'admin', '127.0.0.1', ' 本机地址', '2024-07-26 17:17:45', 'Chrome 126.0.0', 'Mac OS X 10.15.7', 0, '登录成功');
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用 )',
  `name` varchar(20) NOT NULL COMMENT '菜单名称',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `type` tinyint NOT NULL DEFAULT '1' COMMENT '菜单类型(0：目录，1：菜单，2：按钮)',
  `code` varchar(50) DEFAULT NULL COMMENT '功能代码',
  `open_type` tinyint NOT NULL DEFAULT '0' COMMENT '打开方式 (0：路由，1：内嵌，2：链接)',
  `sort` int NOT NULL COMMENT '显示顺序',
  `parent_id` int DEFAULT '0' COMMENT '上级菜单id',
  `component` varchar(100) DEFAULT NULL COMMENT '组件地址',
  `url` varchar(100) DEFAULT NULL COMMENT '页面地址',
  `display` tinyint NOT NULL COMMENT '显示状态(0：显示，1：隐藏)',
  `params` varchar(200) DEFAULT NULL COMMENT '路由参数',
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `delete_time` timestamp(6) NULL DEFAULT NULL COMMENT '删除时间',
  `fixed` int NOT NULL DEFAULT '1' COMMENT '固定页签(0:固定，1：不固定)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单信息';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (1, 1, '仪表盘', 'icon-park-outline:dashboard', 0, '', 0, 1, NULL, '', NULL, 0, NULL, '2024-05-17 16:38:06.767098', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (2, 1, '分析页', NULL, 1, '', 0, 1, 1, 'dashboard/analysis/analysis', '/dashboard/analysis', 0, NULL, '2024-05-17 16:38:32.067642', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (3, 1, '工作台', NULL, 1, '', 0, 1, 1, 'dashboard/workbench/workbench', '/dashboard/workbench', 0, NULL, '2024-05-17 16:38:56.948231', '2024-06-24 10:30:41.000000', NULL, 0);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (4, 1, '系统设计', NULL, 1, '', 0, 2, NULL, '', NULL, 0, NULL, '2024-05-17 16:39:18.520247', '2024-06-24 10:30:27.935164', '2024-05-23 09:54:44.000000', 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (5, 1, '系统管理', 'icon-park-outline:system', 0, '', 0, 3, NULL, '', NULL, 0, NULL, '2024-05-17 16:39:41.587614', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (6, 1, '用户管理', NULL, 1, '', 0, 1, 5, 'system/userInfo/user/user', '/system/user', 0, NULL, '2024-05-17 16:40:06.881755', '2024-06-26 08:12:46.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (7, 1, '角色管理', NULL, 1, '', 0, 2, 5, 'system/role/role', '/system/role', 0, NULL, '2024-05-17 16:40:50.247010', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (8, 1, '字典管理', NULL, 1, '', 0, 5, 5, 'system/dictionary/dictionary', '/system/dictionary', 0, NULL, '2024-05-17 16:44:47.513441', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (9, 1, '菜单管理', NULL, 1, '', 0, 3, 5, 'system/menu/menu', '/system/menu', 0, NULL, '2024-05-17 16:45:35.692249', '2024-06-26 02:46:48.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (11, 1, '页面按钮管理', NULL, 1, '', 0, 6, 5, 'system/pageButton/pageButton', '/system/pageButton', 0, NULL, '2024-05-17 16:50:21.413775', '2024-06-24 10:30:27.935164', '2024-05-24 08:21:55.000000', 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (12, 1, '参数管理', NULL, 1, '', 0, 7, 5, 'system/param/param', '/system/param', 0, NULL, '2024-05-18 09:18:11.062930', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (13, 0, '外链', 'icon-park-outline:link-cloud', 1, '', 2, 4, NULL, '', 'https://www.baidu.com', 0, '', '2024-05-18 12:35:27.466372', '2024-07-26 09:15:22.000000', '2024-07-26 09:15:22.000000', 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (14, 1, '文件管理', NULL, 1, '', 0, 8, 5, 'system/upload/upload', '/system/upload', 0, NULL, '2024-05-22 06:13:45.192851', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (16, 1, '新增用户', NULL, 2, 'system_user_add', 0, 1, 6, '', NULL, 0, NULL, '2024-05-23 08:21:21.613498', '2024-07-26 07:26:23.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (17, 1, '修改用户', NULL, 2, 'system_user_edit', 0, 2, 6, '', NULL, 0, NULL, '2024-05-23 08:21:52.829040', '2024-07-26 07:26:45.994916', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (18, 1, '删除用户', NULL, 2, 'system_user_delete', 0, 3, 6, '', NULL, 0, NULL, '2024-05-23 08:22:36.653128', '2024-07-26 07:26:48.157344', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (21, 1, '操作日志', NULL, 1, NULL, 0, 1, 24, 'log/actionLog/actionLog', '/log/action', 0, NULL, '2024-05-29 02:46:38.708595', '2024-07-26 09:11:01.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (22, 1, '定时任务', NULL, 1, NULL, 0, 2, 25, 'monitor/job/job', '/monitor/job', 0, NULL, '2024-06-03 06:21:13.242523', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (23, 1, '登录日志', NULL, 1, NULL, 0, 2, 24, 'log/loginLog/loginLog', '/log/login', 0, NULL, '2024-06-03 08:43:22.264235', '2024-07-15 06:41:47.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (24, 1, '日志管理', 'icon-park-outline:log', 0, NULL, 0, 4, NULL, '', '', 0, NULL, '2024-06-04 07:29:54.811301', '2024-07-26 09:10:10.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (25, 1, '监控管理', 'icon-park-outline:trend', 0, NULL, 0, 2, NULL, '', NULL, 0, NULL, '2024-06-04 09:29:12.580864', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (26, 1, '在线用户', NULL, 1, NULL, 0, 1, 25, 'monitor/online/online', '/monitor/online', 0, NULL, '2024-06-04 09:29:47.214958', '2024-06-24 10:30:27.935164', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (27, 1, '新增角色', '', 2, 'system_role_add', 0, 1, 7, 'system/menu/menu', '/system/menu', 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (28, 1, '新增菜单', '', 2, 'system_menu_add', 0, 1, 9, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (29, 1, '新增字典类型', '', 2, 'system_dict_type_add', 0, 1, 8, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (30, 1, '新增参数', '', 2, 'system_param_add', 0, 1, 12, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (31, 1, '创建定时任务', '', 2, 'monitor_job_add', 0, 1, 22, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (32, 1, '修改字典类型', '', 2, 'system_dict_type_edit', 0, 2, 8, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (33, 1, '修改参数', '', 2, 'system_param_edit', 0, 2, 12, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (34, 1, '修改菜单', '', 2, 'system_menu_edit', 0, 2, 9, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (35, 1, '修改定时任务', '', 2, 'monitor_job_edit', 0, 2, 22, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (36, 1, '修改角色', '', 2, 'system_role_edit', 0, 2, 7, 'system/menu/menu', '/system/menu', 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (37, 1, '删除定时任务', '', 2, 'monitor_job_delete', 0, 3, 22, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (38, 1, '删除角色', '', 2, 'system_role_delete', 0, 3, 7, 'system/menu/menu', '/system/menu', 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (39, 1, '删除菜单', '', 2, 'system_menu_delete', 0, 3, 9, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (40, 1, '删除参数', '', 2, 'system_param_delete', 0, 3, 12, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (41, 1, '删除字典类型', '', 2, 'system_dict_type_delete', 0, 3, 8, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (42, 1, '启用、禁用 字典类型', '', 2, 'system_dict_type_status', 0, 4, 8, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 08:57:18.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (43, 1, '启动、停止 定时任务', '', 2, 'monitor_job_status', 0, 4, 22, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (44, 1, '角色授权', '', 2, 'system_role_accredit', 0, 4, 7, 'system/menu/menu', '/system/menu', 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (45, 1, '启用、禁用 用户', NULL, 2, 'system_user_status', 0, 4, 6, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (46, 1, '新增字典', '', 2, 'system_dict_add', 0, 5, 8, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (47, 1, '冻结、解冻 用户', NULL, 2, 'system_user_freeze', 0, 5, 6, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (48, 1, '立即执行定时任务', '', 2, 'monitor_job_execute', 0, 5, 22, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (49, 1, '修改字典', '', 2, 'system_dict_edit', 0, 6, 8, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (50, 1, '删除字典', '', 2, 'system_dict_delete', 0, 7, 8, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
INSERT INTO `sys_menu` (`id`, `status`, `name`, `icon`, `type`, `code`, `open_type`, `sort`, `parent_id`, `component`, `url`, `display`, `params`, `create_time`, `update_time`, `delete_time`, `fixed`) VALUES (51, 1, '启动、禁用 字典', '', 2, 'system_dict_status', 0, 8, 8, '', NULL, 0, NULL, '2024-07-26 07:24:24.000000', '2024-07-26 07:24:24.000000', NULL, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_param`;
CREATE TABLE `sys_param` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '参数名称',
  `label` varchar(50) NOT NULL COMMENT '参数键',
  `value` varchar(50) NOT NULL COMMENT '参数值',
  `sys` tinyint NOT NULL DEFAULT '1' COMMENT '是否系统内置(0：是,1：否)',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `delete_time` timestamp(6) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数设置';

-- ----------------------------
-- Records of sys_param
-- ----------------------------
BEGIN;
INSERT INTO `sys_param` (`id`, `name`, `label`, `value`, `sys`, `remark`, `create_time`, `update_time`, `delete_time`) VALUES (4, '文件上传大小', 'file.size', '10485760', 1, '文件大小（单位：byte）', '2024-05-21 10:03:33.891176', '2024-05-24 08:21:23.000000', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `code` varchar(50) NOT NULL COMMENT '角色标识',
  `defaultNavigate` varchar(100) DEFAULT NULL COMMENT '默认导航地址',
  `type` enum('system','custom') NOT NULL DEFAULT 'custom' COMMENT '类型',
  `remark` varchar(200) DEFAULT NULL COMMENT '角色描述',
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色信息';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`id`, `name`, `code`, `defaultNavigate`, `type`, `remark`, `create_time`, `update_time`) VALUES (1, '超级管理员', 'ADMIN', '/dashboard/analysis', 'system', '系统内置角色，不可删除', '2024-05-22 10:02:09.540686', '2024-07-26 08:50:57.000000');
INSERT INTO `sys_role` (`id`, `name`, `code`, `defaultNavigate`, `type`, `remark`, `create_time`, `update_time`) VALUES (2, '普通用户', 'OPERATION_USER', '/dashboard/analysis', 'system', '系统内置角色，不可删除', '2024-05-22 10:02:50.000000', '2024-07-26 09:14:52.000000');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL DEFAULT '0' COMMENT '角色id',
  `menu_id` int NOT NULL DEFAULT '0' COMMENT '菜单id',
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色菜单授权';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (35, 1, 1, '2024-06-14 07:09:38.938712');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (36, 1, 2, '2024-06-14 07:09:38.945718');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (37, 1, 3, '2024-06-14 07:09:38.956028');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (38, 1, 25, '2024-06-14 07:09:38.964892');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (39, 1, 26, '2024-06-14 07:09:38.972650');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (40, 1, 22, '2024-06-14 07:09:38.980163');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (41, 1, 5, '2024-06-14 07:09:38.990584');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (42, 1, 6, '2024-06-14 07:09:38.999853');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (43, 1, 16, '2024-06-14 07:09:39.008409');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (44, 1, 17, '2024-06-14 07:09:39.014127');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (45, 1, 18, '2024-06-14 07:09:39.021107');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (48, 1, 7, '2024-06-14 07:09:39.042074');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (49, 1, 9, '2024-06-14 07:09:39.049394');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (50, 1, 8, '2024-06-14 07:09:39.056232');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (51, 1, 12, '2024-06-14 07:09:39.062200');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (52, 1, 14, '2024-06-14 07:09:39.069296');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (53, 1, 24, '2024-06-14 07:09:39.077931');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (54, 1, 21, '2024-06-14 07:09:39.087580');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (55, 1, 23, '2024-06-14 07:09:39.094809');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (56, 2, 1, '2024-06-14 07:09:53.175294');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (57, 2, 2, '2024-06-14 07:09:53.183597');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (58, 2, 3, '2024-06-14 07:09:53.192337');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (59, 2, 13, '2024-06-14 07:09:53.198562');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (60, 1, 31, '2024-07-26 08:50:57.275992');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (61, 1, 35, '2024-07-26 08:50:57.285903');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (62, 1, 37, '2024-07-26 08:50:57.292334');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (63, 1, 43, '2024-07-26 08:50:57.298672');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (64, 1, 48, '2024-07-26 08:50:57.304233');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (65, 1, 45, '2024-07-26 08:50:57.317218');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (66, 1, 47, '2024-07-26 08:50:57.325164');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (67, 1, 27, '2024-07-26 08:50:57.331664');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (68, 1, 36, '2024-07-26 08:50:57.338823');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (69, 1, 38, '2024-07-26 08:50:57.344358');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (70, 1, 44, '2024-07-26 08:50:57.353488');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (71, 1, 28, '2024-07-26 08:50:57.359169');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (72, 1, 34, '2024-07-26 08:50:57.365985');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (73, 1, 39, '2024-07-26 08:50:57.373443');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (74, 1, 29, '2024-07-26 08:50:57.381353');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (75, 1, 32, '2024-07-26 08:50:57.388894');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (76, 1, 41, '2024-07-26 08:50:57.395265');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (77, 1, 42, '2024-07-26 08:50:57.406161');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (78, 1, 46, '2024-07-26 08:50:57.418764');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (79, 1, 49, '2024-07-26 08:50:57.426638');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (80, 1, 50, '2024-07-26 08:50:57.436267');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (81, 1, 51, '2024-07-26 08:50:57.444992');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (82, 1, 30, '2024-07-26 08:50:57.452462');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (83, 1, 33, '2024-07-26 08:50:57.459010');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (84, 1, 40, '2024-07-26 08:50:57.468894');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (85, 2, 25, '2024-07-26 09:14:52.064161');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (86, 2, 26, '2024-07-26 09:14:52.083085');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (87, 2, 22, '2024-07-26 09:14:52.095383');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (88, 2, 5, '2024-07-26 09:14:52.105853');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (89, 2, 6, '2024-07-26 09:14:52.115290');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (90, 2, 7, '2024-07-26 09:14:52.123467');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (91, 2, 9, '2024-07-26 09:14:52.141787');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (92, 2, 8, '2024-07-26 09:14:52.170465');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (93, 2, 29, '2024-07-26 09:14:52.204483');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (94, 2, 32, '2024-07-26 09:14:52.217036');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (95, 2, 41, '2024-07-26 09:14:52.239469');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (96, 2, 42, '2024-07-26 09:14:52.264248');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (97, 2, 46, '2024-07-26 09:14:52.287575');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (98, 2, 49, '2024-07-26 09:14:52.303897');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (99, 2, 50, '2024-07-26 09:14:52.327813');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (100, 2, 51, '2024-07-26 09:14:52.346961');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (101, 2, 12, '2024-07-26 09:14:52.360473');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (102, 2, 14, '2024-07-26 09:14:52.378728');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (103, 2, 24, '2024-07-26 09:14:52.402183');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (104, 2, 21, '2024-07-26 09:14:52.421293');
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`, `create_time`) VALUES (105, 2, 23, '2024-07-26 09:14:52.430997');
COMMIT;

-- ----------------------------
-- Table structure for sys_upload
-- ----------------------------
DROP TABLE IF EXISTS `sys_upload`;
CREATE TABLE `sys_upload` (
  `id` int NOT NULL AUTO_INCREMENT,
  `size` int NOT NULL COMMENT '文件大小',
  `originalname` varchar(100) NOT NULL COMMENT '原文件名',
  `fileName` varchar(100) NOT NULL COMMENT '文件名',
  `url` varchar(255) NOT NULL COMMENT '文件地址',
  `ext` varchar(20) DEFAULT NULL COMMENT '拓展名',
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文件上传记录';

-- ----------------------------
-- Records of sys_upload
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用 )',
  `no` varchar(20) NOT NULL COMMENT '编号',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `account` varchar(20) NOT NULL COMMENT '账号',
  `password` varchar(300) NOT NULL COMMENT '密码',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `freeze` tinyint NOT NULL DEFAULT '0' COMMENT '是否冻结（0：未冻结,1：冻结）',
  `sys_user` tinyint NOT NULL DEFAULT '1' COMMENT '是否系统用户（0：是,1：否）',
  `email` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `avatar` varchar(200) DEFAULT NULL COMMENT '头像',
  `roleId` int NOT NULL DEFAULT '0' COMMENT '角色id',
  `roleName` varchar(20) NOT NULL COMMENT '角色名称',
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `delete_time` timestamp(6) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`id`, `status`, `no`, `name`, `account`, `password`, `phone`, `freeze`, `sys_user`, `email`, `address`, `avatar`, `roleId`, `roleName`, `create_time`, `update_time`, `delete_time`) VALUES (1, 1, 'sys', '超级管理员', 'admin', 'c4c395d4cd3f9e974a57c4cbb833a225aa21f6625a676ed77937b3bfb3a7e8a234f24d6238ca0422ac90b8bb489ddd9872f435cee55760aecef9a6ca6f1a2162d36ba5b33151f0ea4bd88ab21aa9e43ea6a129709d5bc81f243bb6087e68d51a0e615fb616beaf87c74aa0f1', '13212341253', 0, 1, '729220650@qq.com', '1235', 'uploads/20240618/1755006968171.jpg', 1, '超级管理员', '2024-05-13 11:37:05.000000', '2024-07-26 09:17:16.000000', NULL);
INSERT INTO `sys_user` (`id`, `status`, `no`, `name`, `account`, `password`, `phone`, `freeze`, `sys_user`, `email`, `address`, `avatar`, `roleId`, `roleName`, `create_time`, `update_time`, `delete_time`) VALUES (23, 1, 'cszh', '测试账号', 'cszh1', '5541fca92107bb46912157e0a602578f44765f8e85ff82f01803920b4653b171f728c166e97e2d5adeced0ee3dad37545e5244630c895f5fb1e517d70346761dc24b346966345478a8381fbf2560821f9e44a771fa194bf114689d24d8823d724a7bfe6f5385608ff29f', '13212341254', 0, 1, NULL, NULL, NULL, 2, '普通用户', '2024-05-24 07:59:51.398387', '2024-06-18 08:43:47.733892', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
