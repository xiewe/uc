SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `uc` ;
CREATE SCHEMA IF NOT EXISTS `uc` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `uc` ;

DROP TABLE IF EXISTS `uc`.`sys_organization` ;
CREATE TABLE IF NOT EXISTS `uc`.`sys_organization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(128) NULL,
  `parent_id` INT NULL,
  `priority` INT NULL,
  `create_time` DATETIME,
  `modify_time` DATETIME,
  PRIMARY KEY (`id`),
  INDEX `idx_sys_organization_1` (`parent_id` ASC)
) ENGINE = INNODB;

DROP TABLE IF EXISTS `uc`.`sys_role` ;
CREATE TABLE IF NOT EXISTS `uc`.`sys_role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(256) NULL,
  PRIMARY KEY (`id`)
) ENGINE = INNODB;

DROP TABLE IF EXISTS `uc`.`sys_menu` ;
CREATE TABLE IF NOT EXISTS `uc`.`sys_menu` (
  `id` INT NOT NULL,
  `category` VARCHAR(50) NULL,
  `name` VARCHAR(100) NULL,
  `url` VARCHAR(45) NULL,
  `parent_id` INT NULL,
  `flag` INT NULL COMMENT 'ztree open-flag',
  `target` VARCHAR(32) NULL COMMENT 'ztree target iframe',
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_sys_menu_1` (`category` ASC),
  INDEX `idx_sys_menu_2` (`parent_id` ASC)
) ENGINE = INNODB;

DROP TABLE IF EXISTS `uc`.`sys_menu_class` ;
CREATE TABLE IF NOT EXISTS `uc`.`sys_menu_class` (
  `id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  `class_name` VARCHAR(100) NULL COMMENT '对应的模块全类名',
  `method` VARCHAR(50) NULL COMMENT 'Shiro的权限标识，比如：user:view',
  PRIMARY KEY (`id`),
  INDEX `idx_sys_menu_class_1` (`menu_id` ASC),
  CONSTRAINT `fk_sys_menu_class_1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `uc`.`sys_menu` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = INNODB;

DROP TABLE IF EXISTS `uc`.`sys_role_permission` ;
CREATE TABLE IF NOT EXISTS `uc`.`sys_role_permission` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  `menu_class_id` INT,
  PRIMARY KEY (`id`),
  INDEX `idx_sys_role_permission_1` (`role_id` ASC),
  INDEX `idx_sys_role_permission_2` (`menu_id` ASC),
  CONSTRAINT `fk_sys_role_permission_1`
    FOREIGN KEY (`role_id`)
    REFERENCES `uc`.`sys_role` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sys_role_permission_2`
    FOREIGN KEY (`menu_id`)
    REFERENCES `uc`.`sys_menu` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sys_role_permission_3`
    FOREIGN KEY (`menu_class_id`)
    REFERENCES `uc`.`sys_menu_class` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE = INNODB;

DROP TABLE IF EXISTS `uc`.`sys_user` ;
CREATE TABLE IF NOT EXISTS `uc`.`sys_user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键，自动增长',
  `uid` VARCHAR(30) NULL COMMENT '用户ID',
  `username` VARCHAR(32) NOT NULL COMMENT '用户帐号，登录',
  `password` VARCHAR(64) NULL COMMENT '密码',
  `salt` VARCHAR(45) NULL COMMENT '加密散列数据',
  `realname` VARCHAR(600) NULL COMMENT '姓名',
  `gender` INT NULL DEFAULT 0 COMMENT '性别 0 - 男 ，1 - 女',
  `photo` VARCHAR(300) NULL COMMENT '用户头像',
  `phone` VARCHAR(32) NULL COMMENT '手机号',
  `country_code` VARCHAR(8) NULL COMMENT '号码对应的国家码，如中国：0086',
  `nationality` VARCHAR(30) NULL COMMENT '国籍',
  `individual_id` VARCHAR(32) NULL COMMENT '身份证',
  `email` VARCHAR(100) NULL COMMENT '邮箱',
  `address` VARCHAR(300) NULL COMMENT '地址',
  `self_intro` VARCHAR(1000) NULL COMMENT '自我介绍',
  `is_vip` INT NULL DEFAULT 0 COMMENT '是否VIP， 0-否，1-是',
  `status` INT NULL DEFAULT 0 COMMENT '状态：0-enabled; 1-disabled;',
  `utype` INT NULL DEFAULT 0 COMMENT '用户类型：0-系统用户不能删除；1-管理后台用户；2-终端注册用户',
  `org_id` INT NULL COMMENT '所属组织',
  `role_id` INT NULL COMMENT '角色',
  `gps` VARCHAR(60) NULL COMMENT '用户注册时的位置(经度，纬度)，经纬度用逗号隔开',
  `longitude` DOUBLE NULL DEFAULT 0.0 COMMENT '用户最后的经度',
  `latitude` DOUBLE NULL DEFAULT 0.0 COMMENT '用户最后的纬度',
  `ip` VARCHAR(45) NULL COMMENT '操作的IP',
  `user_agent` VARCHAR(200) NULL COMMENT '终端设备信息',
  `last_login`  DATETIME NULL COMMENT '最后登录时间',
  `create_time` DATETIME,
  `modify_time` DATETIME,
  PRIMARY KEY (`id`),
  INDEX `idx_sys_user_1` (`uid` ASC),
  INDEX `idx_sys_user_2` (`username` ASC),
  INDEX `idx_sys_user_3` (`phone` ASC),
  INDEX `idx_sys_user_4` (`email` ASC),
  INDEX `idx_sys_user_5` (`org_id` ASC),
  INDEX `idx_sys_user_6` (`role_id` ASC),
  INDEX `idx_sys_user_7` (`longitude` ASC),
  INDEX `idx_sys_user_8` (`latitude` ASC),
  CONSTRAINT `fk_sys_user_1`
    FOREIGN KEY (`org_id`)
    REFERENCES `uc`.`sys_organization` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sys_user_2`
    FOREIGN KEY (`role_id`)
    REFERENCES `uc`.`sys_role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = INNODB
COMMENT = '用户表';

DROP TABLE IF EXISTS `uc`.`sys_log` ;
CREATE TABLE IF NOT EXISTS `uc`.`sys_log` (
  `id` BIGINT NULL AUTO_INCREMENT COMMENT '主键，自动增长',
  `username` VARCHAR(32) NULL COMMENT '操作用户名',
  `ip` VARCHAR(45) NULL COMMENT '操作的IP',
  `user_agent` VARCHAR(200) NULL COMMENT '终端设备信息',
  `category` VARCHAR(50) NULL COMMENT '类别',
  `level` VARCHAR(20) NULL COMMENT '级别',
  `message` VARCHAR(256) NULL COMMENT '日志信息',
  `create_time` DATETIME NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  INDEX `idx_sys_log_1` (`username` ASC),
  INDEX `idx_sys_log_2` (`ip` ASC)
) ENGINE = INNODB;


-- data initalization
USE `uc`;

INSERT INTO `sys_menu` (`id`,`category`,`name`,`url`,`parent_id`,`flag`,`target`,`description`) VALUES 
(1,'系统管理','系统管理',NULL,NULL,NULL,NULL,NULL),
(2,'系统管理','组织管理','/org/list',1,NULL,NULL,NULL),
(3,'系统管理','角色管理','/role/list',1,NULL,NULL,NULL),
(4,'系统管理','用户管理','/user/list',1,NULL,NULL,NULL),
(5,'系统管理','系统日志','/log/list',1,NULL,NULL,NULL),
(11,'模板管理','模板管理','',NULL,NULL,NULL,NULL),
(12,'模板管理','OP模板','/op/list',11,NULL,NULL,NULL),
(13,'模板管理','APN模板','/apn/list',11,NULL,NULL,NULL),
(14,'模板管理','APN组模板','/apngroup/list',11,NULL,NULL,NULL),
(15,'模板管理','业务模板','/biz/list',11,NULL,NULL,NULL),
(21,'资源管理','资源管理',NULL,NULL,NULL,NULL,NULL),
(22,'资源管理','IMSI管理','/imsi/list',21,NULL,NULL,NULL),
(23,'资源管理','静态IP管理','/ip/list',21,NULL,NULL,NULL),
(24,'资源管理','组织管理','/resorg/list',21,NULL,NULL,NULL),
(25,'资源管理','号段管理','/no/list',21,NULL,NULL,NULL),
(26,'资源管理','白名单管理','/whitelist/list',21,NULL,NULL,NULL),
(27,'资源管理','黑名单管理','/blacklist/list',21,NULL,NULL,NULL),
(31,'用户管理','用户管理',NULL,NULL,NULL,NULL,NULL),
(32,'用户管理','用户信息','/userinfo/list',31,NULL,NULL,NULL),
(33,'用户管理','用户开户','/openaccount/list',31,NULL,NULL,NULL),
(34,'用户管理','批量开户','/importaccout/list',31,NULL,NULL,NULL),
(35,'用户管理','用户状态','/userstatus/list',31,NULL,NULL,NULL),
(36,'用户管理','组信息','/groupinfo/list',31,NULL,NULL,NULL);

INSERT INTO `sys_menu_class` (`id`,`menu_id`,`name`,`class_name`,`method`) VALUES 
(1001,2,'增（Create）','com.framework.entity.SysOrganization','SysOrganization:create'),
(1002,2,'删（Delete）','com.framework.entity.SysOrganization','SysOrganization:delete'),
(1003,2,'改（Update）','com.framework.entity.SysOrganization','SysOrganization:update'),
(1004,2,'查（View）','com.framework.entity.SysOrganization','SysOrganization:view'),
(1005,3,'增（Create）','com.framework.entity.SysRole','SysRole:create'),
(1006,3,'删（Delete）','com.framework.entity.SysRole','SysRole:delete'),
(1007,3,'改（Update）','com.framework.entity.SysRole','SysRole:update'),
(1008,3,'查（View）','com.framework.entity.SysRole','SysRole:view'),
(1009,4,'增（Create）','com.framework.entity.SysUser','SysUser:create'),
(1010,4,'删（Delete）','com.framework.entity.SysUser','SysUser:delete'),
(1011,4,'改（Update）','com.framework.entity.SysUser','SysUser:update'),
(1012,4,'查（View）','com.framework.entity.SysUser','SysUser:view'),
(1013,5,'增（Create）','com.framework.entity.SysLog','SysLog:create'),
(1014,5,'删（Delete）','com.framework.entity.SysLog','SysLog:delete'),
(1015,5,'改（Update）','com.framework.entity.SysLog','SysLog:update'),
(1016,5,'查（View）','com.framework.entity.SysLog','SysLog:view'),
(1017,12,'增（Create）','com.uc.entity.OPTpl','OPTpl:create'),
(1018,12,'删（Delete）','com.uc.entity.OPTpl','OPTpl:delete'),
(1019,12,'改（Update）','com.uc.entity.OPTpl','OPTpl:update'),
(1020,12,'查（View）','com.uc.entity.OPTpl','OPTpl:view'),
(1021,13,'增（Create）','com.uc.entity.APNTpl','APNTpl:create'),
(1022,13,'删（Delete）','com.uc.entity.APNTpl','APNTpl:delete'),
(1023,13,'改（Update）','com.uc.entity.APNTpl','APNTpl:update'),
(1024,13,'查（View）','com.uc.entity.APNTpl','APNTpl:view'),
(1025,14,'增（Create）','com.uc.entity.APNGroupTpl','APNGroupTpl:create'),
(1026,14,'删（Delete）','com.uc.entity.APNGroupTpl','APNGroupTpl:delete'),
(1027,14,'改（Update）','com.uc.entity.APNGroupTpl','APNGroupTpl:update'),
(1028,14,'查（View）','com.uc.entity.APNGroupTpl','APNGroupTpl:view'),
(1029,15,'增（Create）','com.uc.entity.BizTpl','BizTpl:create'),
(1030,15,'删（Delete）','com.uc.entity.BizTpl','BizTpl:delete'),
(1031,15,'改（Update）','com.uc.entity.BizTpl','BizTpl:update'),
(1032,15,'查（View）','com.uc.entity.BizTpl','BizTpl:view'),
(1033,22,'增（Create）','com.uc.entity.IMSIInfo','IMSIInfo:create'),
(1034,22,'删（Delete）','com.uc.entity.IMSIInfo','IMSIInfo:delete'),
(1035,22,'改（Update）','com.uc.entity.IMSIInfo','IMSIInfo:update'),
(1036,22,'查（View）','com.uc.entity.IMSIInfo','IMSIInfo:view'),
(1037,23,'增（Create）','com.uc.entity.IPFInfo','IPFInfo:create'),
(1038,23,'删（Delete）','com.uc.entity.IPFInfo','IPFInfo:delete'),
(1039,23,'改（Update）','com.uc.entity.IPFInfo','IPFInfo:update'),
(1040,23,'查（View）','com.uc.entity.IPFInfo','IPFInfo:view'),
(1041,24,'增（Create）','com.uc.entity.Organization','Organization:create'),
(1042,24,'删（Delete）','com.uc.entity.Organization','Organization:delete'),
(1043,24,'改（Update）','com.uc.entity.Organization','Organization:update'),
(1044,24,'查（View）','com.uc.entity.Organization','Organization:view'),
(1045,25,'增（Create）','com.uc.entity.PhoneNoFInfo','PhoneNoFInfo:create'),
(1046,25,'删（Delete）','com.uc.entity.PhoneNoFInfo','PhoneNoFInfo:delete'),
(1047,25,'改（Update）','com.uc.entity.PhoneNoFInfo','PhoneNoFInfo:update'),
(1048,25,'查（View）','com.uc.entity.PhoneNoFInfo','PhoneNoFInfo:view'),
(1049,26,'增（Create）','com.uc.entity.BlackWhiteList','BlackWhiteList:create'),
(1050,26,'删（Delete）','com.uc.entity.BlackWhiteList','BlackWhiteList:delete'),
(1051,26,'改（Update）','com.uc.entity.BlackWhiteList','BlackWhiteList:update'),
(1052,26,'查（View）','com.uc.entity.BlackWhiteList','BlackWhiteList:view'),
(1053,27,'增（Create）','com.uc.entity.BlackWhiteList','BlackWhiteList:create'),
(1054,27,'删（Delete）','com.uc.entity.BlackWhiteList','BlackWhiteList:delete'),
(1055,27,'改（Update）','com.uc.entity.BlackWhiteList','BlackWhiteList:update'),
(1056,27,'查（View）','com.uc.entity.BlackWhiteList','BlackWhiteList:view'),
(1057,32,'增（Create）','com.uc.entity.UserAccount','UserAccount:create'),
(1058,32,'删（Delete）','com.uc.entity.UserAccount','UserAccount:delete'),
(1059,32,'改（Update）','com.uc.entity.UserAccount','UserAccount:update'),
(1060,32,'查（View）','com.uc.entity.UserAccount','UserAccount:view'),
(1061,33,'增（Create）','com.uc.entity.UserAccount','UserAccount:create'),
(1062,33,'删（Delete）','com.uc.entity.UserAccount','UserAccount:delete'),
(1063,33,'改（Update）','com.uc.entity.UserAccount','UserAccount:update'),
(1064,33,'查（View）','com.uc.entity.UserAccount','UserAccount:view'),
(1065,34,'增（Create）','com.uc.entity.UserAccount','UserAccount:create'),
(1066,34,'删（Delete）','com.uc.entity.UserAccount','UserAccount:delete'),
(1067,34,'改（Update）','com.uc.entity.UserAccount','UserAccount:update'),
(1068,34,'查（View）','com.uc.entity.UserAccount','UserAccount:view'),
(1069,35,'增（Create）','com.uc.entity.UserStatusInfo','UserStatusInfo:create'),
(1070,35,'删（Delete）','com.uc.entity.UserStatusInfo','UserStatusInfo:delete'),
(1071,35,'改（Update）','com.uc.entity.UserStatusInfo','UserStatusInfo:update'),
(1072,35,'查（View）','com.uc.entity.UserStatusInfo','UserStatusInfo:view'),
(1073,36,'增（Create）','com.uc.entity.GroupInOrg','GroupInOrg:create'),
(1074,36,'删（Delete）','com.uc.entity.GroupInOrg','GroupInOrg:delete'),
(1075,36,'改（Update）','com.uc.entity.GroupInOrg','GroupInOrg:update'),
(1076,36,'查（View）','com.uc.entity.GroupInOrg','GroupInOrg:view');

INSERT INTO `sys_role` (`id`,`name`,`description`) VALUES (1,'Admin','Admin');

insert into sys_role_permission(role_id, menu_id, menu_class_id)
(SELECT '1', m.id, c.id FROM sys_menu m left join sys_menu_class c on m.id = c.menu_id);

INSERT INTO `sys_user` (`id`, `uid`, `username`, `password`, `salt`, `realname`, `gender`, `photo`, `phone`, `country_code`, `nationality`, `individual_id`, `email`, `address`, `self_intro`, `is_vip`, `status`, `utype`, `org_id`, `role_id`, `gps`, `longitude`, `latitude`, `user_agent`, `last_login`, `create_time`, `modify_time`) 
VALUES('1','10001','admin','f0850817aee6fcd981ec4578314ee3bc8afdc61c','f40eaf1c6ec3efaf','','0',NULL,NULL,'0086',NULL,NULL,'xiewe9@163.com',NULL,'创建者','1','0','0',NULL,1,NULL,'0','0',NULL,NULL,NULL,NULL);
COMMIT;




