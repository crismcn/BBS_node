-- 初始化数据库
DROP DATABASE IF EXISTS `LLLyh_BBS`;
CREATE DATABASE `LLLyh_BBS`;
USE `LLLyh_BBS`;

SET FOREIGN_KEY_CHECKS=0; -- 禁止外键约束

-- ----------------------------
-- token表
-- ----------------------------
DROP TABLE IF EXISTS `bbs_token`;
CREATE TABLE `bbs_token` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL COMMENT '所属用户',
  `bbs_token` VARCHAR(512) DEFAULT NULL,
  `phone_token` VARCHAR(512) DEFAULT NULL,
  `admin_token` VARCHAR(512) DEFAULT NULL,
  `bbs_addr` VARCHAR(48) DEFAULT NULL,
  `phone_addr` VARCHAR(48) DEFAULT NULL,
  `admin_addr` VARCHAR(48) DEFAULT NULL,
  `bbs_device` VARCHAR(48) DEFAULT NULL,
  `phone_device` VARCHAR(48) DEFAULT NULL,
  `admin_device` VARCHAR(48) DEFAULT NULL,
  `bbs_ip` VARCHAR(48) DEFAULT NULL,
  `phone_ip` VARCHAR(48) DEFAULT NULL,
  `admin_ip` VARCHAR(48) DEFAULT NULL,
  `bbs_expire_time` datetime DEFAULT NULL,
  `phone_expire_time` datetime DEFAULT NULL,
  `admin_expire_time` datetime DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态: 0：删除，1：可用(默认为1)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='token表';

-- ----------------------------
-- 用户表
-- ----------------------------
DROP TABLE IF EXISTS `bbs_user`;
CREATE TABLE `bbs_user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `role_id` INT(11) COMMENT '关联角色',
  `account` VARCHAR(48) NOT NULL COMMENT '用户账号',
  `name` VARCHAR(24) NOT NULL COMMENT '用户昵称',
  `password` VARCHAR(48) NOT NULL COMMENT '用户密码',
  `type` TINYINT(4) NOT NULL COMMENT '用户类型: 0: 手机注册 1: 论坛注册 2: 管理平台添加',
  `sex` TINYINT(4) DEFAULT NULL COMMENT '性别: 0:男 1:女',
  `avatar` VARCHAR(128) DEFAULT NULL COMMENT '头像',
  `phone` VARCHAR(24) DEFAULT NULL COMMENT '手机号',
  `wechat` VARCHAR(24) DEFAULT NULL COMMENT '微信',
  `qq` VARCHAR(24) DEFAULT NULL COMMENT 'qq',
  `email` VARCHAR(48) DEFAULT NULL COMMENT '邮箱',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态: 0：停用，1：启用(默认为1)',
  `create_user` INT(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_user` INT(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `delete_user` INT(11) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态: 0：删除，1：可用(默认为1)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- 用户角色关系表
-- ----------------------------
DROP TABLE IF EXISTS `bbs_user_role`;
CREATE TABLE `bbs_user_role` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `role_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='用户关系表';

-- ----------------------------
-- 角色表
-- ----------------------------
DROP TABLE IF EXISTS `bbs_role`;
CREATE TABLE `bbs_role` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pid` INT(11) NOT NULL,
  `name` VARCHAR(24) NOT NULL COMMENT '角色名称',
  `blogs` INT(11) DEFAULT '1' COMMENT '专栏数量, -1为无限',
  `users` INT(11) DEFAULT '10' COMMENT '可创建多少个用户, -1为无限',
  `desc` VARCHAR(128) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态: 0：停用，1：启用(默认为1)',
  `create_user` INT(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_user` INT(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `delete_user` INT(11) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态: 0：删除，1：可用(默认为1)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- ----------------------------
-- 角色菜单关系表
-- ----------------------------
DROP TABLE IF EXISTS `bbs_role_menu`;
CREATE TABLE `bbs_role_menu` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `role_id` INT(11) NOT NULL,
  `menu_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='角色菜单关系表';

-- ----------------------------
-- 角色数据权限关系表
-- ----------------------------
DROP TABLE IF EXISTS `bbs_role_data_perms`;
CREATE TABLE `bbs_role_data_perms` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `role_id` INT(11) NOT NULL,
  `data_perms_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='角色数据权限关系表';

-- ----------------------------
-- 功能菜单表
-- ----------------------------
DROP TABLE IF EXISTS `bbs_menu`;
CREATE TABLE `bbs_menu` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pid` INT(11) DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '菜单类型: 1. 管理平台菜单 2. BBS菜单 3. 移动端菜单',
  `code` VARCHAR(48) NOT NULL COMMENT '菜单编码',
  `name` VARCHAR(48) NOT NULL COMMENT '菜单名称',
  `component` tinyint(4) NOT NULL COMMENT '对应组件: -1. 根节点 1. 页面组件 2.默认布局 3456...扩展布局',
  `icon` VARCHAR(128) DEFAULT NULL COMMENT '菜单图标',
  `alias` VARCHAR(128) DEFAULT NULL COMMENT '别名',
  `redirect` VARCHAR(128) DEFAULT NULL COMMENT '重定向路径: 配置菜单编码或URL',
  `sort` INT(11) NOT NULL,
  `desc` VARCHAR(128) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态: 0：停用，1：启用(默认为1)',
  `create_user` INT(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_user` INT(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `delete_user` INT(11) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态: 0：删除，1：可用(默认为1)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='菜单表';

-- ----------------------------
-- 数据权限表
-- ----------------------------
DROP TABLE IF EXISTS `bbs_data_perms`;
CREATE TABLE `bbs_data_perms` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `menu_id` INT(11) NOT NULL,
  `name` VARCHAR(48) NOT NULL COMMENT '名称',
  `code` VARCHAR(48) NOT NULL COMMENT '编码',
  `type` tinyint(4) NOT NULL COMMENT '按钮或者其他',
  `api` VARCHAR(24) NOT NULL COMMENT '接口',
  `method` tinyint(4) NOT NULL COMMENT '请求方式 1: GET 2: POST 3: PUT 4. DELETE',
  `create_user` INT(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_user` INT(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `delete_user` INT(11) DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态: 0：删除，1：可用(默认为1)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='数据权限表';

----------------------------
-- 区域表
----------------------------
DROP TABLE IF EXISTS `bbs_area`;
CREATE TABLE `bbs_area` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(48) NOT NULL COMMENT '区域名称',
  `pid` INT(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态: 0：停用，1：启用(默认为1)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='区域表';

----------------------------
-- 日志表
----------------------------
DROP TABLE IF EXISTS `bbs_log`;
CREATE TABLE `bbs_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `origin` INT(11) NOT NULL COMMENT '日志来源: 0: 手机 1: 论坛 2: 管理平台',
  `type` INT(11) NOT NULL COMMENT '日志类型: 1.用户登录 2. 用户登出 3. 菜单访问 4.功能操作',
  `title` VARCHAR(48) DEFAULT NULL COMMENT '日志标题',
  `desc` VARCHAR(48) DEFAULT NULL COMMENT '日志描述',
  `ip` VARCHAR(48) DEFAULT NULL COMMENT '访问IP',
  `create_user` INT(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='日志表';
