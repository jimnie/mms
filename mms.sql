/*
 Navicat Premium Data Transfer

 Source Server         : LOCAL_MYSQL
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : mms

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 20/04/2018 10:22:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for biz_oss_report
-- ----------------------------
DROP TABLE IF EXISTS `biz_oss_report`;
CREATE TABLE `biz_oss_report`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `json_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `template` bigint(20) NULL DEFAULT NULL,
  `t_id` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_rru672172c7fuoeawk2192ykq`(`template`) USING BTREE,
  CONSTRAINT `FK_rru672172c7fuoeawk2192ykq` FOREIGN KEY (`template`) REFERENCES `biz_oss_template` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_oss_report
-- ----------------------------
INSERT INTO `biz_oss_report` VALUES (1, '2017-04-07 15:45:55', '2017-04-07 15:45:55', '{\"T_B_7\":{\"FILLIN_DEPT\":\"a\",\"FILLIN_PERSON\":\"s\",\"TELEPHONE\":\"1234\",\"RES_PERSON\":\"d\",\"FILLIN_DATE\":\"2017\",\"DEVPRJ\":{\"DEVPRJ1\":\"1\",\"DEVPRJ2\":\"1\",\"DEVPRJ3\":\"1\",\"DEVPRJ4\":\"1\",\"DEVPRJ5\":\"1\",\"DEVPRJ6\":\"1\",\"DEVPRJ7\":\"1\",\"DEVPRJ8\":\"1\",\"DEVPRJ9\":\"1\",\"DEVPRJ100\":\"111\"},\"PRJMNG\":{\"PRJMNG1\":\"是\",\"PRJMNG2\":\"是\",\"PRJMNG3\":\"是\",\"PRJMNG4\":\"2\",\"PRJMNG5\":\"是\",\"PRJMNG6\":\"2\",\"PRJMNG7\":\"是\",\"PRJMNG8\":\"软件需求规范,代码安全设计规范,测试规范\",\"PRJMNG9\":\"是\",\"PRJMNG10\":\"是\",\"PRJMNG100\":\"222\"},\"DMDMNG\":{\"DMDMNG1\":\"是\",\"DMDMNG4\":\"333\",\"DMDMNG3\":\"安全需求\",\"DMDMNG100\":\"333\"},\"DEVMNG\":{\"DEVMNG1\":\"是\",\"DEVMNG2\":\"是\",\"DEVMNG3\":\"客户端安全,身份认证\",\"DEVMNG4\":\"444\",\"DEVMNG5\":\"是\",\"DEVMNG100\":\"444\"},\"TSTMNG\":{\"TSTMNG1\":\"是\",\"TSTMNG2\":\"是\",\"TSTMNG3\":\"是\",\"TSTMNG4\":\"手工检查,专业工具检查\",\"TSTMNG100\":\"555\"},\"VSNMNG\":{\"VSNMNG1\":\"是\",\"VSNMNG2\":\"专业工具管理\",\"VSNMNG100\":\"666\"},\"RLSMNG\":{\"RLSMNG1\":\"是\",\"RLSMNG2\":\"是\",\"RLSMNG3\":\"信息科技部门,业务部门\",\"RLSMNG100\":\"777\"},\"jiaoyanwei\":0,\"isempty\":\"\",\"itVersion\":\"16A\",\"itTitle\":\"T-B-7 信息科技开发测试管理情况表\"}}', 1, 'GzOsHCAF');
INSERT INTO `biz_oss_report` VALUES (3, '2017-04-19 10:43:42', '2017-04-19 10:43:42', '{\"T_B_7\":{\"FILLIN_DEPT\":\"\",\"FILLIN_PERSON\":\"\",\"TELEPHONE\":\"\",\"RES_PERSON\":\"\",\"FILLIN_DATE\":\"\",\"DEVPRJ\":{\"DEVPRJ1\":\"\",\"DEVPRJ2\":\"\",\"DEVPRJ3\":\"\",\"DEVPRJ4\":\"\",\"DEVPRJ5\":\"\",\"DEVPRJ6\":\"\",\"DEVPRJ7\":\"\",\"DEVPRJ8\":\"\",\"DEVPRJ9\":\"\",\"DEVPRJ100\":\"\"},\"PRJMNG\":{\"PRJMNG8\":\"\",\"PRJMNG100\":\"\"},\"DMDMNG\":{\"DMDMNG4\":\"\",\"DMDMNG3\":\"\",\"DMDMNG100\":\"\"},\"DEVMNG\":{\"DEVMNG3\":\"\",\"DEVMNG100\":\"\"},\"TSTMNG\":{\"TSTMNG4\":\"\",\"TSTMNG100\":\"\"},\"VSNMNG\":{\"VSNMNG100\":\"\"},\"RLSMNG\":{\"RLSMNG3\":\"\",\"RLSMNG100\":\"\"},\"jiaoyanwei\":0,\"isempty\":\"\",\"itVersion\":\"16A\",\"itTitle\":\"T-B-7 信息科技开发测试管理情况表\"}}', 1, 'GzOsHCAF');
INSERT INTO `biz_oss_report` VALUES (6, '2017-04-20 12:08:13', '2017-04-20 12:08:13', '{\"R_R_1\":{\"FILLIN_DEPT\":\"\",\"FILLIN_PERSON\":\"\",\"TELEPHONE\":\"\",\"RES_PERSON\":\"\",\"FILLIN_DATE\":\"\",\"RR1001\":{\"COL0\":\"11111111111111111111111111\"},\"jiaoyanwei\":0,\"isempty\":\"\",\"itVersion\":\"16A\",\"itTitle\":\"R-R-1 信息科技管理年度报告\"}}', 2, 'wuezTodY');

-- ----------------------------
-- Table structure for biz_oss_template
-- ----------------------------
DROP TABLE IF EXISTS `biz_oss_template`;
CREATE TABLE `biz_oss_template`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `abbr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT NULL,
  `t_id` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `root` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_jikwp51f09qwiyprflqveervw`(`t_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_oss_template
-- ----------------------------
INSERT INTO `biz_oss_template` VALUES (1, '2017-03-30 15:49:40', '2017-03-31 14:14:44', 'T-B-7', '信息科技开发测试管理情况表', b'1', 'GzOsHCAF', 'Y', '16A', 'T_B_7');
INSERT INTO `biz_oss_template` VALUES (2, '2017-04-18 10:46:40', '2017-04-18 10:46:37', 'R-R-1', '信息科技管理年度报告', b'1', 'wuezTodY', 'Y', '16A', 'R_R_1');
INSERT INTO `biz_oss_template` VALUES (3, '2017-04-20 14:33:52', '2017-04-20 14:33:55', 'T-Q-4', '信息科技内外部审计情况表', b'1', 'qGUSyi0y', 'Y', '16A', 'T_Q_4');

-- ----------------------------
-- Table structure for mms_inf_member
-- ----------------------------
DROP TABLE IF EXISTS `mms_inf_member`;
CREATE TABLE `mms_inf_member`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `amount` decimal(12, 2) NOT NULL,
  `balance` decimal(12, 2) NOT NULL,
  `birth` date NULL DEFAULT NULL,
  `card_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cn_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `district` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edu_degree` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `en_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `first_kid_birth` date NOT NULL,
  `first_kid_cn_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_kid_en_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `first_kid_sex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `industry` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `point` bigint(20) NOT NULL,
  `register_date` date NOT NULL,
  `relation` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `second_kid_birth` date NULL DEFAULT NULL,
  `second_kid_cn_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `second_kid_en_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `second_kid_sex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `state` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `street` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `third_kid_birth` date NULL DEFAULT NULL,
  `third_kid_cn_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `third_kid_en_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `third_kid_sex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `weixin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `member_rank` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_idt6jj6kgqvouxaorpka1517j`(`member_rank`) USING BTREE,
  CONSTRAINT `FK_idt6jj6kgqvouxaorpka1517j` FOREIGN KEY (`member_rank`) REFERENCES `mms_inf_member_rank` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mms_inf_member_category
-- ----------------------------
DROP TABLE IF EXISTS `mms_inf_member_category`;
CREATE TABLE `mms_inf_member_category`  (
  `m_id` bigint(20) NOT NULL,
  `c_id` bigint(20) NOT NULL,
  PRIMARY KEY (`m_id`, `c_id`) USING BTREE,
  INDEX `FK_u33ydwxcfor5g5qnpmojebjo`(`c_id`) USING BTREE,
  CONSTRAINT `FK_779ga9y1re30gmrt0diwgwwqi` FOREIGN KEY (`m_id`) REFERENCES `mms_inf_member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_u33ydwxcfor5g5qnpmojebjo` FOREIGN KEY (`c_id`) REFERENCES `mms_inf_theme_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mms_inf_member_rank
-- ----------------------------
DROP TABLE IF EXISTS `mms_inf_member_rank`;
CREATE TABLE `mms_inf_member_rank`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `amount` decimal(21, 6) NULL DEFAULT NULL,
  `is_default` bit(1) NOT NULL,
  `is_special` bit(1) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `scale` double NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_temv5crs58f9y3hg632f3k6ok`(`name`) USING BTREE,
  UNIQUE INDEX `UK_jyhf9oorx92y92h4d2asfep3s`(`amount`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mms_inf_rechargelog
-- ----------------------------
DROP TABLE IF EXISTS `mms_inf_rechargelog`;
CREATE TABLE `mms_inf_rechargelog`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `amount` decimal(19, 2) NOT NULL,
  `card_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `memberid` bigint(20) NOT NULL,
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mms_inf_theme
-- ----------------------------
DROP TABLE IF EXISTS `mms_inf_theme`;
CREATE TABLE `mms_inf_theme`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `begin_time` datetime(0) NULL DEFAULT NULL,
  `compere` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `duration` int(11) NULL DEFAULT NULL,
  `grade` int(11) NULL DEFAULT NULL,
  `max_count` int(11) NOT NULL,
  `price` decimal(19, 2) NULL DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `category` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_21nhl98wt4hllw7c6buc0rftb`(`category`) USING BTREE,
  CONSTRAINT `FK_21nhl98wt4hllw7c6buc0rftb` FOREIGN KEY (`category`) REFERENCES `mms_inf_theme_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mms_inf_theme_category
-- ----------------------------
DROP TABLE IF EXISTS `mms_inf_theme_category`;
CREATE TABLE `mms_inf_theme_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sort_no` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mms_inf_theme_member
-- ----------------------------
DROP TABLE IF EXISTS `mms_inf_theme_member`;
CREATE TABLE `mms_inf_theme_member`  (
  `t_id` bigint(20) NOT NULL,
  `m_id` bigint(20) NOT NULL,
  PRIMARY KEY (`t_id`, `m_id`) USING BTREE,
  INDEX `FK_byw2c0j0wrihfyb7iw6b4i53a`(`m_id`) USING BTREE,
  CONSTRAINT `FK_byw2c0j0wrihfyb7iw6b4i53a` FOREIGN KEY (`m_id`) REFERENCES `mms_inf_member` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_g9f0mfxt9x2x9e1re53aft2hk` FOREIGN KEY (`t_id`) REFERENCES `mms_inf_theme` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mms_sys_act
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_act`;
CREATE TABLE `mms_sys_act`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `en_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `handler` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sort_no` int(11) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_act
-- ----------------------------
INSERT INTO `mms_sys_act` VALUES (1, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'add', 'add', NULL, '添加操作', '添加', 1, 'status_01');
INSERT INTO `mms_sys_act` VALUES (2, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'edit', 'edit', NULL, '修改操作', '修改', 2, 'status_01');
INSERT INTO `mms_sys_act` VALUES (3, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'delete', 'delete', NULL, '删除操作', '删除', 3, 'status_01');
INSERT INTO `mms_sys_act` VALUES (4, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'query', 'query', NULL, '查询操作', '查询', 4, 'status_01');
INSERT INTO `mms_sys_act` VALUES (5, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'audit', 'audit', NULL, '审核操作', '审核', 5, 'status_01');
INSERT INTO `mms_sys_act` VALUES (6, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'view', 'view', NULL, '系统管理功能index页面', '视图', 6, 'status_01');
INSERT INTO `mms_sys_act` VALUES (7, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'resetPassword', 'resetPassword', NULL, '重置密码', '重置密码', 7, 'status_01');
INSERT INTO `mms_sys_act` VALUES (8, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'details', 'details', NULL, '查看详情操作', '查看', 8, 'status_01');
INSERT INTO `mms_sys_act` VALUES (9, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'export', 'export', NULL, '导出操作', '导出', 9, 'status_01');
INSERT INTO `mms_sys_act` VALUES (10, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'import', 'import', NULL, '导入操作', '导入', 10, 'status_01');
INSERT INTO `mms_sys_act` VALUES (11, '2017-03-28 15:07:50', '2017-03-28 15:07:50', 'commit', 'commit', NULL, '提交操作', '提交', 11, 'status_01');
INSERT INTO `mms_sys_act` VALUES (12, '2017-03-28 15:11:47', '2017-03-28 15:11:50', 'save', 'save', NULL, '保存操作', '保存', 12, 'status_01');
INSERT INTO `mms_sys_act` VALUES (13, '2017-03-29 14:19:33', '2017-03-29 14:19:33', 'assign_res', 'assignRes', NULL, '分配资源', '分配资源', 13, 'status_01');
INSERT INTO `mms_sys_act` VALUES (14, '2017-03-29 14:20:12', '2017-03-29 14:20:12', 'assign_auth', 'assignAuth', NULL, '分配动作权限', '分配权限', 14, 'status_01');
INSERT INTO `mms_sys_act` VALUES (15, '2017-03-29 14:26:07', '2017-03-29 14:26:07', 'assign_user', 'assignUser', NULL, '用户分配给组', '分配用户', 15, 'status_01');
INSERT INTO `mms_sys_act` VALUES (16, '2017-03-29 14:26:50', '2017-03-29 14:26:50', 'assign_role', 'assignRle', NULL, '角色分配给组', '分配角色', 16, 'status_01');

-- ----------------------------
-- Table structure for mms_sys_area
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_area`;
CREATE TABLE `mms_sys_area`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `orders` int(11) NULL DEFAULT NULL,
  `full_name` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tree_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_otmuahcsikrm8bplu8nar2r4k`(`parent`) USING BTREE,
  CONSTRAINT `FK_otmuahcsikrm8bplu8nar2r4k` FOREIGN KEY (`parent`) REFERENCES `mms_sys_area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mms_sys_auth_role
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_auth_role`;
CREATE TABLE `mms_sys_auth_role`  (
  `role_id` bigint(20) NULL DEFAULT NULL,
  `auth_id` bigint(20) NOT NULL,
  PRIMARY KEY (`auth_id`) USING BTREE,
  INDEX `FK_8aftkeuqa9nj2c1uar4tkdmxg`(`role_id`) USING BTREE,
  CONSTRAINT `FK_8aftkeuqa9nj2c1uar4tkdmxg` FOREIGN KEY (`role_id`) REFERENCES `mms_sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_a9jedr59jginhxrfl8byrtppo` FOREIGN KEY (`auth_id`) REFERENCES `mms_sys_authority` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_auth_role
-- ----------------------------
INSERT INTO `mms_sys_auth_role` VALUES (1, 1);
INSERT INTO `mms_sys_auth_role` VALUES (1, 2);
INSERT INTO `mms_sys_auth_role` VALUES (1, 3);
INSERT INTO `mms_sys_auth_role` VALUES (1, 5);
INSERT INTO `mms_sys_auth_role` VALUES (1, 6);
INSERT INTO `mms_sys_auth_role` VALUES (1, 7);
INSERT INTO `mms_sys_auth_role` VALUES (1, 8);
INSERT INTO `mms_sys_auth_role` VALUES (1, 9);
INSERT INTO `mms_sys_auth_role` VALUES (1, 10);
INSERT INTO `mms_sys_auth_role` VALUES (1, 11);
INSERT INTO `mms_sys_auth_role` VALUES (1, 12);
INSERT INTO `mms_sys_auth_role` VALUES (1, 13);
INSERT INTO `mms_sys_auth_role` VALUES (1, 14);
INSERT INTO `mms_sys_auth_role` VALUES (1, 15);
INSERT INTO `mms_sys_auth_role` VALUES (1, 16);
INSERT INTO `mms_sys_auth_role` VALUES (1, 17);
INSERT INTO `mms_sys_auth_role` VALUES (1, 18);
INSERT INTO `mms_sys_auth_role` VALUES (1, 19);
INSERT INTO `mms_sys_auth_role` VALUES (1, 20);
INSERT INTO `mms_sys_auth_role` VALUES (1, 21);
INSERT INTO `mms_sys_auth_role` VALUES (1, 22);
INSERT INTO `mms_sys_auth_role` VALUES (1, 23);
INSERT INTO `mms_sys_auth_role` VALUES (1, 24);
INSERT INTO `mms_sys_auth_role` VALUES (1, 25);
INSERT INTO `mms_sys_auth_role` VALUES (1, 26);
INSERT INTO `mms_sys_auth_role` VALUES (1, 27);
INSERT INTO `mms_sys_auth_role` VALUES (1, 29);
INSERT INTO `mms_sys_auth_role` VALUES (1, 30);
INSERT INTO `mms_sys_auth_role` VALUES (1, 31);
INSERT INTO `mms_sys_auth_role` VALUES (1, 32);
INSERT INTO `mms_sys_auth_role` VALUES (1, 33);
INSERT INTO `mms_sys_auth_role` VALUES (1, 34);

-- ----------------------------
-- Table structure for mms_sys_authority
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_authority`;
CREATE TABLE `mms_sys_authority`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `act_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `act_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `resource_id` bigint(20) NULL DEFAULT NULL,
  `resource_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_authority
-- ----------------------------
INSERT INTO `mms_sys_authority` VALUES (1, '2017-03-28 16:44:13', '2017-03-28 16:44:16', 'user_view', '用户视图', 'user:view', 21, '用户管理', 1);
INSERT INTO `mms_sys_authority` VALUES (2, '2017-03-28 17:05:55', '2017-03-28 17:05:57', 'group_view', '组视图', 'group:view', 17, '组管理', 1);
INSERT INTO `mms_sys_authority` VALUES (3, '2017-03-28 17:07:04', '2017-03-28 17:07:06', 'role_view', '角色视图', 'role:view', 13, '角色管理', 1);
INSERT INTO `mms_sys_authority` VALUES (4, '2017-03-29 10:37:32', '2017-03-29 10:37:34', 'dict_view', '字典视图', 'dict:view', 4, '系统字典', 1);
INSERT INTO `mms_sys_authority` VALUES (5, '2017-03-29 14:14:44', '2017-03-29 14:14:44', 'add', '添加', 'user:add', 21, '用户管理', 1);
INSERT INTO `mms_sys_authority` VALUES (6, '2017-03-29 14:14:44', '2017-03-29 14:14:44', 'edit', '修改', 'user:edit', 21, '用户管理', 1);
INSERT INTO `mms_sys_authority` VALUES (7, '2017-03-29 14:14:44', '2017-03-29 14:14:44', 'delete', '删除', 'user:delete', 21, '用户管理', 1);
INSERT INTO `mms_sys_authority` VALUES (8, '2017-03-29 14:14:44', '2017-03-29 14:14:44', 'query', '查询', 'user:query', 21, '用户管理', 1);
INSERT INTO `mms_sys_authority` VALUES (9, '2017-03-29 14:16:18', '2017-03-29 14:16:18', 'add', '添加', 'dict:add', 3, '系统字典', 1);
INSERT INTO `mms_sys_authority` VALUES (10, '2017-03-29 14:16:18', '2017-03-29 14:16:18', 'edit', '修改', 'dict:edit', 3, '系统字典', 1);
INSERT INTO `mms_sys_authority` VALUES (11, '2017-03-29 14:16:18', '2017-03-29 14:16:18', 'delete', '删除', 'dict:delete', 3, '系统字典', 1);
INSERT INTO `mms_sys_authority` VALUES (12, '2017-03-29 14:16:18', '2017-03-29 14:16:18', 'query', '查询', 'dict:query', 3, '系统字典', 1);
INSERT INTO `mms_sys_authority` VALUES (13, '2017-03-29 14:16:18', '2017-03-29 14:16:18', 'view', '视图', 'dict:view', 3, '系统字典', 1);
INSERT INTO `mms_sys_authority` VALUES (14, '2017-03-29 14:17:14', '2017-03-29 14:17:14', 'add', '添加', 'act:add', 27, '动作权限', 1);
INSERT INTO `mms_sys_authority` VALUES (15, '2017-03-29 14:17:15', '2017-03-29 14:17:15', 'edit', '修改', 'act:edit', 27, '动作权限', 1);
INSERT INTO `mms_sys_authority` VALUES (16, '2017-03-29 14:17:15', '2017-03-29 14:17:15', 'delete', '删除', 'act:delete', 27, '动作权限', 1);
INSERT INTO `mms_sys_authority` VALUES (17, '2017-03-29 14:17:15', '2017-03-29 14:17:15', 'query', '查询', 'act:query', 27, '动作权限', 1);
INSERT INTO `mms_sys_authority` VALUES (18, '2017-03-29 14:17:15', '2017-03-29 14:17:15', 'view', '视图', 'act:view', 27, '动作权限', 1);
INSERT INTO `mms_sys_authority` VALUES (19, '2017-03-29 14:18:31', '2017-03-29 14:18:31', 'add', '添加', 'role:add', 13, '角色管理', 1);
INSERT INTO `mms_sys_authority` VALUES (20, '2017-03-29 14:18:31', '2017-03-29 14:18:31', 'edit', '修改', 'role:edit', 13, '角色管理', 1);
INSERT INTO `mms_sys_authority` VALUES (21, '2017-03-29 14:18:31', '2017-03-29 14:18:31', 'delete', '删除', 'role:delete', 13, '角色管理', 1);
INSERT INTO `mms_sys_authority` VALUES (22, '2017-03-29 14:18:31', '2017-03-29 14:18:31', 'query', '查询', 'role:query', 13, '角色管理', 1);
INSERT INTO `mms_sys_authority` VALUES (23, '2017-03-29 14:21:35', '2017-03-29 14:21:35', 'assign_res', '分配资源', 'role:assign_res', 13, '角色管理', 1);
INSERT INTO `mms_sys_authority` VALUES (24, '2017-03-29 14:21:35', '2017-03-29 14:21:35', 'assign_auth', '分配权限', 'role:assign_auth', 13, '角色管理', 1);
INSERT INTO `mms_sys_authority` VALUES (25, '2017-03-29 14:22:44', '2017-03-29 14:22:44', 'add', '添加', 'resource:add', 8, '资源管理', 1);
INSERT INTO `mms_sys_authority` VALUES (26, '2017-03-29 14:22:44', '2017-03-29 14:22:44', 'edit', '修改', 'resource:edit', 8, '资源管理', 1);
INSERT INTO `mms_sys_authority` VALUES (27, '2017-03-29 14:22:44', '2017-03-29 14:22:44', 'delete', '删除', 'resource:delete', 8, '资源管理', 1);
INSERT INTO `mms_sys_authority` VALUES (29, '2017-03-29 14:22:44', '2017-03-29 14:22:44', 'view', '视图', 'resource:view', 8, '资源管理', 1);
INSERT INTO `mms_sys_authority` VALUES (30, '2017-03-29 16:08:27', '2017-03-29 16:08:27', 'add', '添加', 'member:add', 35, '会员管理', 1);
INSERT INTO `mms_sys_authority` VALUES (31, '2017-03-29 16:08:27', '2017-03-29 16:08:27', 'edit', '修改', 'member:edit', 35, '会员管理', 1);
INSERT INTO `mms_sys_authority` VALUES (32, '2017-03-29 16:08:27', '2017-03-29 16:08:27', 'delete', '删除', 'member:delete', 35, '会员管理', 1);
INSERT INTO `mms_sys_authority` VALUES (33, '2017-03-29 16:08:27', '2017-03-29 16:08:27', 'query', '查询', 'member:query', 35, '会员管理', 1);
INSERT INTO `mms_sys_authority` VALUES (34, '2017-03-29 16:08:27', '2017-03-29 16:08:27', 'view', '视图', 'member:view', 35, '会员管理', 1);

-- ----------------------------
-- Table structure for mms_sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_dict`;
CREATE TABLE `mms_sys_dict`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort_no` int(11) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `updatable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_dict
-- ----------------------------
INSERT INTO `mms_sys_dict` VALUES (1, '2017-03-28 14:20:25', '2017-03-28 14:20:25', 'admin', '域是否可编辑', '是', 'updatable', 1, 'status_01', 0, 'updatable_02', 'updatable_01');
INSERT INTO `mms_sys_dict` VALUES (2, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', '域是否可编辑', '否', 'updatable', 2, 'status_01', 0, 'updatable_02', 'updatable_02');
INSERT INTO `mms_sys_dict` VALUES (3, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', '数据为启用状态', '启用', 'status', 1, 'status_01', 0, 'updatable_02', 'status_01');
INSERT INTO `mms_sys_dict` VALUES (4, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', '数据为启用状态', '禁用', 'status', 2, 'status_01', 0, 'updatable_02', 'status_02');
INSERT INTO `mms_sys_dict` VALUES (11, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', '树形分支节点的状态', '展开', 'nodeState', 1, 'status_01', 1, 'updatable_01', 'open');
INSERT INTO `mms_sys_dict` VALUES (12, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', '树形分支节点的状态', '关闭', 'nodeState', 2, 'status_01', 2, 'updatable_01', 'closed');
INSERT INTO `mms_sys_dict` VALUES (13, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', NULL, '导航栏', 'resourceType', 1, 'status_01', 1, 'updatable_01', 'resource_01');
INSERT INTO `mms_sys_dict` VALUES (14, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', NULL, '模块', 'resourceType', 2, 'status_01', 2, 'updatable_01', 'resource_02');
INSERT INTO `mms_sys_dict` VALUES (15, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', NULL, '菜单项', 'resourceType', 3, 'status_01', 3, 'updatable_01', 'resource_03');
INSERT INTO `mms_sys_dict` VALUES (16, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', NULL, '是', 'isLeaf', 1, 'status_01', 1, 'updatable_01', 'isleaf_01');
INSERT INTO `mms_sys_dict` VALUES (17, '2017-03-28 14:23:17', '2017-03-28 14:23:17', 'admin', NULL, '否', 'isLeaf', 2, 'status_01', 2, 'updatable_01', 'isleaf_02');
INSERT INTO `mms_sys_dict` VALUES (25, '2017-03-28 14:23:18', '2017-03-28 14:23:18', 'admin', '可编辑标志', '是', 'editable', 1, 'status_01', 1, 'updatable_02', 'editable_01');
INSERT INTO `mms_sys_dict` VALUES (26, '2017-03-28 14:23:18', '2017-03-28 14:23:18', 'admin', '可编辑标志', '否', 'editable', 2, 'status_01', 2, 'updatable_02', 'editable_02');
INSERT INTO `mms_sys_dict` VALUES (27, '2017-03-28 14:23:18', '2017-03-28 14:23:18', 'admin', NULL, '操作权限', 'resourceType', NULL, 'status_01', 4, 'updatable_01', 'resource_04');
INSERT INTO `mms_sys_dict` VALUES (28, '2017-03-29 09:55:25', '2017-03-29 09:55:25', 'admin', NULL, '是', 'isLocked', NULL, 'status_01', 1, 'updatable_02', 'true');
INSERT INTO `mms_sys_dict` VALUES (29, '2017-03-29 09:55:35', '2017-03-29 09:55:35', 'admin', NULL, '否', 'isLocked', NULL, 'status_01', 2, 'updatable_02', 'false');
INSERT INTO `mms_sys_dict` VALUES (30, '2017-03-29 09:55:58', '2017-03-29 09:55:58', 'admin', NULL, '是', 'isEnabled', NULL, 'status_01', 1, 'updatable_02', 'true');
INSERT INTO `mms_sys_dict` VALUES (31, '2017-03-29 09:56:08', '2017-03-29 09:56:08', 'admin', NULL, '否', 'isEnabled', NULL, 'status_01', 2, 'updatable_02', 'false');
INSERT INTO `mms_sys_dict` VALUES (32, '2017-03-29 09:56:23', '2017-03-29 09:56:23', 'admin', NULL, '是', 'isSystem', NULL, 'status_01', 1, 'updatable_02', 'true');
INSERT INTO `mms_sys_dict` VALUES (33, '2017-03-29 09:56:31', '2017-03-29 09:56:31', 'admin', NULL, '否', 'isSystem', NULL, 'status_01', 2, 'updatable_02', 'false');
INSERT INTO `mms_sys_dict` VALUES (34, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-sys', 'icon', 1, 'status_01', 0, 'updatable_02', 'icon-sys');
INSERT INTO `mms_sys_dict` VALUES (35, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-set', 'icon', 2, 'status_01', 0, 'updatable_02', 'icon-set');
INSERT INTO `mms_sys_dict` VALUES (36, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-nav', 'icon', 3, 'status_01', 0, 'updatable_02', 'icon-nav');
INSERT INTO `mms_sys_dict` VALUES (37, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-users', 'icon', 4, 'status_01', 0, 'updatable_02', 'icon-users');
INSERT INTO `mms_sys_dict` VALUES (38, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-role', 'icon', 5, 'status_01', 0, 'updatable_02', 'icon-role');
INSERT INTO `mms_sys_dict` VALUES (39, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-sets', 'icon', 6, 'status_01', 0, 'updatable_02', 'icon-sets');
INSERT INTO `mms_sys_dict` VALUES (40, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-log', 'icon', 7, 'status_01', 0, 'updatable_02', 'icon-log');
INSERT INTO `mms_sys_dict` VALUES (41, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-delete', 'icon', 8, 'status_01', 0, 'updatable_02', 'icon-delete');
INSERT INTO `mms_sys_dict` VALUES (42, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-magic', 'icon', 9, 'status_01', 0, 'updatable_02', 'icon-magic');
INSERT INTO `mms_sys_dict` VALUES (43, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-database', 'icon', 10, 'status_01', 0, 'updatable_02', 'icon-database');
INSERT INTO `mms_sys_dict` VALUES (44, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-calendar', 'icon', 11, 'status_01', 0, 'updatable_02', 'icon-calendar');
INSERT INTO `mms_sys_dict` VALUES (45, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-setting', 'icon', 12, 'status_01', 0, 'updatable_02', 'icon-setting');
INSERT INTO `mms_sys_dict` VALUES (46, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-group', 'icon', 13, 'status_01', 0, 'updatable_02', 'icon-group');
INSERT INTO `mms_sys_dict` VALUES (47, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-dict', 'icon', 14, 'status_01', 0, 'updatable_02', 'icon-dict');
INSERT INTO `mms_sys_dict` VALUES (48, '2017-03-29 15:16:44', '2017-03-29 15:16:44', 'admin', '模块菜单图标', 'icon-resource', 'icon', 15, 'status_01', 0, 'updatable_02', 'icon-resource');
INSERT INTO `mms_sys_dict` VALUES (49, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-auth', 'icon', 16, 'status_01', 0, 'updatable_02', 'icon-auth');
INSERT INTO `mms_sys_dict` VALUES (50, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-right', 'icon', 17, 'status_01', 0, 'updatable_02', 'icon-right');
INSERT INTO `mms_sys_dict` VALUES (51, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-missing', 'icon', 18, 'status_01', 0, 'updatable_02', 'icon-missing');
INSERT INTO `mms_sys_dict` VALUES (52, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-info', 'icon', 19, 'status_01', 0, 'updatable_02', 'icon-info');
INSERT INTO `mms_sys_dict` VALUES (53, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-win', 'icon', 20, 'status_01', 0, 'updatable_02', 'icon-win');
INSERT INTO `mms_sys_dict` VALUES (54, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-addwin', 'icon', 21, 'status_01', 0, 'updatable_02', 'icon-addwin');
INSERT INTO `mms_sys_dict` VALUES (55, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-noaccess', 'icon', 22, 'status_01', 0, 'updatable_02', 'icon-noaccess');
INSERT INTO `mms_sys_dict` VALUES (56, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-nosafe', 'icon', 23, 'status_01', 0, 'updatable_02', 'icon-nosafe');
INSERT INTO `mms_sys_dict` VALUES (57, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-form', 'icon', 24, 'status_01', 0, 'updatable_02', 'icon-form');
INSERT INTO `mms_sys_dict` VALUES (58, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-upload', 'icon', 25, 'status_01', 0, 'updatable_02', 'icon-upload');
INSERT INTO `mms_sys_dict` VALUES (59, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-goto', 'icon', 26, 'status_01', 0, 'updatable_02', 'icon-goto');
INSERT INTO `mms_sys_dict` VALUES (60, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-home', 'icon', 27, 'status_01', 0, 'updatable_02', 'icon-home');
INSERT INTO `mms_sys_dict` VALUES (61, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-conn', 'icon', 28, 'status_01', 0, 'updatable_02', 'icon-conn');
INSERT INTO `mms_sys_dict` VALUES (62, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-link', 'icon', 29, 'status_01', 0, 'updatable_02', 'icon-link');
INSERT INTO `mms_sys_dict` VALUES (63, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-download', 'icon', 30, 'status_01', 0, 'updatable_02', 'icon-download');
INSERT INTO `mms_sys_dict` VALUES (64, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-sort', 'icon', 31, 'status_01', 0, 'updatable_02', 'icon-sort');
INSERT INTO `mms_sys_dict` VALUES (65, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-onleft', 'icon', 32, 'status_01', 0, 'updatable_02', 'icon-onleft');
INSERT INTO `mms_sys_dict` VALUES (66, '2017-03-29 15:16:45', '2017-03-29 15:16:45', 'admin', '模块菜单图标', 'icon-onright', 'icon', 33, 'status_01', 0, 'updatable_02', 'icon-onright');
INSERT INTO `mms_sys_dict` VALUES (67, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-menu', 'icon', 34, 'status_01', 0, 'updatable_02', 'icon-menu');
INSERT INTO `mms_sys_dict` VALUES (68, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-tree', 'icon', 35, 'status_01', 0, 'updatable_02', 'icon-tree');
INSERT INTO `mms_sys_dict` VALUES (69, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-hori', 'icon', 36, 'status_01', 0, 'updatable_02', 'icon-hori');
INSERT INTO `mms_sys_dict` VALUES (70, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-vert', 'icon', 37, 'status_01', 0, 'updatable_02', 'icon-vert');
INSERT INTO `mms_sys_dict` VALUES (71, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-stack', 'icon', 38, 'status_01', 0, 'updatable_02', 'icon-stack');
INSERT INTO `mms_sys_dict` VALUES (72, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-col', 'icon', 39, 'status_01', 0, 'updatable_02', 'icon-col');
INSERT INTO `mms_sys_dict` VALUES (73, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-image', 'icon', 40, 'status_01', 0, 'updatable_02', 'icon-image');
INSERT INTO `mms_sys_dict` VALUES (74, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-review', 'icon', 41, 'status_01', 0, 'updatable_02', 'icon-review');
INSERT INTO `mms_sys_dict` VALUES (75, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-grid', 'icon', 42, 'status_01', 0, 'updatable_02', 'icon-grid');
INSERT INTO `mms_sys_dict` VALUES (76, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-tile', 'icon', 43, 'status_01', 0, 'updatable_02', 'icon-tile');
INSERT INTO `mms_sys_dict` VALUES (77, '2017-03-29 15:16:46', '2017-03-29 15:16:46', 'admin', '模块菜单图标', 'icon-money', 'icon', 44, 'status_01', 0, 'updatable_02', 'icon-money');
INSERT INTO `mms_sys_dict` VALUES (78, '2017-03-29 09:56:23', '2017-03-29 09:56:23', 'admin', '模板是否启用', '启用', 'enable', 45, 'status_01', 1, 'updatable_02', 'true');
INSERT INTO `mms_sys_dict` VALUES (79, '2017-03-29 09:56:23', '2017-03-29 09:56:23', 'admin', '模板是否启用', '禁用', 'enable', 46, 'status_01', 1, 'updatable_02', 'false');
INSERT INTO `mms_sys_dict` VALUES (80, '2017-03-30 15:34:23', '2017-03-30 15:34:23', 'admin', '模板类型', '月报', 'templateType', 47, 'status_01', 1, 'updatable_02', 'M');
INSERT INTO `mms_sys_dict` VALUES (81, '2017-03-30 15:34:50', '2017-03-30 15:34:50', 'admin', '模板类型', '季报', 'templateType', 48, 'status_01', 2, 'updatable_02', 'Q');
INSERT INTO `mms_sys_dict` VALUES (82, '2017-03-30 15:35:01', '2017-03-30 15:35:01', 'admin', '模板类型', '年报', 'templateType', 49, 'status_01', 3, 'updatable_02', 'Y');

-- ----------------------------
-- Table structure for mms_sys_group
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_group`;
CREATE TABLE `mms_sys_group`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `node_state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort_no` int(11) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_bytx377aah2ylfq1mgdb7us9b`(`tag`) USING BTREE,
  INDEX `FK_jce58dtx2umlaqij4gm6gsrs1`(`parent_id`) USING BTREE,
  CONSTRAINT `FK_jce58dtx2umlaqij4gm6gsrs1` FOREIGN KEY (`parent_id`) REFERENCES `mms_sys_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_group
-- ----------------------------
INSERT INTO `mms_sys_group` VALUES (1, '2017-03-28 14:45:59', '2017-03-28 14:45:59', NULL, '系统管理员组', 'closed', NULL, 'status_01', 'DBA', 0);
INSERT INTO `mms_sys_group` VALUES (2, '2017-03-28 14:45:59', '2017-03-28 14:45:59', NULL, '基础用户组', 'closed', NULL, 'status_01', 'baseUser', 0);
INSERT INTO `mms_sys_group` VALUES (3, '2017-03-28 14:44:48', '2017-03-28 14:44:48', NULL, '农商银行', 'open', 0, 'status_01', 'root', NULL);

-- ----------------------------
-- Table structure for mms_sys_group_role
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_group_role`;
CREATE TABLE `mms_sys_group_role`  (
  `group_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  INDEX `FK_a2ktxp95w8nqg6lvxjp1kbda9`(`role_id`) USING BTREE,
  INDEX `FK_4xfllkkki7dmlmfmvnr25tlta`(`group_id`) USING BTREE,
  CONSTRAINT `FK_4xfllkkki7dmlmfmvnr25tlta` FOREIGN KEY (`group_id`) REFERENCES `mms_sys_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_a2ktxp95w8nqg6lvxjp1kbda9` FOREIGN KEY (`role_id`) REFERENCES `mms_sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_group_role
-- ----------------------------
INSERT INTO `mms_sys_group_role` VALUES (1, 1);

-- ----------------------------
-- Table structure for mms_sys_group_user
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_group_user`;
CREATE TABLE `mms_sys_group_user`  (
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  INDEX `FK_ibjtalek5ifftyms8ktrhjaab`(`user_id`) USING BTREE,
  INDEX `FK_2t4r25dra6jb48ucdidml0899`(`group_id`) USING BTREE,
  CONSTRAINT `FK_2t4r25dra6jb48ucdidml0899` FOREIGN KEY (`group_id`) REFERENCES `mms_sys_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_ibjtalek5ifftyms8ktrhjaab` FOREIGN KEY (`user_id`) REFERENCES `mms_sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_group_user
-- ----------------------------
INSERT INTO `mms_sys_group_user` VALUES (1, 0);

-- ----------------------------
-- Table structure for mms_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_log`;
CREATE TABLE `mms_sys_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parameter` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_log
-- ----------------------------
INSERT INTO `mms_sys_log` VALUES (1, '2017-03-29 09:55:25', '2017-03-29 09:55:25', NULL, '127.0.0.1', NULL, '添加系统词典', 'admin', 'nickname = isLocked\nvalue = true\nname = 1\ntype = 1\nupdatable = updatable_02\nstatus = status_01\nsortNo = \nmemo = \ncreateDate = \nid = \n');
INSERT INTO `mms_sys_log` VALUES (2, '2017-03-29 09:55:35', '2017-03-29 09:55:35', NULL, '127.0.0.1', NULL, '添加系统词典', 'admin', 'nickname = isLocked\nvalue = false\nname = 0\ntype = 2\nupdatable = updatable_02\nstatus = status_01\nsortNo = \nmemo = \ncreateDate = \nid = \n');
INSERT INTO `mms_sys_log` VALUES (3, '2017-03-29 09:55:58', '2017-03-29 09:55:58', NULL, '127.0.0.1', NULL, '添加系统词典', 'admin', 'nickname = isEnabled\nvalue = true\nname = 1\ntype = 1\nupdatable = updatable_02\nstatus = status_01\nsortNo = \nmemo = \ncreateDate = \nid = \n');
INSERT INTO `mms_sys_log` VALUES (4, '2017-03-29 09:56:08', '2017-03-29 09:56:08', NULL, '127.0.0.1', NULL, '添加系统词典', 'admin', 'nickname = isEnabled\nvalue = false\nname = 0\ntype = 2\nupdatable = updatable_02\nstatus = status_01\nsortNo = \nmemo = \ncreateDate = \nid = \n');
INSERT INTO `mms_sys_log` VALUES (5, '2017-03-29 09:56:23', '2017-03-29 09:56:23', NULL, '127.0.0.1', NULL, '添加系统词典', 'admin', 'nickname = isSystem\nvalue = true\nname = 1\ntype = 1\nupdatable = updatable_02\nstatus = status_01\nsortNo = \nmemo = \ncreateDate = \nid = \n');
INSERT INTO `mms_sys_log` VALUES (6, '2017-03-29 09:56:31', '2017-03-29 09:56:31', NULL, '127.0.0.1', NULL, '添加系统词典', 'admin', 'nickname = isSystem\nvalue = false\nname = 0\ntype = 2\nupdatable = updatable_02\nstatus = status_01\nsortNo = \nmemo = \ncreateDate = \nid = \n');
INSERT INTO `mms_sys_log` VALUES (7, '2017-03-30 15:34:23', '2017-03-30 15:34:23', NULL, '127.0.0.1', NULL, '添加系统词典', 'admin', 'nickname = templateType\nvalue = 月\nname = M\ntype = 1\nupdatable = updatable_02\nstatus = status_01\nsortNo = 47\nmemo = 模板类型\ncreateDate = \nid = \n');
INSERT INTO `mms_sys_log` VALUES (8, '2017-03-30 15:34:50', '2017-03-30 15:34:50', NULL, '127.0.0.1', NULL, '添加系统词典', 'admin', 'nickname = templateType\nvalue = 季\nname = Q\ntype = 2\nupdatable = updatable_02\nstatus = status_01\nsortNo = 48\nmemo = 模板类型\ncreateDate = \nid = \n');
INSERT INTO `mms_sys_log` VALUES (9, '2017-03-30 15:35:01', '2017-03-30 15:35:01', NULL, '127.0.0.1', NULL, '添加系统词典', 'admin', 'nickname = templateType\nvalue = 年\nname = Y\ntype = 3\nupdatable = updatable_02\nstatus = status_01\nsortNo = 49\nmemo = 模板类型\ncreateDate = \nid = \n');

-- ----------------------------
-- Table structure for mms_sys_resource_auth
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_resource_auth`;
CREATE TABLE `mms_sys_resource_auth`  (
  `resource_id` bigint(20) NULL DEFAULT NULL,
  `auth_id` bigint(20) NOT NULL,
  PRIMARY KEY (`auth_id`) USING BTREE,
  INDEX `FK_3nrmxhsmpii92ib2c06yen95f`(`resource_id`) USING BTREE,
  CONSTRAINT `FK_3nrmxhsmpii92ib2c06yen95f` FOREIGN KEY (`resource_id`) REFERENCES `mms_sys_resources` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_puxaro34hm6ogn3bn4wfuu4l0` FOREIGN KEY (`auth_id`) REFERENCES `mms_sys_authority` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_resource_auth
-- ----------------------------
INSERT INTO `mms_sys_resource_auth` VALUES (3, 9);
INSERT INTO `mms_sys_resource_auth` VALUES (3, 10);
INSERT INTO `mms_sys_resource_auth` VALUES (3, 11);
INSERT INTO `mms_sys_resource_auth` VALUES (3, 12);
INSERT INTO `mms_sys_resource_auth` VALUES (3, 13);
INSERT INTO `mms_sys_resource_auth` VALUES (8, 25);
INSERT INTO `mms_sys_resource_auth` VALUES (8, 26);
INSERT INTO `mms_sys_resource_auth` VALUES (8, 27);
INSERT INTO `mms_sys_resource_auth` VALUES (8, 29);
INSERT INTO `mms_sys_resource_auth` VALUES (13, 19);
INSERT INTO `mms_sys_resource_auth` VALUES (13, 20);
INSERT INTO `mms_sys_resource_auth` VALUES (13, 21);
INSERT INTO `mms_sys_resource_auth` VALUES (13, 22);
INSERT INTO `mms_sys_resource_auth` VALUES (13, 23);
INSERT INTO `mms_sys_resource_auth` VALUES (13, 24);
INSERT INTO `mms_sys_resource_auth` VALUES (21, 5);
INSERT INTO `mms_sys_resource_auth` VALUES (21, 6);
INSERT INTO `mms_sys_resource_auth` VALUES (21, 7);
INSERT INTO `mms_sys_resource_auth` VALUES (21, 8);
INSERT INTO `mms_sys_resource_auth` VALUES (27, 14);
INSERT INTO `mms_sys_resource_auth` VALUES (27, 15);
INSERT INTO `mms_sys_resource_auth` VALUES (27, 16);
INSERT INTO `mms_sys_resource_auth` VALUES (27, 17);
INSERT INTO `mms_sys_resource_auth` VALUES (27, 18);
INSERT INTO `mms_sys_resource_auth` VALUES (35, 30);
INSERT INTO `mms_sys_resource_auth` VALUES (35, 31);
INSERT INTO `mms_sys_resource_auth` VALUES (35, 32);
INSERT INTO `mms_sys_resource_auth` VALUES (35, 33);
INSERT INTO `mms_sys_resource_auth` VALUES (35, 34);

-- ----------------------------
-- Table structure for mms_sys_resources
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_resources`;
CREATE TABLE `mms_sys_resources`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `alias_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_leaf` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `resource_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort_no` int(11) NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_e4ni34ha0hlieg7o3fp62is4v`(`parent_id`) USING BTREE,
  CONSTRAINT `FK_e4ni34ha0hlieg7o3fp62is4v` FOREIGN KEY (`parent_id`) REFERENCES `mms_sys_resources` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_resources
-- ----------------------------
INSERT INTO `mms_sys_resources` VALUES (1, '2017-03-28 14:38:35', '2017-03-28 14:38:35', 'sys', 'editable_02', NULL, 'isleaf_02', NULL, 'resource_01', 1, 'closed', 'status_01', '系统配置', NULL, 0);
INSERT INTO `mms_sys_resources` VALUES (2, '2017-03-28 14:38:35', '2017-03-28 14:38:35', NULL, 'editable_02', 'icon-sys', 'isleaf_02', NULL, 'resource_02', 1, 'closed', 'status_01', '系统管理', NULL, 1);
INSERT INTO `mms_sys_resources` VALUES (3, '2017-03-28 14:38:35', '2017-03-28 14:38:35', 'dict', 'editable_02', 'icon-nav', 'isleaf_01', NULL, 'resource_03', 1, 'open', 'status_01', '系统字典', '/dict/index', 2);
INSERT INTO `mms_sys_resources` VALUES (8, '2017-03-28 14:38:35', '2017-03-28 14:38:35', 'resource', 'editable_02', 'icon-sys', 'isleaf_01', NULL, 'resource_03', 2, 'open', 'status_01', '资源管理', '/resource/index', 2);
INSERT INTO `mms_sys_resources` VALUES (13, '2017-03-28 14:38:36', '2017-03-28 14:38:36', 'role', 'editable_02', 'icon-role', 'isleaf_01', NULL, 'resource_03', 3, 'open', 'status_01', '角色管理', '/role/index', 2);
INSERT INTO `mms_sys_resources` VALUES (17, '2017-03-28 14:38:36', '2017-03-28 14:38:36', 'group', 'editable_02', 'icon-magic', 'isleaf_01', NULL, 'resource_03', 4, 'open', 'status_01', '组管理', '/group/index', 2);
INSERT INTO `mms_sys_resources` VALUES (21, '2017-03-28 14:38:36', '2017-03-28 14:38:36', 'user', 'editable_02', 'icon-user', 'isleaf_01', NULL, 'resource_03', 5, 'open', 'status_01', '用户管理', '/user/index', 2);
INSERT INTO `mms_sys_resources` VALUES (27, '2017-03-28 14:38:36', '2017-03-28 14:38:36', 'act', 'editable_02', 'icon-magic', 'isleaf_01', NULL, 'resource_03', 6, 'open', 'status_01', '动作权限', '/act/index', 2);
INSERT INTO `mms_sys_resources` VALUES (29, '2017-03-28 14:38:37', '2017-03-28 14:38:37', 'base', 'editable_01', 'icon-sys', 'isleaf_02', NULL, 'resource_02', 2, 'closed', 'status_01', '基础数据', NULL, 1);
INSERT INTO `mms_sys_resources` VALUES (30, '2017-03-28 14:38:37', '2017-03-28 14:38:37', 'area', 'editable_01', 'icon-magic', 'isleaf_01', NULL, 'resource_03', 1, 'open', 'status_01', '行政区划', '/area/areaManage', 29);
INSERT INTO `mms_sys_resources` VALUES (32, '2017-03-28 14:38:37', '2017-03-29 14:46:04', 'tj', 'editable_01', NULL, 'isleaf_02', NULL, 'resource_01', 2, 'closed', 'status_01', '报送业务', NULL, 0);
INSERT INTO `mms_sys_resources` VALUES (33, '2017-03-29 14:48:39', '2017-03-29 14:48:39', NULL, 'editable_01', 'icon-log', 'isleaf_02', NULL, 'resource_02', 1, 'closed', 'status_01', '银监报送', NULL, 32);
INSERT INTO `mms_sys_resources` VALUES (34, '2017-03-29 14:50:20', '2017-03-29 14:50:20', 'report', 'editable_01', 'icon-log', 'isleaf_01', NULL, 'resource_03', 1, 'closed', 'status_01', '报送管理', '/report/index', 33);
INSERT INTO `mms_sys_resources` VALUES (35, '2017-03-29 16:06:35', '2017-03-29 16:06:35', 'member', 'editable_01', 'icon-users', 'isleaf_01', NULL, 'resource_03', 2, 'closed', 'status_01', '会员管理', '/member/index', 33);
INSERT INTO `mms_sys_resources` VALUES (36, '2017-03-28 14:37:36', '2017-03-28 14:37:36', NULL, 'editable_02', NULL, 'isleaf_02', NULL, 'ROOT', 0, 'closed', 'status_01', '银监报送平台', NULL, NULL);

-- ----------------------------
-- Table structure for mms_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_role`;
CREATE TABLE `mms_sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `editable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sort_no` int(11) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_r7ywkp7njesm447ids9b5x364`(`tag`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_role
-- ----------------------------
INSERT INTO `mms_sys_role` VALUES (1, '2017-03-28 13:08:22', '2017-03-28 13:08:25', 'editable_02', '系统管理员', '系统管理员', 1, 'status_01', 'administrator');
INSERT INTO `mms_sys_role` VALUES (2, '2017-03-29 13:31:01', '2017-03-29 13:31:01', 'editable_01', '业务功能用户', '普通用户', 2, 'status_01', 'user');

-- ----------------------------
-- Table structure for mms_sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_role_resource`;
CREATE TABLE `mms_sys_role_resource`  (
  `role_id` bigint(20) NOT NULL,
  `resource_id` bigint(20) NOT NULL,
  INDEX `FK_7sewsudjrshjl4r8hrtgh1672`(`resource_id`) USING BTREE,
  INDEX `FK_ddao12vls6780nw4dw93j7pxc`(`role_id`) USING BTREE,
  CONSTRAINT `FK_7sewsudjrshjl4r8hrtgh1672` FOREIGN KEY (`resource_id`) REFERENCES `mms_sys_resources` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_ddao12vls6780nw4dw93j7pxc` FOREIGN KEY (`role_id`) REFERENCES `mms_sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_role_resource
-- ----------------------------
INSERT INTO `mms_sys_role_resource` VALUES (1, 0);
INSERT INTO `mms_sys_role_resource` VALUES (1, 1);
INSERT INTO `mms_sys_role_resource` VALUES (1, 2);
INSERT INTO `mms_sys_role_resource` VALUES (1, 3);
INSERT INTO `mms_sys_role_resource` VALUES (1, 8);
INSERT INTO `mms_sys_role_resource` VALUES (1, 13);
INSERT INTO `mms_sys_role_resource` VALUES (1, 17);
INSERT INTO `mms_sys_role_resource` VALUES (1, 21);
INSERT INTO `mms_sys_role_resource` VALUES (1, 27);
INSERT INTO `mms_sys_role_resource` VALUES (1, 29);
INSERT INTO `mms_sys_role_resource` VALUES (1, 30);
INSERT INTO `mms_sys_role_resource` VALUES (1, 32);
INSERT INTO `mms_sys_role_resource` VALUES (1, 33);
INSERT INTO `mms_sys_role_resource` VALUES (1, 34);
INSERT INTO `mms_sys_role_resource` VALUES (1, 35);

-- ----------------------------
-- Table structure for mms_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `mms_sys_user`;
CREATE TABLE `mms_sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(0) NOT NULL,
  `modify_date` datetime(0) NOT NULL,
  `is_enabled` bit(1) NOT NULL,
  `is_locked` bit(1) NOT NULL,
  `is_system` bit(1) NULL DEFAULT NULL,
  `locked_date` datetime(0) NULL DEFAULT NULL,
  `login_date` datetime(0) NULL DEFAULT NULL,
  `login_failure_count` int(11) NULL DEFAULT 0,
  `login_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_r0xw8hjv356bcpi1ejvphdpgv`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mms_sys_user
-- ----------------------------
INSERT INTO `mms_sys_user` VALUES (1, '2017-03-28 11:19:40', '2017-04-26 17:15:55', b'1', b'0', b'1', NULL, '2017-04-26 17:15:54', 0, '127.0.0.1', 'e10adc3949ba59abbe56e057f20f883e', 'admin');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `a` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
