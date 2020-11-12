/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : bffast

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 10/11/2020 12:00:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `job_id`(`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行政区划代码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行政单位名称',
  `level` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '层级 1-省级 2-市级 3-县级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3220 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_中国行政区划' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_area
-- ----------------------------
INSERT INTO `sys_area` VALUES (1, -1, '110000', '北京市', '1');
INSERT INTO `sys_area` VALUES (2, 1, '110101', '东城区', '3');
INSERT INTO `sys_area` VALUES (3, 1, '110102', '西城区', '3');
INSERT INTO `sys_area` VALUES (4, 1, '110105', '朝阳区', '3');
INSERT INTO `sys_area` VALUES (5, 1, '110106', '丰台区', '3');
INSERT INTO `sys_area` VALUES (6, 1, '110107', '石景山区', '3');
INSERT INTO `sys_area` VALUES (7, 1, '110108', '海淀区', '3');
INSERT INTO `sys_area` VALUES (8, 1, '110109', '门头沟区', '3');
INSERT INTO `sys_area` VALUES (9, 1, '110111', '房山区', '3');
INSERT INTO `sys_area` VALUES (10, 1, '110112', '通州区', '3');
INSERT INTO `sys_area` VALUES (11, 1, '110113', '顺义区', '3');
INSERT INTO `sys_area` VALUES (12, 1, '110114', '昌平区', '3');
INSERT INTO `sys_area` VALUES (13, 1, '110115', '大兴区', '3');
INSERT INTO `sys_area` VALUES (14, 1, '110116', '怀柔区', '3');
INSERT INTO `sys_area` VALUES (15, 1, '110117', '平谷区', '3');
INSERT INTO `sys_area` VALUES (16, 1, '110118', '密云区', '3');
INSERT INTO `sys_area` VALUES (17, 1, '110119', '延庆区', '3');
INSERT INTO `sys_area` VALUES (18, -1, '120000', '天津市', '1');
INSERT INTO `sys_area` VALUES (19, 18, '120101', '和平区', '3');
INSERT INTO `sys_area` VALUES (20, 18, '120102', '河东区', '3');
INSERT INTO `sys_area` VALUES (21, 18, '120103', '河西区', '3');
INSERT INTO `sys_area` VALUES (22, 18, '120104', '南开区', '3');
INSERT INTO `sys_area` VALUES (23, 18, '120105', '河北区', '3');
INSERT INTO `sys_area` VALUES (24, 18, '120106', '红桥区', '3');
INSERT INTO `sys_area` VALUES (25, 18, '120110', '东丽区', '3');
INSERT INTO `sys_area` VALUES (26, 18, '120111', '西青区', '3');
INSERT INTO `sys_area` VALUES (27, 18, '120112', '津南区', '3');
INSERT INTO `sys_area` VALUES (28, 18, '120113', '北辰区', '3');
INSERT INTO `sys_area` VALUES (29, 18, '120114', '武清区', '3');
INSERT INTO `sys_area` VALUES (30, 18, '120115', '宝坻区', '3');
INSERT INTO `sys_area` VALUES (31, 18, '120116', '滨海新区', '3');
INSERT INTO `sys_area` VALUES (32, 18, '120117', '宁河区', '3');
INSERT INTO `sys_area` VALUES (33, 18, '120118', '静海区', '3');
INSERT INTO `sys_area` VALUES (34, 18, '120119', '蓟州区', '3');
INSERT INTO `sys_area` VALUES (35, -1, '130000', '河北省', '1');
INSERT INTO `sys_area` VALUES (36, 35, '130100', '石家庄市', '2');
INSERT INTO `sys_area` VALUES (37, 36, '130102', '长安区', '3');
INSERT INTO `sys_area` VALUES (38, 36, '130104', '桥西区', '3');
INSERT INTO `sys_area` VALUES (39, 36, '130105', '新华区', '3');
INSERT INTO `sys_area` VALUES (40, 36, '130107', '井陉矿区', '3');
INSERT INTO `sys_area` VALUES (41, 36, '130108', '裕华区', '3');
INSERT INTO `sys_area` VALUES (42, 36, '130109', '藁城区', '3');
INSERT INTO `sys_area` VALUES (43, 36, '130110', '鹿泉区', '3');
INSERT INTO `sys_area` VALUES (44, 36, '130111', '栾城区', '3');
INSERT INTO `sys_area` VALUES (45, 36, '130121', '井陉县', '3');
INSERT INTO `sys_area` VALUES (46, 36, '130123', '正定县', '3');
INSERT INTO `sys_area` VALUES (47, 36, '130125', '行唐县', '3');
INSERT INTO `sys_area` VALUES (48, 36, '130126', '灵寿县', '3');
INSERT INTO `sys_area` VALUES (49, 36, '130127', '高邑县', '3');
INSERT INTO `sys_area` VALUES (50, 36, '130128', '深泽县', '3');
INSERT INTO `sys_area` VALUES (51, 36, '130129', '赞皇县', '3');
INSERT INTO `sys_area` VALUES (52, 36, '130130', '无极县', '3');
INSERT INTO `sys_area` VALUES (53, 36, '130131', '平山县', '3');
INSERT INTO `sys_area` VALUES (54, 36, '130132', '元氏县', '3');
INSERT INTO `sys_area` VALUES (55, 36, '130133', '赵县', '3');
INSERT INTO `sys_area` VALUES (56, 36, '130181', '辛集市', '3');
INSERT INTO `sys_area` VALUES (57, 36, '130183', '晋州市', '3');
INSERT INTO `sys_area` VALUES (58, 36, '130184', '新乐市', '3');
INSERT INTO `sys_area` VALUES (59, 35, '130200', '唐山市', '2');
INSERT INTO `sys_area` VALUES (60, 59, '130202', '路南区', '3');
INSERT INTO `sys_area` VALUES (61, 59, '130203', '路北区', '3');
INSERT INTO `sys_area` VALUES (62, 59, '130204', '古冶区', '3');
INSERT INTO `sys_area` VALUES (63, 59, '130205', '开平区', '3');
INSERT INTO `sys_area` VALUES (64, 59, '130207', '丰南区', '3');
INSERT INTO `sys_area` VALUES (65, 59, '130208', '丰润区', '3');
INSERT INTO `sys_area` VALUES (66, 59, '130209', '曹妃甸区', '3');
INSERT INTO `sys_area` VALUES (67, 59, '130224', '滦南县', '3');
INSERT INTO `sys_area` VALUES (68, 59, '130225', '乐亭县', '3');
INSERT INTO `sys_area` VALUES (69, 59, '130227', '迁西县', '3');
INSERT INTO `sys_area` VALUES (70, 59, '130229', '玉田县', '3');
INSERT INTO `sys_area` VALUES (71, 59, '130281', '遵化市', '3');
INSERT INTO `sys_area` VALUES (72, 59, '130283', '迁安市', '3');
INSERT INTO `sys_area` VALUES (73, 59, '130284', '滦州市', '3');
INSERT INTO `sys_area` VALUES (74, 35, '130300', '秦皇岛市', '2');
INSERT INTO `sys_area` VALUES (75, 74, '130302', '海港区', '3');
INSERT INTO `sys_area` VALUES (76, 74, '130303', '山海关区', '3');
INSERT INTO `sys_area` VALUES (77, 74, '130304', '北戴河区', '3');
INSERT INTO `sys_area` VALUES (78, 74, '130306', '抚宁区', '3');
INSERT INTO `sys_area` VALUES (79, 74, '130321', '青龙满族自治县', '3');
INSERT INTO `sys_area` VALUES (80, 74, '130322', '昌黎县', '3');
INSERT INTO `sys_area` VALUES (81, 74, '130324', '卢龙县', '3');
INSERT INTO `sys_area` VALUES (82, 35, '130400', '邯郸市', '2');
INSERT INTO `sys_area` VALUES (83, 82, '130402', '邯山区', '3');
INSERT INTO `sys_area` VALUES (84, 82, '130403', '丛台区', '3');
INSERT INTO `sys_area` VALUES (85, 82, '130404', '复兴区', '3');
INSERT INTO `sys_area` VALUES (86, 82, '130406', '峰峰矿区', '3');
INSERT INTO `sys_area` VALUES (87, 82, '130407', '肥乡区', '3');
INSERT INTO `sys_area` VALUES (88, 82, '130408', '永年区', '3');
INSERT INTO `sys_area` VALUES (89, 82, '130423', '临漳县', '3');
INSERT INTO `sys_area` VALUES (90, 82, '130424', '成安县', '3');
INSERT INTO `sys_area` VALUES (91, 82, '130425', '大名县', '3');
INSERT INTO `sys_area` VALUES (92, 82, '130426', '涉县', '3');
INSERT INTO `sys_area` VALUES (93, 82, '130427', '磁县', '3');
INSERT INTO `sys_area` VALUES (94, 82, '130430', '邱县', '3');
INSERT INTO `sys_area` VALUES (95, 82, '130431', '鸡泽县', '3');
INSERT INTO `sys_area` VALUES (96, 82, '130432', '广平县', '3');
INSERT INTO `sys_area` VALUES (97, 82, '130433', '馆陶县', '3');
INSERT INTO `sys_area` VALUES (98, 82, '130434', '魏县', '3');
INSERT INTO `sys_area` VALUES (99, 82, '130435', '曲周县', '3');
INSERT INTO `sys_area` VALUES (100, 82, '130481', '武安市', '3');
INSERT INTO `sys_area` VALUES (101, 35, '130500', '邢台市', '2');
INSERT INTO `sys_area` VALUES (102, 101, '130502', '桥东区', '3');
INSERT INTO `sys_area` VALUES (103, 101, '130503', '桥西区', '3');
INSERT INTO `sys_area` VALUES (104, 101, '130521', '邢台县', '3');
INSERT INTO `sys_area` VALUES (105, 101, '130522', '临城县', '3');
INSERT INTO `sys_area` VALUES (106, 101, '130523', '内丘县', '3');
INSERT INTO `sys_area` VALUES (107, 101, '130524', '柏乡县', '3');
INSERT INTO `sys_area` VALUES (108, 101, '130525', '隆尧县', '3');
INSERT INTO `sys_area` VALUES (109, 101, '130526', '任县', '3');
INSERT INTO `sys_area` VALUES (110, 101, '130527', '南和县', '3');
INSERT INTO `sys_area` VALUES (111, 101, '130528', '宁晋县', '3');
INSERT INTO `sys_area` VALUES (112, 101, '130529', '巨鹿县', '3');
INSERT INTO `sys_area` VALUES (113, 101, '130530', '新河县', '3');
INSERT INTO `sys_area` VALUES (114, 101, '130531', '广宗县', '3');
INSERT INTO `sys_area` VALUES (115, 101, '130532', '平乡县', '3');
INSERT INTO `sys_area` VALUES (116, 101, '130533', '威县', '3');
INSERT INTO `sys_area` VALUES (117, 101, '130534', '清河县', '3');
INSERT INTO `sys_area` VALUES (118, 101, '130535', '临西县', '3');
INSERT INTO `sys_area` VALUES (119, 101, '130581', '南宫市', '3');
INSERT INTO `sys_area` VALUES (120, 101, '130582', '沙河市', '3');
INSERT INTO `sys_area` VALUES (121, 35, '130600', '保定市', '2');
INSERT INTO `sys_area` VALUES (122, 121, '130602', '竞秀区', '3');
INSERT INTO `sys_area` VALUES (123, 121, '130606', '莲池区', '3');
INSERT INTO `sys_area` VALUES (124, 121, '130607', '满城区', '3');
INSERT INTO `sys_area` VALUES (125, 121, '130608', '清苑区', '3');
INSERT INTO `sys_area` VALUES (126, 121, '130609', '徐水区', '3');
INSERT INTO `sys_area` VALUES (127, 121, '130623', '涞水县', '3');
INSERT INTO `sys_area` VALUES (128, 121, '130624', '阜平县', '3');
INSERT INTO `sys_area` VALUES (129, 121, '130626', '定兴县', '3');
INSERT INTO `sys_area` VALUES (130, 121, '130627', '唐县', '3');
INSERT INTO `sys_area` VALUES (131, 121, '130628', '高阳县', '3');
INSERT INTO `sys_area` VALUES (132, 121, '130629', '容城县', '3');
INSERT INTO `sys_area` VALUES (133, 121, '130630', '涞源县', '3');
INSERT INTO `sys_area` VALUES (134, 121, '130631', '望都县', '3');
INSERT INTO `sys_area` VALUES (135, 121, '130632', '安新县', '3');
INSERT INTO `sys_area` VALUES (136, 121, '130633', '易县', '3');
INSERT INTO `sys_area` VALUES (137, 121, '130634', '曲阳县', '3');
INSERT INTO `sys_area` VALUES (138, 121, '130635', '蠡县', '3');
INSERT INTO `sys_area` VALUES (139, 121, '130636', '顺平县', '3');
INSERT INTO `sys_area` VALUES (140, 121, '130637', '博野县', '3');
INSERT INTO `sys_area` VALUES (141, 121, '130638', '雄县', '3');
INSERT INTO `sys_area` VALUES (142, 121, '130681', '涿州市', '3');
INSERT INTO `sys_area` VALUES (143, 121, '130682', '定州市', '3');
INSERT INTO `sys_area` VALUES (144, 121, '130683', '安国市', '3');
INSERT INTO `sys_area` VALUES (145, 121, '130684', '高碑店市', '3');
INSERT INTO `sys_area` VALUES (146, 35, '130700', '张家口市', '2');
INSERT INTO `sys_area` VALUES (147, 146, '130702', '桥东区', '3');
INSERT INTO `sys_area` VALUES (148, 146, '130703', '桥西区', '3');
INSERT INTO `sys_area` VALUES (149, 146, '130705', '宣化区', '3');
INSERT INTO `sys_area` VALUES (150, 146, '130706', '下花园区', '3');
INSERT INTO `sys_area` VALUES (151, 146, '130708', '万全区', '3');
INSERT INTO `sys_area` VALUES (152, 146, '130709', '崇礼区', '3');
INSERT INTO `sys_area` VALUES (153, 146, '130722', '张北县', '3');
INSERT INTO `sys_area` VALUES (154, 146, '130723', '康保县', '3');
INSERT INTO `sys_area` VALUES (155, 146, '130724', '沽源县', '3');
INSERT INTO `sys_area` VALUES (156, 146, '130725', '尚义县', '3');
INSERT INTO `sys_area` VALUES (157, 146, '130726', '蔚县', '3');
INSERT INTO `sys_area` VALUES (158, 146, '130727', '阳原县', '3');
INSERT INTO `sys_area` VALUES (159, 146, '130728', '怀安县', '3');
INSERT INTO `sys_area` VALUES (160, 146, '130730', '怀来县', '3');
INSERT INTO `sys_area` VALUES (161, 146, '130731', '涿鹿县', '3');
INSERT INTO `sys_area` VALUES (162, 146, '130732', '赤城县', '3');
INSERT INTO `sys_area` VALUES (163, 35, '130800', '承德市', '2');
INSERT INTO `sys_area` VALUES (164, 163, '130802', '双桥区', '3');
INSERT INTO `sys_area` VALUES (165, 163, '130803', '双滦区', '3');
INSERT INTO `sys_area` VALUES (166, 163, '130804', '鹰手营子矿区', '3');
INSERT INTO `sys_area` VALUES (167, 163, '130821', '承德县', '3');
INSERT INTO `sys_area` VALUES (168, 163, '130822', '兴隆县', '3');
INSERT INTO `sys_area` VALUES (169, 163, '130824', '滦平县', '3');
INSERT INTO `sys_area` VALUES (170, 163, '130825', '隆化县', '3');
INSERT INTO `sys_area` VALUES (171, 163, '130826', '丰宁满族自治县', '3');
INSERT INTO `sys_area` VALUES (172, 163, '130827', '宽城满族自治县', '3');
INSERT INTO `sys_area` VALUES (173, 163, '130828', '围场满族蒙古族自治县', '3');
INSERT INTO `sys_area` VALUES (174, 163, '130881', '平泉市', '3');
INSERT INTO `sys_area` VALUES (175, 35, '130900', '沧州市', '2');
INSERT INTO `sys_area` VALUES (176, 175, '130902', '新华区', '3');
INSERT INTO `sys_area` VALUES (177, 175, '130903', '运河区', '3');
INSERT INTO `sys_area` VALUES (178, 175, '130921', '沧县', '3');
INSERT INTO `sys_area` VALUES (179, 175, '130922', '青县', '3');
INSERT INTO `sys_area` VALUES (180, 175, '130923', '东光县', '3');
INSERT INTO `sys_area` VALUES (181, 175, '130924', '海兴县', '3');
INSERT INTO `sys_area` VALUES (182, 175, '130925', '盐山县', '3');
INSERT INTO `sys_area` VALUES (183, 175, '130926', '肃宁县', '3');
INSERT INTO `sys_area` VALUES (184, 175, '130927', '南皮县', '3');
INSERT INTO `sys_area` VALUES (185, 175, '130928', '吴桥县', '3');
INSERT INTO `sys_area` VALUES (186, 175, '130929', '献县', '3');
INSERT INTO `sys_area` VALUES (187, 175, '130930', '孟村回族自治县', '3');
INSERT INTO `sys_area` VALUES (188, 175, '130981', '泊头市', '3');
INSERT INTO `sys_area` VALUES (189, 175, '130982', '任丘市', '3');
INSERT INTO `sys_area` VALUES (190, 175, '130983', '黄骅市', '3');
INSERT INTO `sys_area` VALUES (191, 175, '130984', '河间市', '3');
INSERT INTO `sys_area` VALUES (192, 35, '131000', '廊坊市', '2');
INSERT INTO `sys_area` VALUES (193, 192, '131002', '安次区', '3');
INSERT INTO `sys_area` VALUES (194, 192, '131003', '广阳区', '3');
INSERT INTO `sys_area` VALUES (195, 192, '131022', '固安县', '3');
INSERT INTO `sys_area` VALUES (196, 192, '131023', '永清县', '3');
INSERT INTO `sys_area` VALUES (197, 192, '131024', '香河县', '3');
INSERT INTO `sys_area` VALUES (198, 192, '131025', '大城县', '3');
INSERT INTO `sys_area` VALUES (199, 192, '131026', '文安县', '3');
INSERT INTO `sys_area` VALUES (200, 192, '131028', '大厂回族自治县', '3');
INSERT INTO `sys_area` VALUES (201, 192, '131081', '霸州市', '3');
INSERT INTO `sys_area` VALUES (202, 192, '131082', '三河市', '3');
INSERT INTO `sys_area` VALUES (203, 35, '131100', '衡水市', '2');
INSERT INTO `sys_area` VALUES (204, 203, '131102', '桃城区', '3');
INSERT INTO `sys_area` VALUES (205, 203, '131103', '冀州区', '3');
INSERT INTO `sys_area` VALUES (206, 203, '131121', '枣强县', '3');
INSERT INTO `sys_area` VALUES (207, 203, '131122', '武邑县', '3');
INSERT INTO `sys_area` VALUES (208, 203, '131123', '武强县', '3');
INSERT INTO `sys_area` VALUES (209, 203, '131124', '饶阳县', '3');
INSERT INTO `sys_area` VALUES (210, 203, '131125', '安平县', '3');
INSERT INTO `sys_area` VALUES (211, 203, '131126', '故城县', '3');
INSERT INTO `sys_area` VALUES (212, 203, '131127', '景县', '3');
INSERT INTO `sys_area` VALUES (213, 203, '131128', '阜城县', '3');
INSERT INTO `sys_area` VALUES (214, 203, '131182', '深州市', '3');
INSERT INTO `sys_area` VALUES (215, -1, '140000', '山西省', '1');
INSERT INTO `sys_area` VALUES (216, 215, '140100', '太原市', '2');
INSERT INTO `sys_area` VALUES (217, 216, '140105', '小店区', '3');
INSERT INTO `sys_area` VALUES (218, 216, '140106', '迎泽区', '3');
INSERT INTO `sys_area` VALUES (219, 216, '140107', '杏花岭区', '3');
INSERT INTO `sys_area` VALUES (220, 216, '140108', '尖草坪区', '3');
INSERT INTO `sys_area` VALUES (221, 216, '140109', '万柏林区', '3');
INSERT INTO `sys_area` VALUES (222, 216, '140110', '晋源区', '3');
INSERT INTO `sys_area` VALUES (223, 216, '140121', '清徐县', '3');
INSERT INTO `sys_area` VALUES (224, 216, '140122', '阳曲县', '3');
INSERT INTO `sys_area` VALUES (225, 216, '140123', '娄烦县', '3');
INSERT INTO `sys_area` VALUES (226, 216, '140181', '古交市', '3');
INSERT INTO `sys_area` VALUES (227, 215, '140200', '大同市', '2');
INSERT INTO `sys_area` VALUES (228, 227, '140212', '新荣区', '3');
INSERT INTO `sys_area` VALUES (229, 227, '140213', '平城区', '3');
INSERT INTO `sys_area` VALUES (230, 227, '140214', '云冈区', '3');
INSERT INTO `sys_area` VALUES (231, 227, '140215', '云州区', '3');
INSERT INTO `sys_area` VALUES (232, 227, '140221', '阳高县', '3');
INSERT INTO `sys_area` VALUES (233, 227, '140222', '天镇县', '3');
INSERT INTO `sys_area` VALUES (234, 227, '140223', '广灵县', '3');
INSERT INTO `sys_area` VALUES (235, 227, '140224', '灵丘县', '3');
INSERT INTO `sys_area` VALUES (236, 227, '140225', '浑源县', '3');
INSERT INTO `sys_area` VALUES (237, 227, '140226', '左云县', '3');
INSERT INTO `sys_area` VALUES (238, 215, '140300', '阳泉市', '2');
INSERT INTO `sys_area` VALUES (239, 238, '140302', '城区', '3');
INSERT INTO `sys_area` VALUES (240, 238, '140303', '矿区', '3');
INSERT INTO `sys_area` VALUES (241, 238, '140311', '郊区', '3');
INSERT INTO `sys_area` VALUES (242, 238, '140321', '平定县', '3');
INSERT INTO `sys_area` VALUES (243, 238, '140322', '盂县', '3');
INSERT INTO `sys_area` VALUES (244, 215, '140400', '长治市', '2');
INSERT INTO `sys_area` VALUES (245, 244, '140403', '潞州区', '3');
INSERT INTO `sys_area` VALUES (246, 244, '140404', '上党区', '3');
INSERT INTO `sys_area` VALUES (247, 244, '140405', '屯留区', '3');
INSERT INTO `sys_area` VALUES (248, 244, '140406', '潞城区', '3');
INSERT INTO `sys_area` VALUES (249, 244, '140423', '襄垣县', '3');
INSERT INTO `sys_area` VALUES (250, 244, '140425', '平顺县', '3');
INSERT INTO `sys_area` VALUES (251, 244, '140426', '黎城县', '3');
INSERT INTO `sys_area` VALUES (252, 244, '140427', '壶关县', '3');
INSERT INTO `sys_area` VALUES (253, 244, '140428', '长子县', '3');
INSERT INTO `sys_area` VALUES (254, 244, '140429', '武乡县', '3');
INSERT INTO `sys_area` VALUES (255, 244, '140430', '沁县', '3');
INSERT INTO `sys_area` VALUES (256, 244, '140431', '沁源县', '3');
INSERT INTO `sys_area` VALUES (257, 215, '140500', '晋城市', '2');
INSERT INTO `sys_area` VALUES (258, 257, '140502', '城区', '3');
INSERT INTO `sys_area` VALUES (259, 257, '140521', '沁水县', '3');
INSERT INTO `sys_area` VALUES (260, 257, '140522', '阳城县', '3');
INSERT INTO `sys_area` VALUES (261, 257, '140524', '陵川县', '3');
INSERT INTO `sys_area` VALUES (262, 257, '140525', '泽州县', '3');
INSERT INTO `sys_area` VALUES (263, 257, '140581', '高平市', '3');
INSERT INTO `sys_area` VALUES (264, 215, '140600', '朔州市', '2');
INSERT INTO `sys_area` VALUES (265, 264, '140602', '朔城区', '3');
INSERT INTO `sys_area` VALUES (266, 264, '140603', '平鲁区', '3');
INSERT INTO `sys_area` VALUES (267, 264, '140621', '山阴县', '3');
INSERT INTO `sys_area` VALUES (268, 264, '140622', '应县', '3');
INSERT INTO `sys_area` VALUES (269, 264, '140623', '右玉县', '3');
INSERT INTO `sys_area` VALUES (270, 264, '140681', '怀仁市', '3');
INSERT INTO `sys_area` VALUES (271, 215, '140700', '晋中市', '2');
INSERT INTO `sys_area` VALUES (272, 271, '140702', '榆次区', '3');
INSERT INTO `sys_area` VALUES (273, 271, '140721', '榆社县', '3');
INSERT INTO `sys_area` VALUES (274, 271, '140722', '左权县', '3');
INSERT INTO `sys_area` VALUES (275, 271, '140723', '和顺县', '3');
INSERT INTO `sys_area` VALUES (276, 271, '140724', '昔阳县', '3');
INSERT INTO `sys_area` VALUES (277, 271, '140725', '寿阳县', '3');
INSERT INTO `sys_area` VALUES (278, 271, '140726', '太谷县', '3');
INSERT INTO `sys_area` VALUES (279, 271, '140727', '祁县', '3');
INSERT INTO `sys_area` VALUES (280, 271, '140728', '平遥县', '3');
INSERT INTO `sys_area` VALUES (281, 271, '140729', '灵石县', '3');
INSERT INTO `sys_area` VALUES (282, 271, '140781', '介休市', '3');
INSERT INTO `sys_area` VALUES (283, 215, '140800', '运城市', '2');
INSERT INTO `sys_area` VALUES (284, 283, '140802', '盐湖区', '3');
INSERT INTO `sys_area` VALUES (285, 283, '140821', '临猗县', '3');
INSERT INTO `sys_area` VALUES (286, 283, '140822', '万荣县', '3');
INSERT INTO `sys_area` VALUES (287, 283, '140823', '闻喜县', '3');
INSERT INTO `sys_area` VALUES (288, 283, '140824', '稷山县', '3');
INSERT INTO `sys_area` VALUES (289, 283, '140825', '新绛县', '3');
INSERT INTO `sys_area` VALUES (290, 283, '140826', '绛县', '3');
INSERT INTO `sys_area` VALUES (291, 283, '140827', '垣曲县', '3');
INSERT INTO `sys_area` VALUES (292, 283, '140828', '夏县', '3');
INSERT INTO `sys_area` VALUES (293, 283, '140829', '平陆县', '3');
INSERT INTO `sys_area` VALUES (294, 283, '140830', '芮城县', '3');
INSERT INTO `sys_area` VALUES (295, 283, '140881', '永济市', '3');
INSERT INTO `sys_area` VALUES (296, 283, '140882', '河津市', '3');
INSERT INTO `sys_area` VALUES (297, 215, '140900', '忻州市', '2');
INSERT INTO `sys_area` VALUES (298, 297, '140902', '忻府区', '3');
INSERT INTO `sys_area` VALUES (299, 297, '140921', '定襄县', '3');
INSERT INTO `sys_area` VALUES (300, 297, '140922', '五台县', '3');
INSERT INTO `sys_area` VALUES (301, 297, '140923', '代县', '3');
INSERT INTO `sys_area` VALUES (302, 297, '140924', '繁峙县', '3');
INSERT INTO `sys_area` VALUES (303, 297, '140925', '宁武县', '3');
INSERT INTO `sys_area` VALUES (304, 297, '140926', '静乐县', '3');
INSERT INTO `sys_area` VALUES (305, 297, '140927', '神池县', '3');
INSERT INTO `sys_area` VALUES (306, 297, '140928', '五寨县', '3');
INSERT INTO `sys_area` VALUES (307, 297, '140929', '岢岚县', '3');
INSERT INTO `sys_area` VALUES (308, 297, '140930', '河曲县', '3');
INSERT INTO `sys_area` VALUES (309, 297, '140931', '保德县', '3');
INSERT INTO `sys_area` VALUES (310, 297, '140932', '偏关县', '3');
INSERT INTO `sys_area` VALUES (311, 297, '140981', '原平市', '3');
INSERT INTO `sys_area` VALUES (312, 215, '141000', '临汾市', '2');
INSERT INTO `sys_area` VALUES (313, 312, '141002', '尧都区', '3');
INSERT INTO `sys_area` VALUES (314, 312, '141021', '曲沃县', '3');
INSERT INTO `sys_area` VALUES (315, 312, '141022', '翼城县', '3');
INSERT INTO `sys_area` VALUES (316, 312, '141023', '襄汾县', '3');
INSERT INTO `sys_area` VALUES (317, 312, '141024', '洪洞县', '3');
INSERT INTO `sys_area` VALUES (318, 312, '141025', '古县', '3');
INSERT INTO `sys_area` VALUES (319, 312, '141026', '安泽县', '3');
INSERT INTO `sys_area` VALUES (320, 312, '141027', '浮山县', '3');
INSERT INTO `sys_area` VALUES (321, 312, '141028', '吉县', '3');
INSERT INTO `sys_area` VALUES (322, 312, '141029', '乡宁县', '3');
INSERT INTO `sys_area` VALUES (323, 312, '141030', '大宁县', '3');
INSERT INTO `sys_area` VALUES (324, 312, '141031', '隰县', '3');
INSERT INTO `sys_area` VALUES (325, 312, '141032', '永和县', '3');
INSERT INTO `sys_area` VALUES (326, 312, '141033', '蒲县', '3');
INSERT INTO `sys_area` VALUES (327, 312, '141034', '汾西县', '3');
INSERT INTO `sys_area` VALUES (328, 312, '141081', '侯马市', '3');
INSERT INTO `sys_area` VALUES (329, 312, '141082', '霍州市', '3');
INSERT INTO `sys_area` VALUES (330, 215, '141100', '吕梁市', '2');
INSERT INTO `sys_area` VALUES (331, 330, '141102', '离石区', '3');
INSERT INTO `sys_area` VALUES (332, 330, '141121', '文水县', '3');
INSERT INTO `sys_area` VALUES (333, 330, '141122', '交城县', '3');
INSERT INTO `sys_area` VALUES (334, 330, '141123', '兴县', '3');
INSERT INTO `sys_area` VALUES (335, 330, '141124', '临县', '3');
INSERT INTO `sys_area` VALUES (336, 330, '141125', '柳林县', '3');
INSERT INTO `sys_area` VALUES (337, 330, '141126', '石楼县', '3');
INSERT INTO `sys_area` VALUES (338, 330, '141127', '岚县', '3');
INSERT INTO `sys_area` VALUES (339, 330, '141128', '方山县', '3');
INSERT INTO `sys_area` VALUES (340, 330, '141129', '中阳县', '3');
INSERT INTO `sys_area` VALUES (341, 330, '141130', '交口县', '3');
INSERT INTO `sys_area` VALUES (342, 330, '141181', '孝义市', '3');
INSERT INTO `sys_area` VALUES (343, 330, '141182', '汾阳市', '3');
INSERT INTO `sys_area` VALUES (344, -1, '150000', '内蒙古自治区', '1');
INSERT INTO `sys_area` VALUES (345, 344, '150100', '呼和浩特市', '2');
INSERT INTO `sys_area` VALUES (346, 345, '150102', '新城区', '3');
INSERT INTO `sys_area` VALUES (347, 345, '150103', '回民区', '3');
INSERT INTO `sys_area` VALUES (348, 345, '150104', '玉泉区', '3');
INSERT INTO `sys_area` VALUES (349, 345, '150105', '赛罕区', '3');
INSERT INTO `sys_area` VALUES (350, 345, '150121', '土默特左旗', '3');
INSERT INTO `sys_area` VALUES (351, 345, '150122', '托克托县', '3');
INSERT INTO `sys_area` VALUES (352, 345, '150123', '和林格尔县', '3');
INSERT INTO `sys_area` VALUES (353, 345, '150124', '清水河县', '3');
INSERT INTO `sys_area` VALUES (354, 345, '150125', '武川县', '3');
INSERT INTO `sys_area` VALUES (355, 344, '150200', '包头市', '2');
INSERT INTO `sys_area` VALUES (356, 355, '150202', '东河区', '3');
INSERT INTO `sys_area` VALUES (357, 355, '150203', '昆都仑区', '3');
INSERT INTO `sys_area` VALUES (358, 355, '150204', '青山区', '3');
INSERT INTO `sys_area` VALUES (359, 355, '150205', '石拐区', '3');
INSERT INTO `sys_area` VALUES (360, 355, '150206', '白云鄂博矿区', '3');
INSERT INTO `sys_area` VALUES (361, 355, '150207', '九原区', '3');
INSERT INTO `sys_area` VALUES (362, 355, '150221', '土默特右旗', '3');
INSERT INTO `sys_area` VALUES (363, 355, '150222', '固阳县', '3');
INSERT INTO `sys_area` VALUES (364, 355, '150223', '达尔罕茂明安联合旗', '3');
INSERT INTO `sys_area` VALUES (365, 344, '150300', '乌海市', '2');
INSERT INTO `sys_area` VALUES (366, 365, '150302', '海勃湾区', '3');
INSERT INTO `sys_area` VALUES (367, 365, '150303', '海南区', '3');
INSERT INTO `sys_area` VALUES (368, 365, '150304', '乌达区', '3');
INSERT INTO `sys_area` VALUES (369, 344, '150400', '赤峰市', '2');
INSERT INTO `sys_area` VALUES (370, 369, '150402', '红山区', '3');
INSERT INTO `sys_area` VALUES (371, 369, '150403', '元宝山区', '3');
INSERT INTO `sys_area` VALUES (372, 369, '150404', '松山区', '3');
INSERT INTO `sys_area` VALUES (373, 369, '150421', '阿鲁科尔沁旗', '3');
INSERT INTO `sys_area` VALUES (374, 369, '150422', '巴林左旗', '3');
INSERT INTO `sys_area` VALUES (375, 369, '150423', '巴林右旗', '3');
INSERT INTO `sys_area` VALUES (376, 369, '150424', '林西县', '3');
INSERT INTO `sys_area` VALUES (377, 369, '150425', '克什克腾旗', '3');
INSERT INTO `sys_area` VALUES (378, 369, '150426', '翁牛特旗', '3');
INSERT INTO `sys_area` VALUES (379, 369, '150428', '喀喇沁旗', '3');
INSERT INTO `sys_area` VALUES (380, 369, '150429', '宁城县', '3');
INSERT INTO `sys_area` VALUES (381, 369, '150430', '敖汉旗', '3');
INSERT INTO `sys_area` VALUES (382, 344, '150500', '通辽市', '2');
INSERT INTO `sys_area` VALUES (383, 382, '150502', '科尔沁区', '3');
INSERT INTO `sys_area` VALUES (384, 382, '150521', '科尔沁左翼中旗', '3');
INSERT INTO `sys_area` VALUES (385, 382, '150522', '科尔沁左翼后旗', '3');
INSERT INTO `sys_area` VALUES (386, 382, '150523', '开鲁县', '3');
INSERT INTO `sys_area` VALUES (387, 382, '150524', '库伦旗', '3');
INSERT INTO `sys_area` VALUES (388, 382, '150525', '奈曼旗', '3');
INSERT INTO `sys_area` VALUES (389, 382, '150526', '扎鲁特旗', '3');
INSERT INTO `sys_area` VALUES (390, 382, '150581', '霍林郭勒市', '3');
INSERT INTO `sys_area` VALUES (391, 344, '150600', '鄂尔多斯市', '2');
INSERT INTO `sys_area` VALUES (392, 391, '150602', '东胜区', '3');
INSERT INTO `sys_area` VALUES (393, 391, '150603', '康巴什区', '3');
INSERT INTO `sys_area` VALUES (394, 391, '150621', '达拉特旗', '3');
INSERT INTO `sys_area` VALUES (395, 391, '150622', '准格尔旗', '3');
INSERT INTO `sys_area` VALUES (396, 391, '150623', '鄂托克前旗', '3');
INSERT INTO `sys_area` VALUES (397, 391, '150624', '鄂托克旗', '3');
INSERT INTO `sys_area` VALUES (398, 391, '150625', '杭锦旗', '3');
INSERT INTO `sys_area` VALUES (399, 391, '150626', '乌审旗', '3');
INSERT INTO `sys_area` VALUES (400, 391, '150627', '伊金霍洛旗', '3');
INSERT INTO `sys_area` VALUES (401, 344, '150700', '呼伦贝尔市', '2');
INSERT INTO `sys_area` VALUES (402, 401, '150702', '海拉尔区', '3');
INSERT INTO `sys_area` VALUES (403, 401, '150703', '扎赉诺尔区', '3');
INSERT INTO `sys_area` VALUES (404, 401, '150721', '阿荣旗', '3');
INSERT INTO `sys_area` VALUES (405, 401, '150722', '莫力达瓦达斡尔族自治旗', '3');
INSERT INTO `sys_area` VALUES (406, 401, '150723', '鄂伦春自治旗', '3');
INSERT INTO `sys_area` VALUES (407, 401, '150724', '鄂温克族自治旗', '3');
INSERT INTO `sys_area` VALUES (408, 401, '150725', '陈巴尔虎旗', '3');
INSERT INTO `sys_area` VALUES (409, 401, '150726', '新巴尔虎左旗', '3');
INSERT INTO `sys_area` VALUES (410, 401, '150727', '新巴尔虎右旗', '3');
INSERT INTO `sys_area` VALUES (411, 401, '150781', '满洲里市', '3');
INSERT INTO `sys_area` VALUES (412, 401, '150782', '牙克石市', '3');
INSERT INTO `sys_area` VALUES (413, 401, '150783', '扎兰屯市', '3');
INSERT INTO `sys_area` VALUES (414, 401, '150784', '额尔古纳市', '3');
INSERT INTO `sys_area` VALUES (415, 401, '150785', '根河市', '3');
INSERT INTO `sys_area` VALUES (416, 344, '150800', '巴彦淖尔市', '2');
INSERT INTO `sys_area` VALUES (417, 416, '150802', '临河区', '3');
INSERT INTO `sys_area` VALUES (418, 416, '150821', '五原县', '3');
INSERT INTO `sys_area` VALUES (419, 416, '150822', '磴口县', '3');
INSERT INTO `sys_area` VALUES (420, 416, '150823', '乌拉特前旗', '3');
INSERT INTO `sys_area` VALUES (421, 416, '150824', '乌拉特中旗', '3');
INSERT INTO `sys_area` VALUES (422, 416, '150825', '乌拉特后旗', '3');
INSERT INTO `sys_area` VALUES (423, 416, '150826', '杭锦后旗', '3');
INSERT INTO `sys_area` VALUES (424, 344, '150900', '乌兰察布市', '2');
INSERT INTO `sys_area` VALUES (425, 424, '150902', '集宁区', '3');
INSERT INTO `sys_area` VALUES (426, 424, '150921', '卓资县', '3');
INSERT INTO `sys_area` VALUES (427, 424, '150922', '化德县', '3');
INSERT INTO `sys_area` VALUES (428, 424, '150923', '商都县', '3');
INSERT INTO `sys_area` VALUES (429, 424, '150924', '兴和县', '3');
INSERT INTO `sys_area` VALUES (430, 424, '150925', '凉城县', '3');
INSERT INTO `sys_area` VALUES (431, 424, '150926', '察哈尔右翼前旗', '3');
INSERT INTO `sys_area` VALUES (432, 424, '150927', '察哈尔右翼中旗', '3');
INSERT INTO `sys_area` VALUES (433, 424, '150928', '察哈尔右翼后旗', '3');
INSERT INTO `sys_area` VALUES (434, 424, '150929', '四子王旗', '3');
INSERT INTO `sys_area` VALUES (435, 424, '150981', '丰镇市', '3');
INSERT INTO `sys_area` VALUES (436, 344, '152200', '兴安盟', '2');
INSERT INTO `sys_area` VALUES (437, 436, '152201', '乌兰浩特市', '3');
INSERT INTO `sys_area` VALUES (438, 436, '152202', '阿尔山市', '3');
INSERT INTO `sys_area` VALUES (439, 436, '152221', '科尔沁右翼前旗', '3');
INSERT INTO `sys_area` VALUES (440, 436, '152222', '科尔沁右翼中旗', '3');
INSERT INTO `sys_area` VALUES (441, 436, '152223', '扎赉特旗', '3');
INSERT INTO `sys_area` VALUES (442, 436, '152224', '突泉县', '3');
INSERT INTO `sys_area` VALUES (443, 344, '152500', '锡林郭勒盟', '2');
INSERT INTO `sys_area` VALUES (444, 443, '152501', '二连浩特市', '3');
INSERT INTO `sys_area` VALUES (445, 443, '152502', '锡林浩特市', '3');
INSERT INTO `sys_area` VALUES (446, 443, '152522', '阿巴嘎旗', '3');
INSERT INTO `sys_area` VALUES (447, 443, '152523', '苏尼特左旗', '3');
INSERT INTO `sys_area` VALUES (448, 443, '152524', '苏尼特右旗', '3');
INSERT INTO `sys_area` VALUES (449, 443, '152525', '东乌珠穆沁旗', '3');
INSERT INTO `sys_area` VALUES (450, 443, '152526', '西乌珠穆沁旗', '3');
INSERT INTO `sys_area` VALUES (451, 443, '152527', '太仆寺旗', '3');
INSERT INTO `sys_area` VALUES (452, 443, '152528', '镶黄旗', '3');
INSERT INTO `sys_area` VALUES (453, 443, '152529', '正镶白旗', '3');
INSERT INTO `sys_area` VALUES (454, 443, '152530', '正蓝旗', '3');
INSERT INTO `sys_area` VALUES (455, 443, '152531', '多伦县', '3');
INSERT INTO `sys_area` VALUES (456, 344, '152900', '阿拉善盟', '2');
INSERT INTO `sys_area` VALUES (457, 456, '152921', '阿拉善左旗', '3');
INSERT INTO `sys_area` VALUES (458, 456, '152922', '阿拉善右旗', '3');
INSERT INTO `sys_area` VALUES (459, 456, '152923', '额济纳旗', '3');
INSERT INTO `sys_area` VALUES (460, -1, '210000', '辽宁省', '1');
INSERT INTO `sys_area` VALUES (461, 460, '210100', '沈阳市', '2');
INSERT INTO `sys_area` VALUES (462, 461, '210102', '和平区', '3');
INSERT INTO `sys_area` VALUES (463, 461, '210103', '沈河区', '3');
INSERT INTO `sys_area` VALUES (464, 461, '210104', '大东区', '3');
INSERT INTO `sys_area` VALUES (465, 461, '210105', '皇姑区', '3');
INSERT INTO `sys_area` VALUES (466, 461, '210106', '铁西区', '3');
INSERT INTO `sys_area` VALUES (467, 461, '210111', '苏家屯区', '3');
INSERT INTO `sys_area` VALUES (468, 461, '210112', '浑南区', '3');
INSERT INTO `sys_area` VALUES (469, 461, '210113', '沈北新区', '3');
INSERT INTO `sys_area` VALUES (470, 461, '210114', '于洪区', '3');
INSERT INTO `sys_area` VALUES (471, 461, '210115', '辽中区', '3');
INSERT INTO `sys_area` VALUES (472, 461, '210123', '康平县', '3');
INSERT INTO `sys_area` VALUES (473, 461, '210124', '法库县', '3');
INSERT INTO `sys_area` VALUES (474, 461, '210181', '新民市', '3');
INSERT INTO `sys_area` VALUES (475, 460, '210200', '大连市', '2');
INSERT INTO `sys_area` VALUES (476, 475, '210202', '中山区', '3');
INSERT INTO `sys_area` VALUES (477, 475, '210203', '西岗区', '3');
INSERT INTO `sys_area` VALUES (478, 475, '210204', '沙河口区', '3');
INSERT INTO `sys_area` VALUES (479, 475, '210211', '甘井子区', '3');
INSERT INTO `sys_area` VALUES (480, 475, '210212', '旅顺口区', '3');
INSERT INTO `sys_area` VALUES (481, 475, '210213', '金州区', '3');
INSERT INTO `sys_area` VALUES (482, 475, '210214', '普兰店区', '3');
INSERT INTO `sys_area` VALUES (483, 475, '210224', '长海县', '3');
INSERT INTO `sys_area` VALUES (484, 475, '210281', '瓦房店市', '3');
INSERT INTO `sys_area` VALUES (485, 475, '210283', '庄河市', '3');
INSERT INTO `sys_area` VALUES (486, 460, '210300', '鞍山市', '2');
INSERT INTO `sys_area` VALUES (487, 486, '210302', '铁东区', '3');
INSERT INTO `sys_area` VALUES (488, 486, '210303', '铁西区', '3');
INSERT INTO `sys_area` VALUES (489, 486, '210304', '立山区', '3');
INSERT INTO `sys_area` VALUES (490, 486, '210311', '千山区', '3');
INSERT INTO `sys_area` VALUES (491, 486, '210321', '台安县', '3');
INSERT INTO `sys_area` VALUES (492, 486, '210323', '岫岩满族自治县', '3');
INSERT INTO `sys_area` VALUES (493, 486, '210381', '海城市', '3');
INSERT INTO `sys_area` VALUES (494, 460, '210400', '抚顺市', '2');
INSERT INTO `sys_area` VALUES (495, 494, '210402', '新抚区', '3');
INSERT INTO `sys_area` VALUES (496, 494, '210403', '东洲区', '3');
INSERT INTO `sys_area` VALUES (497, 494, '210404', '望花区', '3');
INSERT INTO `sys_area` VALUES (498, 494, '210411', '顺城区', '3');
INSERT INTO `sys_area` VALUES (499, 494, '210421', '抚顺县', '3');
INSERT INTO `sys_area` VALUES (500, 494, '210422', '新宾满族自治县', '3');
INSERT INTO `sys_area` VALUES (501, 494, '210423', '清原满族自治县', '3');
INSERT INTO `sys_area` VALUES (502, 460, '210500', '本溪市', '2');
INSERT INTO `sys_area` VALUES (503, 502, '210502', '平山区', '3');
INSERT INTO `sys_area` VALUES (504, 502, '210503', '溪湖区', '3');
INSERT INTO `sys_area` VALUES (505, 502, '210504', '明山区', '3');
INSERT INTO `sys_area` VALUES (506, 502, '210505', '南芬区', '3');
INSERT INTO `sys_area` VALUES (507, 502, '210521', '本溪满族自治县', '3');
INSERT INTO `sys_area` VALUES (508, 502, '210522', '桓仁满族自治县', '3');
INSERT INTO `sys_area` VALUES (509, 460, '210600', '丹东市', '2');
INSERT INTO `sys_area` VALUES (510, 509, '210602', '元宝区', '3');
INSERT INTO `sys_area` VALUES (511, 509, '210603', '振兴区', '3');
INSERT INTO `sys_area` VALUES (512, 509, '210604', '振安区', '3');
INSERT INTO `sys_area` VALUES (513, 509, '210624', '宽甸满族自治县', '3');
INSERT INTO `sys_area` VALUES (514, 509, '210681', '东港市', '3');
INSERT INTO `sys_area` VALUES (515, 509, '210682', '凤城市', '3');
INSERT INTO `sys_area` VALUES (516, 460, '210700', '锦州市', '2');
INSERT INTO `sys_area` VALUES (517, 516, '210702', '古塔区', '3');
INSERT INTO `sys_area` VALUES (518, 516, '210703', '凌河区', '3');
INSERT INTO `sys_area` VALUES (519, 516, '210711', '太和区', '3');
INSERT INTO `sys_area` VALUES (520, 516, '210726', '黑山县', '3');
INSERT INTO `sys_area` VALUES (521, 516, '210727', '义县', '3');
INSERT INTO `sys_area` VALUES (522, 516, '210781', '凌海市', '3');
INSERT INTO `sys_area` VALUES (523, 516, '210782', '北镇市', '3');
INSERT INTO `sys_area` VALUES (524, 460, '210800', '营口市', '2');
INSERT INTO `sys_area` VALUES (525, 524, '210802', '站前区', '3');
INSERT INTO `sys_area` VALUES (526, 524, '210803', '西市区', '3');
INSERT INTO `sys_area` VALUES (527, 524, '210804', '鲅鱼圈区', '3');
INSERT INTO `sys_area` VALUES (528, 524, '210811', '老边区', '3');
INSERT INTO `sys_area` VALUES (529, 524, '210881', '盖州市', '3');
INSERT INTO `sys_area` VALUES (530, 524, '210882', '大石桥市', '3');
INSERT INTO `sys_area` VALUES (531, 460, '210900', '阜新市', '2');
INSERT INTO `sys_area` VALUES (532, 531, '210902', '海州区', '3');
INSERT INTO `sys_area` VALUES (533, 531, '210903', '新邱区', '3');
INSERT INTO `sys_area` VALUES (534, 531, '210904', '太平区', '3');
INSERT INTO `sys_area` VALUES (535, 531, '210905', '清河门区', '3');
INSERT INTO `sys_area` VALUES (536, 531, '210911', '细河区', '3');
INSERT INTO `sys_area` VALUES (537, 531, '210921', '阜新蒙古族自治县', '3');
INSERT INTO `sys_area` VALUES (538, 531, '210922', '彰武县', '3');
INSERT INTO `sys_area` VALUES (539, 460, '211000', '辽阳市', '2');
INSERT INTO `sys_area` VALUES (540, 539, '211002', '白塔区', '3');
INSERT INTO `sys_area` VALUES (541, 539, '211003', '文圣区', '3');
INSERT INTO `sys_area` VALUES (542, 539, '211004', '宏伟区', '3');
INSERT INTO `sys_area` VALUES (543, 539, '211005', '弓长岭区', '3');
INSERT INTO `sys_area` VALUES (544, 539, '211011', '太子河区', '3');
INSERT INTO `sys_area` VALUES (545, 539, '211021', '辽阳县', '3');
INSERT INTO `sys_area` VALUES (546, 539, '211081', '灯塔市', '3');
INSERT INTO `sys_area` VALUES (547, 460, '211100', '盘锦市', '2');
INSERT INTO `sys_area` VALUES (548, 547, '211102', '双台子区', '3');
INSERT INTO `sys_area` VALUES (549, 547, '211103', '兴隆台区', '3');
INSERT INTO `sys_area` VALUES (550, 547, '211104', '大洼区', '3');
INSERT INTO `sys_area` VALUES (551, 547, '211122', '盘山县', '3');
INSERT INTO `sys_area` VALUES (552, 460, '211200', '铁岭市', '2');
INSERT INTO `sys_area` VALUES (553, 552, '211202', '银州区', '3');
INSERT INTO `sys_area` VALUES (554, 552, '211204', '清河区', '3');
INSERT INTO `sys_area` VALUES (555, 552, '211221', '铁岭县', '3');
INSERT INTO `sys_area` VALUES (556, 552, '211223', '西丰县', '3');
INSERT INTO `sys_area` VALUES (557, 552, '211224', '昌图县', '3');
INSERT INTO `sys_area` VALUES (558, 552, '211281', '调兵山市', '3');
INSERT INTO `sys_area` VALUES (559, 552, '211282', '开原市', '3');
INSERT INTO `sys_area` VALUES (560, 460, '211300', '朝阳市', '2');
INSERT INTO `sys_area` VALUES (561, 560, '211302', '双塔区', '3');
INSERT INTO `sys_area` VALUES (562, 560, '211303', '龙城区', '3');
INSERT INTO `sys_area` VALUES (563, 560, '211321', '朝阳县', '3');
INSERT INTO `sys_area` VALUES (564, 560, '211322', '建平县', '3');
INSERT INTO `sys_area` VALUES (565, 560, '211324', '喀喇沁左翼蒙古族自治县', '3');
INSERT INTO `sys_area` VALUES (566, 560, '211381', '北票市', '3');
INSERT INTO `sys_area` VALUES (567, 560, '211382', '凌源市', '3');
INSERT INTO `sys_area` VALUES (568, 460, '211400', '葫芦岛市', '2');
INSERT INTO `sys_area` VALUES (569, 568, '211402', '连山区', '3');
INSERT INTO `sys_area` VALUES (570, 568, '211403', '龙港区', '3');
INSERT INTO `sys_area` VALUES (571, 568, '211404', '南票区', '3');
INSERT INTO `sys_area` VALUES (572, 568, '211421', '绥中县', '3');
INSERT INTO `sys_area` VALUES (573, 568, '211422', '建昌县', '3');
INSERT INTO `sys_area` VALUES (574, 568, '211481', '兴城市', '3');
INSERT INTO `sys_area` VALUES (575, -1, '220000', '吉林省', '1');
INSERT INTO `sys_area` VALUES (576, 575, '220100', '长春市', '2');
INSERT INTO `sys_area` VALUES (577, 576, '220102', '南关区', '3');
INSERT INTO `sys_area` VALUES (578, 576, '220103', '宽城区', '3');
INSERT INTO `sys_area` VALUES (579, 576, '220104', '朝阳区', '3');
INSERT INTO `sys_area` VALUES (580, 576, '220105', '二道区', '3');
INSERT INTO `sys_area` VALUES (581, 576, '220106', '绿园区', '3');
INSERT INTO `sys_area` VALUES (582, 576, '220112', '双阳区', '3');
INSERT INTO `sys_area` VALUES (583, 576, '220113', '九台区', '3');
INSERT INTO `sys_area` VALUES (584, 576, '220122', '农安县', '3');
INSERT INTO `sys_area` VALUES (585, 576, '220182', '榆树市', '3');
INSERT INTO `sys_area` VALUES (586, 576, '220183', '德惠市', '3');
INSERT INTO `sys_area` VALUES (587, 575, '220200', '吉林市', '2');
INSERT INTO `sys_area` VALUES (588, 587, '220202', '昌邑区', '3');
INSERT INTO `sys_area` VALUES (589, 587, '220203', '龙潭区', '3');
INSERT INTO `sys_area` VALUES (590, 587, '220204', '船营区', '3');
INSERT INTO `sys_area` VALUES (591, 587, '220211', '丰满区', '3');
INSERT INTO `sys_area` VALUES (592, 587, '220221', '永吉县', '3');
INSERT INTO `sys_area` VALUES (593, 587, '220281', '蛟河市', '3');
INSERT INTO `sys_area` VALUES (594, 587, '220282', '桦甸市', '3');
INSERT INTO `sys_area` VALUES (595, 587, '220283', '舒兰市', '3');
INSERT INTO `sys_area` VALUES (596, 587, '220284', '磐石市', '3');
INSERT INTO `sys_area` VALUES (597, 575, '220300', '四平市', '2');
INSERT INTO `sys_area` VALUES (598, 597, '220302', '铁西区', '3');
INSERT INTO `sys_area` VALUES (599, 597, '220303', '铁东区', '3');
INSERT INTO `sys_area` VALUES (600, 597, '220322', '梨树县', '3');
INSERT INTO `sys_area` VALUES (601, 597, '220323', '伊通满族自治县', '3');
INSERT INTO `sys_area` VALUES (602, 597, '220381', '公主岭市', '3');
INSERT INTO `sys_area` VALUES (603, 597, '220382', '双辽市', '3');
INSERT INTO `sys_area` VALUES (604, 575, '220400', '辽源市', '2');
INSERT INTO `sys_area` VALUES (605, 604, '220402', '龙山区', '3');
INSERT INTO `sys_area` VALUES (606, 604, '220403', '西安区', '3');
INSERT INTO `sys_area` VALUES (607, 604, '220421', '东丰县', '3');
INSERT INTO `sys_area` VALUES (608, 604, '220422', '东辽县', '3');
INSERT INTO `sys_area` VALUES (609, 575, '220500', '通化市', '2');
INSERT INTO `sys_area` VALUES (610, 609, '220502', '东昌区', '3');
INSERT INTO `sys_area` VALUES (611, 609, '220503', '二道江区', '3');
INSERT INTO `sys_area` VALUES (612, 609, '220521', '通化县', '3');
INSERT INTO `sys_area` VALUES (613, 609, '220523', '辉南县', '3');
INSERT INTO `sys_area` VALUES (614, 609, '220524', '柳河县', '3');
INSERT INTO `sys_area` VALUES (615, 609, '220581', '梅河口市', '3');
INSERT INTO `sys_area` VALUES (616, 609, '220582', '集安市', '3');
INSERT INTO `sys_area` VALUES (617, 575, '220600', '白山市', '2');
INSERT INTO `sys_area` VALUES (618, 617, '220602', '浑江区', '3');
INSERT INTO `sys_area` VALUES (619, 617, '220605', '江源区', '3');
INSERT INTO `sys_area` VALUES (620, 617, '220621', '抚松县', '3');
INSERT INTO `sys_area` VALUES (621, 617, '220622', '靖宇县', '3');
INSERT INTO `sys_area` VALUES (622, 617, '220623', '长白朝鲜族自治县', '3');
INSERT INTO `sys_area` VALUES (623, 617, '220681', '临江市', '3');
INSERT INTO `sys_area` VALUES (624, 575, '220700', '松原市', '2');
INSERT INTO `sys_area` VALUES (625, 624, '220702', '宁江区', '3');
INSERT INTO `sys_area` VALUES (626, 624, '220721', '前郭尔罗斯蒙古族自治县', '3');
INSERT INTO `sys_area` VALUES (627, 624, '220722', '长岭县', '3');
INSERT INTO `sys_area` VALUES (628, 624, '220723', '乾安县', '3');
INSERT INTO `sys_area` VALUES (629, 624, '220781', '扶余市', '3');
INSERT INTO `sys_area` VALUES (630, 575, '220800', '白城市', '2');
INSERT INTO `sys_area` VALUES (631, 630, '220802', '洮北区', '3');
INSERT INTO `sys_area` VALUES (632, 630, '220821', '镇赉县', '3');
INSERT INTO `sys_area` VALUES (633, 630, '220822', '通榆县', '3');
INSERT INTO `sys_area` VALUES (634, 630, '220881', '洮南市', '3');
INSERT INTO `sys_area` VALUES (635, 630, '220882', '大安市', '3');
INSERT INTO `sys_area` VALUES (636, 575, '222400', '延边朝鲜族自治州', '2');
INSERT INTO `sys_area` VALUES (637, 636, '222401', '延吉市', '3');
INSERT INTO `sys_area` VALUES (638, 636, '222402', '图们市', '3');
INSERT INTO `sys_area` VALUES (639, 636, '222403', '敦化市', '3');
INSERT INTO `sys_area` VALUES (640, 636, '222404', '珲春市', '3');
INSERT INTO `sys_area` VALUES (641, 636, '222405', '龙井市', '3');
INSERT INTO `sys_area` VALUES (642, 636, '222406', '和龙市', '3');
INSERT INTO `sys_area` VALUES (643, 636, '222424', '汪清县', '3');
INSERT INTO `sys_area` VALUES (644, 636, '222426', '安图县', '3');
INSERT INTO `sys_area` VALUES (645, -1, '230000', '黑龙江省', '1');
INSERT INTO `sys_area` VALUES (646, 645, '230100', '哈尔滨市', '2');
INSERT INTO `sys_area` VALUES (647, 646, '230102', '道里区', '3');
INSERT INTO `sys_area` VALUES (648, 646, '230103', '南岗区', '3');
INSERT INTO `sys_area` VALUES (649, 646, '230104', '道外区', '3');
INSERT INTO `sys_area` VALUES (650, 646, '230108', '平房区', '3');
INSERT INTO `sys_area` VALUES (651, 646, '230109', '松北区', '3');
INSERT INTO `sys_area` VALUES (652, 646, '230110', '香坊区', '3');
INSERT INTO `sys_area` VALUES (653, 646, '230111', '呼兰区', '3');
INSERT INTO `sys_area` VALUES (654, 646, '230112', '阿城区', '3');
INSERT INTO `sys_area` VALUES (655, 646, '230113', '双城区', '3');
INSERT INTO `sys_area` VALUES (656, 646, '230123', '依兰县', '3');
INSERT INTO `sys_area` VALUES (657, 646, '230124', '方正县', '3');
INSERT INTO `sys_area` VALUES (658, 646, '230125', '宾县', '3');
INSERT INTO `sys_area` VALUES (659, 646, '230126', '巴彦县', '3');
INSERT INTO `sys_area` VALUES (660, 646, '230127', '木兰县', '3');
INSERT INTO `sys_area` VALUES (661, 646, '230128', '通河县', '3');
INSERT INTO `sys_area` VALUES (662, 646, '230129', '延寿县', '3');
INSERT INTO `sys_area` VALUES (663, 646, '230183', '尚志市', '3');
INSERT INTO `sys_area` VALUES (664, 646, '230184', '五常市', '3');
INSERT INTO `sys_area` VALUES (665, 645, '230200', '齐齐哈尔市', '2');
INSERT INTO `sys_area` VALUES (666, 665, '230202', '龙沙区', '3');
INSERT INTO `sys_area` VALUES (667, 665, '230203', '建华区', '3');
INSERT INTO `sys_area` VALUES (668, 665, '230204', '铁锋区', '3');
INSERT INTO `sys_area` VALUES (669, 665, '230205', '昂昂溪区', '3');
INSERT INTO `sys_area` VALUES (670, 665, '230206', '富拉尔基区', '3');
INSERT INTO `sys_area` VALUES (671, 665, '230207', '碾子山区', '3');
INSERT INTO `sys_area` VALUES (672, 665, '230208', '梅里斯达斡尔族区', '3');
INSERT INTO `sys_area` VALUES (673, 665, '230221', '龙江县', '3');
INSERT INTO `sys_area` VALUES (674, 665, '230223', '依安县', '3');
INSERT INTO `sys_area` VALUES (675, 665, '230224', '泰来县', '3');
INSERT INTO `sys_area` VALUES (676, 665, '230225', '甘南县', '3');
INSERT INTO `sys_area` VALUES (677, 665, '230227', '富裕县', '3');
INSERT INTO `sys_area` VALUES (678, 665, '230229', '克山县', '3');
INSERT INTO `sys_area` VALUES (679, 665, '230230', '克东县', '3');
INSERT INTO `sys_area` VALUES (680, 665, '230231', '拜泉县', '3');
INSERT INTO `sys_area` VALUES (681, 665, '230281', '讷河市', '3');
INSERT INTO `sys_area` VALUES (682, 645, '230300', '鸡西市', '2');
INSERT INTO `sys_area` VALUES (683, 682, '230302', '鸡冠区', '3');
INSERT INTO `sys_area` VALUES (684, 682, '230303', '恒山区', '3');
INSERT INTO `sys_area` VALUES (685, 682, '230304', '滴道区', '3');
INSERT INTO `sys_area` VALUES (686, 682, '230305', '梨树区', '3');
INSERT INTO `sys_area` VALUES (687, 682, '230306', '城子河区', '3');
INSERT INTO `sys_area` VALUES (688, 682, '230307', '麻山区', '3');
INSERT INTO `sys_area` VALUES (689, 682, '230321', '鸡东县', '3');
INSERT INTO `sys_area` VALUES (690, 682, '230381', '虎林市', '3');
INSERT INTO `sys_area` VALUES (691, 682, '230382', '密山市', '3');
INSERT INTO `sys_area` VALUES (692, 645, '230400', '鹤岗市', '2');
INSERT INTO `sys_area` VALUES (693, 692, '230402', '向阳区', '3');
INSERT INTO `sys_area` VALUES (694, 692, '230403', '工农区', '3');
INSERT INTO `sys_area` VALUES (695, 692, '230404', '南山区', '3');
INSERT INTO `sys_area` VALUES (696, 692, '230405', '兴安区', '3');
INSERT INTO `sys_area` VALUES (697, 692, '230406', '东山区', '3');
INSERT INTO `sys_area` VALUES (698, 692, '230407', '兴山区', '3');
INSERT INTO `sys_area` VALUES (699, 692, '230421', '萝北县', '3');
INSERT INTO `sys_area` VALUES (700, 692, '230422', '绥滨县', '3');
INSERT INTO `sys_area` VALUES (701, 645, '230500', '双鸭山市', '2');
INSERT INTO `sys_area` VALUES (702, 701, '230502', '尖山区', '3');
INSERT INTO `sys_area` VALUES (703, 701, '230503', '岭东区', '3');
INSERT INTO `sys_area` VALUES (704, 701, '230505', '四方台区', '3');
INSERT INTO `sys_area` VALUES (705, 701, '230506', '宝山区', '3');
INSERT INTO `sys_area` VALUES (706, 701, '230521', '集贤县', '3');
INSERT INTO `sys_area` VALUES (707, 701, '230522', '友谊县', '3');
INSERT INTO `sys_area` VALUES (708, 701, '230523', '宝清县', '3');
INSERT INTO `sys_area` VALUES (709, 701, '230524', '饶河县', '3');
INSERT INTO `sys_area` VALUES (710, 645, '230600', '大庆市', '2');
INSERT INTO `sys_area` VALUES (711, 710, '230602', '萨尔图区', '3');
INSERT INTO `sys_area` VALUES (712, 710, '230603', '龙凤区', '3');
INSERT INTO `sys_area` VALUES (713, 710, '230604', '让胡路区', '3');
INSERT INTO `sys_area` VALUES (714, 710, '230605', '红岗区', '3');
INSERT INTO `sys_area` VALUES (715, 710, '230606', '大同区', '3');
INSERT INTO `sys_area` VALUES (716, 710, '230621', '肇州县', '3');
INSERT INTO `sys_area` VALUES (717, 710, '230622', '肇源县', '3');
INSERT INTO `sys_area` VALUES (718, 710, '230623', '林甸县', '3');
INSERT INTO `sys_area` VALUES (719, 710, '230624', '杜尔伯特蒙古族自治县', '3');
INSERT INTO `sys_area` VALUES (720, 645, '230700', '伊春市', '2');
INSERT INTO `sys_area` VALUES (721, 720, '230702', '伊春区', '3');
INSERT INTO `sys_area` VALUES (722, 720, '230703', '南岔区', '3');
INSERT INTO `sys_area` VALUES (723, 720, '230704', '友好区', '3');
INSERT INTO `sys_area` VALUES (724, 720, '230705', '西林区', '3');
INSERT INTO `sys_area` VALUES (725, 720, '230706', '翠峦区', '3');
INSERT INTO `sys_area` VALUES (726, 720, '230707', '新青区', '3');
INSERT INTO `sys_area` VALUES (727, 720, '230708', '美溪区', '3');
INSERT INTO `sys_area` VALUES (728, 720, '230709', '金山屯区', '3');
INSERT INTO `sys_area` VALUES (729, 720, '230710', '五营区', '3');
INSERT INTO `sys_area` VALUES (730, 720, '230711', '乌马河区', '3');
INSERT INTO `sys_area` VALUES (731, 720, '230712', '汤旺河区', '3');
INSERT INTO `sys_area` VALUES (732, 720, '230713', '带岭区', '3');
INSERT INTO `sys_area` VALUES (733, 720, '230714', '乌伊岭区', '3');
INSERT INTO `sys_area` VALUES (734, 720, '230715', '红星区', '3');
INSERT INTO `sys_area` VALUES (735, 720, '230716', '上甘岭区', '3');
INSERT INTO `sys_area` VALUES (736, 720, '230722', '嘉荫县', '3');
INSERT INTO `sys_area` VALUES (737, 720, '230781', '铁力市', '3');
INSERT INTO `sys_area` VALUES (738, 645, '230800', '佳木斯市', '2');
INSERT INTO `sys_area` VALUES (739, 738, '230803', '向阳区', '3');
INSERT INTO `sys_area` VALUES (740, 738, '230804', '前进区', '3');
INSERT INTO `sys_area` VALUES (741, 738, '230805', '东风区', '3');
INSERT INTO `sys_area` VALUES (742, 738, '230811', '郊区', '3');
INSERT INTO `sys_area` VALUES (743, 738, '230822', '桦南县', '3');
INSERT INTO `sys_area` VALUES (744, 738, '230826', '桦川县', '3');
INSERT INTO `sys_area` VALUES (745, 738, '230828', '汤原县', '3');
INSERT INTO `sys_area` VALUES (746, 738, '230881', '同江市', '3');
INSERT INTO `sys_area` VALUES (747, 738, '230882', '富锦市', '3');
INSERT INTO `sys_area` VALUES (748, 738, '230883', '抚远市', '3');
INSERT INTO `sys_area` VALUES (749, 645, '230900', '七台河市', '2');
INSERT INTO `sys_area` VALUES (750, 749, '230902', '新兴区', '3');
INSERT INTO `sys_area` VALUES (751, 749, '230903', '桃山区', '3');
INSERT INTO `sys_area` VALUES (752, 749, '230904', '茄子河区', '3');
INSERT INTO `sys_area` VALUES (753, 749, '230921', '勃利县', '3');
INSERT INTO `sys_area` VALUES (754, 645, '231000', '牡丹江市', '2');
INSERT INTO `sys_area` VALUES (755, 754, '231002', '东安区', '3');
INSERT INTO `sys_area` VALUES (756, 754, '231003', '阳明区', '3');
INSERT INTO `sys_area` VALUES (757, 754, '231004', '爱民区', '3');
INSERT INTO `sys_area` VALUES (758, 754, '231005', '西安区', '3');
INSERT INTO `sys_area` VALUES (759, 754, '231025', '林口县', '3');
INSERT INTO `sys_area` VALUES (760, 754, '231081', '绥芬河市', '3');
INSERT INTO `sys_area` VALUES (761, 754, '231083', '海林市', '3');
INSERT INTO `sys_area` VALUES (762, 754, '231084', '宁安市', '3');
INSERT INTO `sys_area` VALUES (763, 754, '231085', '穆棱市', '3');
INSERT INTO `sys_area` VALUES (764, 754, '231086', '东宁市', '3');
INSERT INTO `sys_area` VALUES (765, 645, '231100', '黑河市', '2');
INSERT INTO `sys_area` VALUES (766, 765, '231102', '爱辉区', '3');
INSERT INTO `sys_area` VALUES (767, 765, '231121', '嫩江县', '3');
INSERT INTO `sys_area` VALUES (768, 765, '231123', '逊克县', '3');
INSERT INTO `sys_area` VALUES (769, 765, '231124', '孙吴县', '3');
INSERT INTO `sys_area` VALUES (770, 765, '231181', '北安市', '3');
INSERT INTO `sys_area` VALUES (771, 765, '231182', '五大连池市', '3');
INSERT INTO `sys_area` VALUES (772, 645, '231200', '绥化市', '2');
INSERT INTO `sys_area` VALUES (773, 772, '231202', '北林区', '3');
INSERT INTO `sys_area` VALUES (774, 772, '231221', '望奎县', '3');
INSERT INTO `sys_area` VALUES (775, 772, '231222', '兰西县', '3');
INSERT INTO `sys_area` VALUES (776, 772, '231223', '青冈县', '3');
INSERT INTO `sys_area` VALUES (777, 772, '231224', '庆安县', '3');
INSERT INTO `sys_area` VALUES (778, 772, '231225', '明水县', '3');
INSERT INTO `sys_area` VALUES (779, 772, '231226', '绥棱县', '3');
INSERT INTO `sys_area` VALUES (780, 772, '231281', '安达市', '3');
INSERT INTO `sys_area` VALUES (781, 772, '231282', '肇东市', '3');
INSERT INTO `sys_area` VALUES (782, 772, '231283', '海伦市', '3');
INSERT INTO `sys_area` VALUES (783, 645, '232700', '大兴安岭地区', '2');
INSERT INTO `sys_area` VALUES (784, 783, '232701', '漠河市', '3');
INSERT INTO `sys_area` VALUES (785, 783, '232721', '呼玛县', '3');
INSERT INTO `sys_area` VALUES (786, 783, '232722', '塔河县', '3');
INSERT INTO `sys_area` VALUES (787, -1, '310000', '上海市', '1');
INSERT INTO `sys_area` VALUES (788, 787, '310101', '黄浦区', '3');
INSERT INTO `sys_area` VALUES (789, 787, '310104', '徐汇区', '3');
INSERT INTO `sys_area` VALUES (790, 787, '310105', '长宁区', '3');
INSERT INTO `sys_area` VALUES (791, 787, '310106', '静安区', '3');
INSERT INTO `sys_area` VALUES (792, 787, '310107', '普陀区', '3');
INSERT INTO `sys_area` VALUES (793, 787, '310109', '虹口区', '3');
INSERT INTO `sys_area` VALUES (794, 787, '310110', '杨浦区', '3');
INSERT INTO `sys_area` VALUES (795, 787, '310112', '闵行区', '3');
INSERT INTO `sys_area` VALUES (796, 787, '310113', '宝山区', '3');
INSERT INTO `sys_area` VALUES (797, 787, '310114', '嘉定区', '3');
INSERT INTO `sys_area` VALUES (798, 787, '310115', '浦东新区', '3');
INSERT INTO `sys_area` VALUES (799, 787, '310116', '金山区', '3');
INSERT INTO `sys_area` VALUES (800, 787, '310117', '松江区', '3');
INSERT INTO `sys_area` VALUES (801, 787, '310118', '青浦区', '3');
INSERT INTO `sys_area` VALUES (802, 787, '310120', '奉贤区', '3');
INSERT INTO `sys_area` VALUES (803, 787, '310151', '崇明区', '3');
INSERT INTO `sys_area` VALUES (804, -1, '320000', '江苏省', '1');
INSERT INTO `sys_area` VALUES (805, 804, '320100', '南京市', '2');
INSERT INTO `sys_area` VALUES (806, 805, '320102', '玄武区', '3');
INSERT INTO `sys_area` VALUES (807, 805, '320104', '秦淮区', '3');
INSERT INTO `sys_area` VALUES (808, 805, '320105', '建邺区', '3');
INSERT INTO `sys_area` VALUES (809, 805, '320106', '鼓楼区', '3');
INSERT INTO `sys_area` VALUES (810, 805, '320111', '浦口区', '3');
INSERT INTO `sys_area` VALUES (811, 805, '320113', '栖霞区', '3');
INSERT INTO `sys_area` VALUES (812, 805, '320114', '雨花台区', '3');
INSERT INTO `sys_area` VALUES (813, 805, '320115', '江宁区', '3');
INSERT INTO `sys_area` VALUES (814, 805, '320116', '六合区', '3');
INSERT INTO `sys_area` VALUES (815, 805, '320117', '溧水区', '3');
INSERT INTO `sys_area` VALUES (816, 805, '320118', '高淳区', '3');
INSERT INTO `sys_area` VALUES (817, 804, '320200', '无锡市', '2');
INSERT INTO `sys_area` VALUES (818, 817, '320205', '锡山区', '3');
INSERT INTO `sys_area` VALUES (819, 817, '320206', '惠山区', '3');
INSERT INTO `sys_area` VALUES (820, 817, '320211', '滨湖区', '3');
INSERT INTO `sys_area` VALUES (821, 817, '320213', '梁溪区', '3');
INSERT INTO `sys_area` VALUES (822, 817, '320214', '新吴区', '3');
INSERT INTO `sys_area` VALUES (823, 817, '320281', '江阴市', '3');
INSERT INTO `sys_area` VALUES (824, 817, '320282', '宜兴市', '3');
INSERT INTO `sys_area` VALUES (825, 804, '320300', '徐州市', '2');
INSERT INTO `sys_area` VALUES (826, 825, '320302', '鼓楼区', '3');
INSERT INTO `sys_area` VALUES (827, 825, '320303', '云龙区', '3');
INSERT INTO `sys_area` VALUES (828, 825, '320305', '贾汪区', '3');
INSERT INTO `sys_area` VALUES (829, 825, '320311', '泉山区', '3');
INSERT INTO `sys_area` VALUES (830, 825, '320312', '铜山区', '3');
INSERT INTO `sys_area` VALUES (831, 825, '320321', '丰县', '3');
INSERT INTO `sys_area` VALUES (832, 825, '320322', '沛县', '3');
INSERT INTO `sys_area` VALUES (833, 825, '320324', '睢宁县', '3');
INSERT INTO `sys_area` VALUES (834, 825, '320381', '新沂市', '3');
INSERT INTO `sys_area` VALUES (835, 825, '320382', '邳州市', '3');
INSERT INTO `sys_area` VALUES (836, 804, '320400', '常州市', '2');
INSERT INTO `sys_area` VALUES (837, 836, '320402', '天宁区', '3');
INSERT INTO `sys_area` VALUES (838, 836, '320404', '钟楼区', '3');
INSERT INTO `sys_area` VALUES (839, 836, '320411', '新北区', '3');
INSERT INTO `sys_area` VALUES (840, 836, '320412', '武进区', '3');
INSERT INTO `sys_area` VALUES (841, 836, '320413', '金坛区', '3');
INSERT INTO `sys_area` VALUES (842, 836, '320481', '溧阳市', '3');
INSERT INTO `sys_area` VALUES (843, 804, '320500', '苏州市', '2');
INSERT INTO `sys_area` VALUES (844, 843, '320505', '虎丘区', '3');
INSERT INTO `sys_area` VALUES (845, 843, '320506', '吴中区', '3');
INSERT INTO `sys_area` VALUES (846, 843, '320507', '相城区', '3');
INSERT INTO `sys_area` VALUES (847, 843, '320508', '姑苏区', '3');
INSERT INTO `sys_area` VALUES (848, 843, '320509', '吴江区', '3');
INSERT INTO `sys_area` VALUES (849, 843, '320581', '常熟市', '3');
INSERT INTO `sys_area` VALUES (850, 843, '320582', '张家港市', '3');
INSERT INTO `sys_area` VALUES (851, 843, '320583', '昆山市', '3');
INSERT INTO `sys_area` VALUES (852, 843, '320585', '太仓市', '3');
INSERT INTO `sys_area` VALUES (853, 804, '320600', '南通市', '2');
INSERT INTO `sys_area` VALUES (854, 853, '320602', '崇川区', '3');
INSERT INTO `sys_area` VALUES (855, 853, '320611', '港闸区', '3');
INSERT INTO `sys_area` VALUES (856, 853, '320612', '通州区', '3');
INSERT INTO `sys_area` VALUES (857, 853, '320623', '如东县', '3');
INSERT INTO `sys_area` VALUES (858, 853, '320681', '启东市', '3');
INSERT INTO `sys_area` VALUES (859, 853, '320682', '如皋市', '3');
INSERT INTO `sys_area` VALUES (860, 853, '320684', '海门市', '3');
INSERT INTO `sys_area` VALUES (861, 853, '320685', '海安市', '3');
INSERT INTO `sys_area` VALUES (862, 804, '320700', '连云港市', '2');
INSERT INTO `sys_area` VALUES (863, 862, '320703', '连云区', '3');
INSERT INTO `sys_area` VALUES (864, 862, '320706', '海州区', '3');
INSERT INTO `sys_area` VALUES (865, 862, '320707', '赣榆区', '3');
INSERT INTO `sys_area` VALUES (866, 862, '320722', '东海县', '3');
INSERT INTO `sys_area` VALUES (867, 862, '320723', '灌云县', '3');
INSERT INTO `sys_area` VALUES (868, 862, '320724', '灌南县', '3');
INSERT INTO `sys_area` VALUES (869, 804, '320800', '淮安市', '2');
INSERT INTO `sys_area` VALUES (870, 869, '320803', '淮安区', '3');
INSERT INTO `sys_area` VALUES (871, 869, '320804', '淮阴区', '3');
INSERT INTO `sys_area` VALUES (872, 869, '320812', '清江浦区', '3');
INSERT INTO `sys_area` VALUES (873, 869, '320813', '洪泽区', '3');
INSERT INTO `sys_area` VALUES (874, 869, '320826', '涟水县', '3');
INSERT INTO `sys_area` VALUES (875, 869, '320830', '盱眙县', '3');
INSERT INTO `sys_area` VALUES (876, 869, '320831', '金湖县', '3');
INSERT INTO `sys_area` VALUES (877, 804, '320900', '盐城市', '2');
INSERT INTO `sys_area` VALUES (878, 877, '320902', '亭湖区', '3');
INSERT INTO `sys_area` VALUES (879, 877, '320903', '盐都区', '3');
INSERT INTO `sys_area` VALUES (880, 877, '320904', '大丰区', '3');
INSERT INTO `sys_area` VALUES (881, 877, '320921', '响水县', '3');
INSERT INTO `sys_area` VALUES (882, 877, '320922', '滨海县', '3');
INSERT INTO `sys_area` VALUES (883, 877, '320923', '阜宁县', '3');
INSERT INTO `sys_area` VALUES (884, 877, '320924', '射阳县', '3');
INSERT INTO `sys_area` VALUES (885, 877, '320925', '建湖县', '3');
INSERT INTO `sys_area` VALUES (886, 877, '320981', '东台市', '3');
INSERT INTO `sys_area` VALUES (887, 804, '321000', '扬州市', '2');
INSERT INTO `sys_area` VALUES (888, 887, '321002', '广陵区', '3');
INSERT INTO `sys_area` VALUES (889, 887, '321003', '邗江区', '3');
INSERT INTO `sys_area` VALUES (890, 887, '321012', '江都区', '3');
INSERT INTO `sys_area` VALUES (891, 887, '321023', '宝应县', '3');
INSERT INTO `sys_area` VALUES (892, 887, '321081', '仪征市', '3');
INSERT INTO `sys_area` VALUES (893, 887, '321084', '高邮市', '3');
INSERT INTO `sys_area` VALUES (894, 804, '321100', '镇江市', '2');
INSERT INTO `sys_area` VALUES (895, 894, '321102', '京口区', '3');
INSERT INTO `sys_area` VALUES (896, 894, '321111', '润州区', '3');
INSERT INTO `sys_area` VALUES (897, 894, '321112', '丹徒区', '3');
INSERT INTO `sys_area` VALUES (898, 894, '321181', '丹阳市', '3');
INSERT INTO `sys_area` VALUES (899, 894, '321182', '扬中市', '3');
INSERT INTO `sys_area` VALUES (900, 894, '321183', '句容市', '3');
INSERT INTO `sys_area` VALUES (901, 804, '321200', '泰州市', '2');
INSERT INTO `sys_area` VALUES (902, 901, '321202', '海陵区', '3');
INSERT INTO `sys_area` VALUES (903, 901, '321203', '高港区', '3');
INSERT INTO `sys_area` VALUES (904, 901, '321204', '姜堰区', '3');
INSERT INTO `sys_area` VALUES (905, 901, '321281', '兴化市', '3');
INSERT INTO `sys_area` VALUES (906, 901, '321282', '靖江市', '3');
INSERT INTO `sys_area` VALUES (907, 901, '321283', '泰兴市', '3');
INSERT INTO `sys_area` VALUES (908, 804, '321300', '宿迁市', '2');
INSERT INTO `sys_area` VALUES (909, 908, '321302', '宿城区', '3');
INSERT INTO `sys_area` VALUES (910, 908, '321311', '宿豫区', '3');
INSERT INTO `sys_area` VALUES (911, 908, '321322', '沭阳县', '3');
INSERT INTO `sys_area` VALUES (912, 908, '321323', '泗阳县', '3');
INSERT INTO `sys_area` VALUES (913, 908, '321324', '泗洪县', '3');
INSERT INTO `sys_area` VALUES (914, -1, '330000', '浙江省', '1');
INSERT INTO `sys_area` VALUES (915, 914, '330100', '杭州市', '2');
INSERT INTO `sys_area` VALUES (916, 915, '330102', '上城区', '3');
INSERT INTO `sys_area` VALUES (917, 915, '330103', '下城区', '3');
INSERT INTO `sys_area` VALUES (918, 915, '330104', '江干区', '3');
INSERT INTO `sys_area` VALUES (919, 915, '330105', '拱墅区', '3');
INSERT INTO `sys_area` VALUES (920, 915, '330106', '西湖区', '3');
INSERT INTO `sys_area` VALUES (921, 915, '330108', '滨江区', '3');
INSERT INTO `sys_area` VALUES (922, 915, '330109', '萧山区', '3');
INSERT INTO `sys_area` VALUES (923, 915, '330110', '余杭区', '3');
INSERT INTO `sys_area` VALUES (924, 915, '330111', '富阳区', '3');
INSERT INTO `sys_area` VALUES (925, 915, '330112', '临安区', '3');
INSERT INTO `sys_area` VALUES (926, 915, '330122', '桐庐县', '3');
INSERT INTO `sys_area` VALUES (927, 915, '330127', '淳安县', '3');
INSERT INTO `sys_area` VALUES (928, 915, '330182', '建德市', '3');
INSERT INTO `sys_area` VALUES (929, 914, '330200', '宁波市', '2');
INSERT INTO `sys_area` VALUES (930, 929, '330203', '海曙区', '3');
INSERT INTO `sys_area` VALUES (931, 929, '330205', '江北区', '3');
INSERT INTO `sys_area` VALUES (932, 929, '330206', '北仑区', '3');
INSERT INTO `sys_area` VALUES (933, 929, '330211', '镇海区', '3');
INSERT INTO `sys_area` VALUES (934, 929, '330212', '鄞州区', '3');
INSERT INTO `sys_area` VALUES (935, 929, '330213', '奉化区', '3');
INSERT INTO `sys_area` VALUES (936, 929, '330225', '象山县', '3');
INSERT INTO `sys_area` VALUES (937, 929, '330226', '宁海县', '3');
INSERT INTO `sys_area` VALUES (938, 929, '330281', '余姚市', '3');
INSERT INTO `sys_area` VALUES (939, 929, '330282', '慈溪市', '3');
INSERT INTO `sys_area` VALUES (940, 914, '330300', '温州市', '2');
INSERT INTO `sys_area` VALUES (941, 940, '330302', '鹿城区', '3');
INSERT INTO `sys_area` VALUES (942, 940, '330303', '龙湾区', '3');
INSERT INTO `sys_area` VALUES (943, 940, '330304', '瓯海区', '3');
INSERT INTO `sys_area` VALUES (944, 940, '330305', '洞头区', '3');
INSERT INTO `sys_area` VALUES (945, 940, '330324', '永嘉县', '3');
INSERT INTO `sys_area` VALUES (946, 940, '330326', '平阳县', '3');
INSERT INTO `sys_area` VALUES (947, 940, '330327', '苍南县', '3');
INSERT INTO `sys_area` VALUES (948, 940, '330328', '文成县', '3');
INSERT INTO `sys_area` VALUES (949, 940, '330329', '泰顺县', '3');
INSERT INTO `sys_area` VALUES (950, 940, '330381', '瑞安市', '3');
INSERT INTO `sys_area` VALUES (951, 940, '330382', '乐清市', '3');
INSERT INTO `sys_area` VALUES (952, 914, '330400', '嘉兴市', '2');
INSERT INTO `sys_area` VALUES (953, 952, '330402', '南湖区', '3');
INSERT INTO `sys_area` VALUES (954, 952, '330411', '秀洲区', '3');
INSERT INTO `sys_area` VALUES (955, 952, '330421', '嘉善县', '3');
INSERT INTO `sys_area` VALUES (956, 952, '330424', '海盐县', '3');
INSERT INTO `sys_area` VALUES (957, 952, '330481', '海宁市', '3');
INSERT INTO `sys_area` VALUES (958, 952, '330482', '平湖市', '3');
INSERT INTO `sys_area` VALUES (959, 952, '330483', '桐乡市', '3');
INSERT INTO `sys_area` VALUES (960, 914, '330500', '湖州市', '2');
INSERT INTO `sys_area` VALUES (961, 960, '330502', '吴兴区', '3');
INSERT INTO `sys_area` VALUES (962, 960, '330503', '南浔区', '3');
INSERT INTO `sys_area` VALUES (963, 960, '330521', '德清县', '3');
INSERT INTO `sys_area` VALUES (964, 960, '330522', '长兴县', '3');
INSERT INTO `sys_area` VALUES (965, 960, '330523', '安吉县', '3');
INSERT INTO `sys_area` VALUES (966, 914, '330600', '绍兴市', '2');
INSERT INTO `sys_area` VALUES (967, 966, '330602', '越城区', '3');
INSERT INTO `sys_area` VALUES (968, 966, '330603', '柯桥区', '3');
INSERT INTO `sys_area` VALUES (969, 966, '330604', '上虞区', '3');
INSERT INTO `sys_area` VALUES (970, 966, '330624', '新昌县', '3');
INSERT INTO `sys_area` VALUES (971, 966, '330681', '诸暨市', '3');
INSERT INTO `sys_area` VALUES (972, 966, '330683', '嵊州市', '3');
INSERT INTO `sys_area` VALUES (973, 914, '330700', '金华市', '2');
INSERT INTO `sys_area` VALUES (974, 973, '330702', '婺城区', '3');
INSERT INTO `sys_area` VALUES (975, 973, '330703', '金东区', '3');
INSERT INTO `sys_area` VALUES (976, 973, '330723', '武义县', '3');
INSERT INTO `sys_area` VALUES (977, 973, '330726', '浦江县', '3');
INSERT INTO `sys_area` VALUES (978, 973, '330727', '磐安县', '3');
INSERT INTO `sys_area` VALUES (979, 973, '330781', '兰溪市', '3');
INSERT INTO `sys_area` VALUES (980, 973, '330782', '义乌市', '3');
INSERT INTO `sys_area` VALUES (981, 973, '330783', '东阳市', '3');
INSERT INTO `sys_area` VALUES (982, 973, '330784', '永康市', '3');
INSERT INTO `sys_area` VALUES (983, 914, '330800', '衢州市', '2');
INSERT INTO `sys_area` VALUES (984, 983, '330802', '柯城区', '3');
INSERT INTO `sys_area` VALUES (985, 983, '330803', '衢江区', '3');
INSERT INTO `sys_area` VALUES (986, 983, '330822', '常山县', '3');
INSERT INTO `sys_area` VALUES (987, 983, '330824', '开化县', '3');
INSERT INTO `sys_area` VALUES (988, 983, '330825', '龙游县', '3');
INSERT INTO `sys_area` VALUES (989, 983, '330881', '江山市', '3');
INSERT INTO `sys_area` VALUES (990, 914, '330900', '舟山市', '2');
INSERT INTO `sys_area` VALUES (991, 990, '330902', '定海区', '3');
INSERT INTO `sys_area` VALUES (992, 990, '330903', '普陀区', '3');
INSERT INTO `sys_area` VALUES (993, 990, '330921', '岱山县', '3');
INSERT INTO `sys_area` VALUES (994, 990, '330922', '嵊泗县', '3');
INSERT INTO `sys_area` VALUES (995, 914, '331000', '台州市', '2');
INSERT INTO `sys_area` VALUES (996, 995, '331002', '椒江区', '3');
INSERT INTO `sys_area` VALUES (997, 995, '331003', '黄岩区', '3');
INSERT INTO `sys_area` VALUES (998, 995, '331004', '路桥区', '3');
INSERT INTO `sys_area` VALUES (999, 995, '331022', '三门县', '3');
INSERT INTO `sys_area` VALUES (1000, 995, '331023', '天台县', '3');
INSERT INTO `sys_area` VALUES (1001, 995, '331024', '仙居县', '3');
INSERT INTO `sys_area` VALUES (1002, 995, '331081', '温岭市', '3');
INSERT INTO `sys_area` VALUES (1003, 995, '331082', '临海市', '3');
INSERT INTO `sys_area` VALUES (1004, 995, '331083', '玉环市', '3');
INSERT INTO `sys_area` VALUES (1005, 914, '331100', '丽水市', '2');
INSERT INTO `sys_area` VALUES (1006, 1005, '331102', '莲都区', '3');
INSERT INTO `sys_area` VALUES (1007, 1005, '331121', '青田县', '3');
INSERT INTO `sys_area` VALUES (1008, 1005, '331122', '缙云县', '3');
INSERT INTO `sys_area` VALUES (1009, 1005, '331123', '遂昌县', '3');
INSERT INTO `sys_area` VALUES (1010, 1005, '331124', '松阳县', '3');
INSERT INTO `sys_area` VALUES (1011, 1005, '331125', '云和县', '3');
INSERT INTO `sys_area` VALUES (1012, 1005, '331126', '庆元县', '3');
INSERT INTO `sys_area` VALUES (1013, 1005, '331127', '景宁畲族自治县', '3');
INSERT INTO `sys_area` VALUES (1014, 1005, '331181', '龙泉市', '3');
INSERT INTO `sys_area` VALUES (1015, -1, '340000', '安徽省', '1');
INSERT INTO `sys_area` VALUES (1016, 1015, '340100', '合肥市', '2');
INSERT INTO `sys_area` VALUES (1017, 1016, '340102', '瑶海区', '3');
INSERT INTO `sys_area` VALUES (1018, 1016, '340103', '庐阳区', '3');
INSERT INTO `sys_area` VALUES (1019, 1016, '340104', '蜀山区', '3');
INSERT INTO `sys_area` VALUES (1020, 1016, '340111', '包河区', '3');
INSERT INTO `sys_area` VALUES (1021, 1016, '340121', '长丰县', '3');
INSERT INTO `sys_area` VALUES (1022, 1016, '340122', '肥东县', '3');
INSERT INTO `sys_area` VALUES (1023, 1016, '340123', '肥西县', '3');
INSERT INTO `sys_area` VALUES (1024, 1016, '340124', '庐江县', '3');
INSERT INTO `sys_area` VALUES (1025, 1016, '340181', '巢湖市', '3');
INSERT INTO `sys_area` VALUES (1026, 1015, '340200', '芜湖市', '2');
INSERT INTO `sys_area` VALUES (1027, 1026, '340202', '镜湖区', '3');
INSERT INTO `sys_area` VALUES (1028, 1026, '340203', '弋江区', '3');
INSERT INTO `sys_area` VALUES (1029, 1026, '340207', '鸠江区', '3');
INSERT INTO `sys_area` VALUES (1030, 1026, '340208', '三山区', '3');
INSERT INTO `sys_area` VALUES (1031, 1026, '340221', '芜湖县', '3');
INSERT INTO `sys_area` VALUES (1032, 1026, '340222', '繁昌县', '3');
INSERT INTO `sys_area` VALUES (1033, 1026, '340223', '南陵县', '3');
INSERT INTO `sys_area` VALUES (1034, 1026, '340225', '无为县', '3');
INSERT INTO `sys_area` VALUES (1035, 1015, '340300', '蚌埠市', '2');
INSERT INTO `sys_area` VALUES (1036, 1035, '340302', '龙子湖区', '3');
INSERT INTO `sys_area` VALUES (1037, 1035, '340303', '蚌山区', '3');
INSERT INTO `sys_area` VALUES (1038, 1035, '340304', '禹会区', '3');
INSERT INTO `sys_area` VALUES (1039, 1035, '340311', '淮上区', '3');
INSERT INTO `sys_area` VALUES (1040, 1035, '340321', '怀远县', '3');
INSERT INTO `sys_area` VALUES (1041, 1035, '340322', '五河县', '3');
INSERT INTO `sys_area` VALUES (1042, 1035, '340323', '固镇县', '3');
INSERT INTO `sys_area` VALUES (1043, 1015, '340400', '淮南市', '2');
INSERT INTO `sys_area` VALUES (1044, 1043, '340402', '大通区', '3');
INSERT INTO `sys_area` VALUES (1045, 1043, '340403', '田家庵区', '3');
INSERT INTO `sys_area` VALUES (1046, 1043, '340404', '谢家集区', '3');
INSERT INTO `sys_area` VALUES (1047, 1043, '340405', '八公山区', '3');
INSERT INTO `sys_area` VALUES (1048, 1043, '340406', '潘集区', '3');
INSERT INTO `sys_area` VALUES (1049, 1043, '340421', '凤台县', '3');
INSERT INTO `sys_area` VALUES (1050, 1043, '340422', '寿县', '3');
INSERT INTO `sys_area` VALUES (1051, 1015, '340500', '马鞍山市', '2');
INSERT INTO `sys_area` VALUES (1052, 1051, '340503', '花山区', '3');
INSERT INTO `sys_area` VALUES (1053, 1051, '340504', '雨山区', '3');
INSERT INTO `sys_area` VALUES (1054, 1051, '340506', '博望区', '3');
INSERT INTO `sys_area` VALUES (1055, 1051, '340521', '当涂县', '3');
INSERT INTO `sys_area` VALUES (1056, 1051, '340522', '含山县', '3');
INSERT INTO `sys_area` VALUES (1057, 1051, '340523', '和县', '3');
INSERT INTO `sys_area` VALUES (1058, 1015, '340600', '淮北市', '2');
INSERT INTO `sys_area` VALUES (1059, 1058, '340602', '杜集区', '3');
INSERT INTO `sys_area` VALUES (1060, 1058, '340603', '相山区', '3');
INSERT INTO `sys_area` VALUES (1061, 1058, '340604', '烈山区', '3');
INSERT INTO `sys_area` VALUES (1062, 1058, '340621', '濉溪县', '3');
INSERT INTO `sys_area` VALUES (1063, 1015, '340700', '铜陵市', '2');
INSERT INTO `sys_area` VALUES (1064, 1063, '340705', '铜官区', '3');
INSERT INTO `sys_area` VALUES (1065, 1063, '340706', '义安区', '3');
INSERT INTO `sys_area` VALUES (1066, 1063, '340711', '郊区', '3');
INSERT INTO `sys_area` VALUES (1067, 1063, '340722', '枞阳县', '3');
INSERT INTO `sys_area` VALUES (1068, 1015, '340800', '安庆市', '2');
INSERT INTO `sys_area` VALUES (1069, 1068, '340802', '迎江区', '3');
INSERT INTO `sys_area` VALUES (1070, 1068, '340803', '大观区', '3');
INSERT INTO `sys_area` VALUES (1071, 1068, '340811', '宜秀区', '3');
INSERT INTO `sys_area` VALUES (1072, 1068, '340822', '怀宁县', '3');
INSERT INTO `sys_area` VALUES (1073, 1068, '340825', '太湖县', '3');
INSERT INTO `sys_area` VALUES (1074, 1068, '340826', '宿松县', '3');
INSERT INTO `sys_area` VALUES (1075, 1068, '340827', '望江县', '3');
INSERT INTO `sys_area` VALUES (1076, 1068, '340828', '岳西县', '3');
INSERT INTO `sys_area` VALUES (1077, 1068, '340881', '桐城市', '3');
INSERT INTO `sys_area` VALUES (1078, 1068, '340882', '潜山市', '3');
INSERT INTO `sys_area` VALUES (1079, 1015, '341000', '黄山市', '2');
INSERT INTO `sys_area` VALUES (1080, 1079, '341002', '屯溪区', '3');
INSERT INTO `sys_area` VALUES (1081, 1079, '341003', '黄山区', '3');
INSERT INTO `sys_area` VALUES (1082, 1079, '341004', '徽州区', '3');
INSERT INTO `sys_area` VALUES (1083, 1079, '341021', '歙县', '3');
INSERT INTO `sys_area` VALUES (1084, 1079, '341022', '休宁县', '3');
INSERT INTO `sys_area` VALUES (1085, 1079, '341023', '黟县', '3');
INSERT INTO `sys_area` VALUES (1086, 1079, '341024', '祁门县', '3');
INSERT INTO `sys_area` VALUES (1087, 1015, '341100', '滁州市', '2');
INSERT INTO `sys_area` VALUES (1088, 1087, '341102', '琅琊区', '3');
INSERT INTO `sys_area` VALUES (1089, 1087, '341103', '南谯区', '3');
INSERT INTO `sys_area` VALUES (1090, 1087, '341122', '来安县', '3');
INSERT INTO `sys_area` VALUES (1091, 1087, '341124', '全椒县', '3');
INSERT INTO `sys_area` VALUES (1092, 1087, '341125', '定远县', '3');
INSERT INTO `sys_area` VALUES (1093, 1087, '341126', '凤阳县', '3');
INSERT INTO `sys_area` VALUES (1094, 1087, '341181', '天长市', '3');
INSERT INTO `sys_area` VALUES (1095, 1087, '341182', '明光市', '3');
INSERT INTO `sys_area` VALUES (1096, 1015, '341200', '阜阳市', '2');
INSERT INTO `sys_area` VALUES (1097, 1096, '341202', '颍州区', '3');
INSERT INTO `sys_area` VALUES (1098, 1096, '341203', '颍东区', '3');
INSERT INTO `sys_area` VALUES (1099, 1096, '341204', '颍泉区', '3');
INSERT INTO `sys_area` VALUES (1100, 1096, '341221', '临泉县', '3');
INSERT INTO `sys_area` VALUES (1101, 1096, '341222', '太和县', '3');
INSERT INTO `sys_area` VALUES (1102, 1096, '341225', '阜南县', '3');
INSERT INTO `sys_area` VALUES (1103, 1096, '341226', '颍上县', '3');
INSERT INTO `sys_area` VALUES (1104, 1096, '341282', '界首市', '3');
INSERT INTO `sys_area` VALUES (1105, 1015, '341300', '宿州市', '2');
INSERT INTO `sys_area` VALUES (1106, 1105, '341302', '埇桥区', '3');
INSERT INTO `sys_area` VALUES (1107, 1105, '341321', '砀山县', '3');
INSERT INTO `sys_area` VALUES (1108, 1105, '341322', '萧县', '3');
INSERT INTO `sys_area` VALUES (1109, 1105, '341323', '灵璧县', '3');
INSERT INTO `sys_area` VALUES (1110, 1105, '341324', '泗县', '3');
INSERT INTO `sys_area` VALUES (1111, 1015, '341500', '六安市', '2');
INSERT INTO `sys_area` VALUES (1112, 1111, '341502', '金安区', '3');
INSERT INTO `sys_area` VALUES (1113, 1111, '341503', '裕安区', '3');
INSERT INTO `sys_area` VALUES (1114, 1111, '341504', '叶集区', '3');
INSERT INTO `sys_area` VALUES (1115, 1111, '341522', '霍邱县', '3');
INSERT INTO `sys_area` VALUES (1116, 1111, '341523', '舒城县', '3');
INSERT INTO `sys_area` VALUES (1117, 1111, '341524', '金寨县', '3');
INSERT INTO `sys_area` VALUES (1118, 1111, '341525', '霍山县', '3');
INSERT INTO `sys_area` VALUES (1119, 1015, '341600', '亳州市', '2');
INSERT INTO `sys_area` VALUES (1120, 1119, '341602', '谯城区', '3');
INSERT INTO `sys_area` VALUES (1121, 1119, '341621', '涡阳县', '3');
INSERT INTO `sys_area` VALUES (1122, 1119, '341622', '蒙城县', '3');
INSERT INTO `sys_area` VALUES (1123, 1119, '341623', '利辛县', '3');
INSERT INTO `sys_area` VALUES (1124, 1015, '341700', '池州市', '2');
INSERT INTO `sys_area` VALUES (1125, 1124, '341702', '贵池区', '3');
INSERT INTO `sys_area` VALUES (1126, 1124, '341721', '东至县', '3');
INSERT INTO `sys_area` VALUES (1127, 1124, '341722', '石台县', '3');
INSERT INTO `sys_area` VALUES (1128, 1124, '341723', '青阳县', '3');
INSERT INTO `sys_area` VALUES (1129, 1015, '341800', '宣城市', '2');
INSERT INTO `sys_area` VALUES (1130, 1129, '341802', '宣州区', '3');
INSERT INTO `sys_area` VALUES (1131, 1129, '341821', '郎溪县', '3');
INSERT INTO `sys_area` VALUES (1132, 1129, '341822', '广德县', '3');
INSERT INTO `sys_area` VALUES (1133, 1129, '341823', '泾县', '3');
INSERT INTO `sys_area` VALUES (1134, 1129, '341824', '绩溪县', '3');
INSERT INTO `sys_area` VALUES (1135, 1129, '341825', '旌德县', '3');
INSERT INTO `sys_area` VALUES (1136, 1129, '341881', '宁国市', '3');
INSERT INTO `sys_area` VALUES (1137, -1, '350000', '福建省', '1');
INSERT INTO `sys_area` VALUES (1138, 1137, '350100', '福州市', '2');
INSERT INTO `sys_area` VALUES (1139, 1138, '350102', '鼓楼区', '3');
INSERT INTO `sys_area` VALUES (1140, 1138, '350103', '台江区', '3');
INSERT INTO `sys_area` VALUES (1141, 1138, '350104', '仓山区', '3');
INSERT INTO `sys_area` VALUES (1142, 1138, '350105', '马尾区', '3');
INSERT INTO `sys_area` VALUES (1143, 1138, '350111', '晋安区', '3');
INSERT INTO `sys_area` VALUES (1144, 1138, '350112', '长乐区', '3');
INSERT INTO `sys_area` VALUES (1145, 1138, '350121', '闽侯县', '3');
INSERT INTO `sys_area` VALUES (1146, 1138, '350122', '连江县', '3');
INSERT INTO `sys_area` VALUES (1147, 1138, '350123', '罗源县', '3');
INSERT INTO `sys_area` VALUES (1148, 1138, '350124', '闽清县', '3');
INSERT INTO `sys_area` VALUES (1149, 1138, '350125', '永泰县', '3');
INSERT INTO `sys_area` VALUES (1150, 1138, '350128', '平潭县', '3');
INSERT INTO `sys_area` VALUES (1151, 1138, '350181', '福清市', '3');
INSERT INTO `sys_area` VALUES (1152, 1137, '350200', '厦门市', '2');
INSERT INTO `sys_area` VALUES (1153, 1152, '350203', '思明区', '3');
INSERT INTO `sys_area` VALUES (1154, 1152, '350205', '海沧区', '3');
INSERT INTO `sys_area` VALUES (1155, 1152, '350206', '湖里区', '3');
INSERT INTO `sys_area` VALUES (1156, 1152, '350211', '集美区', '3');
INSERT INTO `sys_area` VALUES (1157, 1152, '350212', '同安区', '3');
INSERT INTO `sys_area` VALUES (1158, 1152, '350213', '翔安区', '3');
INSERT INTO `sys_area` VALUES (1159, 1137, '350300', '莆田市', '2');
INSERT INTO `sys_area` VALUES (1160, 1159, '350302', '城厢区', '3');
INSERT INTO `sys_area` VALUES (1161, 1159, '350303', '涵江区', '3');
INSERT INTO `sys_area` VALUES (1162, 1159, '350304', '荔城区', '3');
INSERT INTO `sys_area` VALUES (1163, 1159, '350305', '秀屿区', '3');
INSERT INTO `sys_area` VALUES (1164, 1159, '350322', '仙游县', '3');
INSERT INTO `sys_area` VALUES (1165, 1137, '350400', '三明市', '2');
INSERT INTO `sys_area` VALUES (1166, 1165, '350402', '梅列区', '3');
INSERT INTO `sys_area` VALUES (1167, 1165, '350403', '三元区', '3');
INSERT INTO `sys_area` VALUES (1168, 1165, '350421', '明溪县', '3');
INSERT INTO `sys_area` VALUES (1169, 1165, '350423', '清流县', '3');
INSERT INTO `sys_area` VALUES (1170, 1165, '350424', '宁化县', '3');
INSERT INTO `sys_area` VALUES (1171, 1165, '350425', '大田县', '3');
INSERT INTO `sys_area` VALUES (1172, 1165, '350426', '尤溪县', '3');
INSERT INTO `sys_area` VALUES (1173, 1165, '350427', '沙县', '3');
INSERT INTO `sys_area` VALUES (1174, 1165, '350428', '将乐县', '3');
INSERT INTO `sys_area` VALUES (1175, 1165, '350429', '泰宁县', '3');
INSERT INTO `sys_area` VALUES (1176, 1165, '350430', '建宁县', '3');
INSERT INTO `sys_area` VALUES (1177, 1165, '350481', '永安市', '3');
INSERT INTO `sys_area` VALUES (1178, 1137, '350500', '泉州市', '2');
INSERT INTO `sys_area` VALUES (1179, 1178, '350502', '鲤城区', '3');
INSERT INTO `sys_area` VALUES (1180, 1178, '350503', '丰泽区', '3');
INSERT INTO `sys_area` VALUES (1181, 1178, '350504', '洛江区', '3');
INSERT INTO `sys_area` VALUES (1182, 1178, '350505', '泉港区', '3');
INSERT INTO `sys_area` VALUES (1183, 1178, '350521', '惠安县', '3');
INSERT INTO `sys_area` VALUES (1184, 1178, '350524', '安溪县', '3');
INSERT INTO `sys_area` VALUES (1185, 1178, '350525', '永春县', '3');
INSERT INTO `sys_area` VALUES (1186, 1178, '350526', '德化县', '3');
INSERT INTO `sys_area` VALUES (1187, 1178, '350527', '金门县', '3');
INSERT INTO `sys_area` VALUES (1188, 1178, '350581', '石狮市', '3');
INSERT INTO `sys_area` VALUES (1189, 1178, '350582', '晋江市', '3');
INSERT INTO `sys_area` VALUES (1190, 1178, '350583', '南安市', '3');
INSERT INTO `sys_area` VALUES (1191, 1137, '350600', '漳州市', '2');
INSERT INTO `sys_area` VALUES (1192, 1191, '350602', '芗城区', '3');
INSERT INTO `sys_area` VALUES (1193, 1191, '350603', '龙文区', '3');
INSERT INTO `sys_area` VALUES (1194, 1191, '350622', '云霄县', '3');
INSERT INTO `sys_area` VALUES (1195, 1191, '350623', '漳浦县', '3');
INSERT INTO `sys_area` VALUES (1196, 1191, '350624', '诏安县', '3');
INSERT INTO `sys_area` VALUES (1197, 1191, '350625', '长泰县', '3');
INSERT INTO `sys_area` VALUES (1198, 1191, '350626', '东山县', '3');
INSERT INTO `sys_area` VALUES (1199, 1191, '350627', '南靖县', '3');
INSERT INTO `sys_area` VALUES (1200, 1191, '350628', '平和县', '3');
INSERT INTO `sys_area` VALUES (1201, 1191, '350629', '华安县', '3');
INSERT INTO `sys_area` VALUES (1202, 1191, '350681', '龙海市', '3');
INSERT INTO `sys_area` VALUES (1203, 1137, '350700', '南平市', '2');
INSERT INTO `sys_area` VALUES (1204, 1203, '350702', '延平区', '3');
INSERT INTO `sys_area` VALUES (1205, 1203, '350703', '建阳区', '3');
INSERT INTO `sys_area` VALUES (1206, 1203, '350721', '顺昌县', '3');
INSERT INTO `sys_area` VALUES (1207, 1203, '350722', '浦城县', '3');
INSERT INTO `sys_area` VALUES (1208, 1203, '350723', '光泽县', '3');
INSERT INTO `sys_area` VALUES (1209, 1203, '350724', '松溪县', '3');
INSERT INTO `sys_area` VALUES (1210, 1203, '350725', '政和县', '3');
INSERT INTO `sys_area` VALUES (1211, 1203, '350781', '邵武市', '3');
INSERT INTO `sys_area` VALUES (1212, 1203, '350782', '武夷山市', '3');
INSERT INTO `sys_area` VALUES (1213, 1203, '350783', '建瓯市', '3');
INSERT INTO `sys_area` VALUES (1214, 1137, '350800', '龙岩市', '2');
INSERT INTO `sys_area` VALUES (1215, 1214, '350802', '新罗区', '3');
INSERT INTO `sys_area` VALUES (1216, 1214, '350803', '永定区', '3');
INSERT INTO `sys_area` VALUES (1217, 1214, '350821', '长汀县', '3');
INSERT INTO `sys_area` VALUES (1218, 1214, '350823', '上杭县', '3');
INSERT INTO `sys_area` VALUES (1219, 1214, '350824', '武平县', '3');
INSERT INTO `sys_area` VALUES (1220, 1214, '350825', '连城县', '3');
INSERT INTO `sys_area` VALUES (1221, 1214, '350881', '漳平市', '3');
INSERT INTO `sys_area` VALUES (1222, 1137, '350900', '宁德市', '2');
INSERT INTO `sys_area` VALUES (1223, 1222, '350902', '蕉城区', '3');
INSERT INTO `sys_area` VALUES (1224, 1222, '350921', '霞浦县', '3');
INSERT INTO `sys_area` VALUES (1225, 1222, '350922', '古田县', '3');
INSERT INTO `sys_area` VALUES (1226, 1222, '350923', '屏南县', '3');
INSERT INTO `sys_area` VALUES (1227, 1222, '350924', '寿宁县', '3');
INSERT INTO `sys_area` VALUES (1228, 1222, '350925', '周宁县', '3');
INSERT INTO `sys_area` VALUES (1229, 1222, '350926', '柘荣县', '3');
INSERT INTO `sys_area` VALUES (1230, 1222, '350981', '福安市', '3');
INSERT INTO `sys_area` VALUES (1231, 1222, '350982', '福鼎市', '3');
INSERT INTO `sys_area` VALUES (1232, -1, '360000', '江西省', '1');
INSERT INTO `sys_area` VALUES (1233, 1232, '360100', '南昌市', '2');
INSERT INTO `sys_area` VALUES (1234, 1233, '360102', '东湖区', '3');
INSERT INTO `sys_area` VALUES (1235, 1233, '360103', '西湖区', '3');
INSERT INTO `sys_area` VALUES (1236, 1233, '360104', '青云谱区', '3');
INSERT INTO `sys_area` VALUES (1237, 1233, '360105', '湾里区', '3');
INSERT INTO `sys_area` VALUES (1238, 1233, '360111', '青山湖区', '3');
INSERT INTO `sys_area` VALUES (1239, 1233, '360112', '新建区', '3');
INSERT INTO `sys_area` VALUES (1240, 1233, '360121', '南昌县', '3');
INSERT INTO `sys_area` VALUES (1241, 1233, '360123', '安义县', '3');
INSERT INTO `sys_area` VALUES (1242, 1233, '360124', '进贤县', '3');
INSERT INTO `sys_area` VALUES (1243, 1232, '360200', '景德镇市', '2');
INSERT INTO `sys_area` VALUES (1244, 1243, '360202', '昌江区', '3');
INSERT INTO `sys_area` VALUES (1245, 1243, '360203', '珠山区', '3');
INSERT INTO `sys_area` VALUES (1246, 1243, '360222', '浮梁县', '3');
INSERT INTO `sys_area` VALUES (1247, 1243, '360281', '乐平市', '3');
INSERT INTO `sys_area` VALUES (1248, 1232, '360300', '萍乡市', '2');
INSERT INTO `sys_area` VALUES (1249, 1248, '360302', '安源区', '3');
INSERT INTO `sys_area` VALUES (1250, 1248, '360313', '湘东区', '3');
INSERT INTO `sys_area` VALUES (1251, 1248, '360321', '莲花县', '3');
INSERT INTO `sys_area` VALUES (1252, 1248, '360322', '上栗县', '3');
INSERT INTO `sys_area` VALUES (1253, 1248, '360323', '芦溪县', '3');
INSERT INTO `sys_area` VALUES (1254, 1232, '360400', '九江市', '2');
INSERT INTO `sys_area` VALUES (1255, 1254, '360402', '濂溪区', '3');
INSERT INTO `sys_area` VALUES (1256, 1254, '360403', '浔阳区', '3');
INSERT INTO `sys_area` VALUES (1257, 1254, '360404', '柴桑区', '3');
INSERT INTO `sys_area` VALUES (1258, 1254, '360423', '武宁县', '3');
INSERT INTO `sys_area` VALUES (1259, 1254, '360424', '修水县', '3');
INSERT INTO `sys_area` VALUES (1260, 1254, '360425', '永修县', '3');
INSERT INTO `sys_area` VALUES (1261, 1254, '360426', '德安县', '3');
INSERT INTO `sys_area` VALUES (1262, 1254, '360428', '都昌县', '3');
INSERT INTO `sys_area` VALUES (1263, 1254, '360429', '湖口县', '3');
INSERT INTO `sys_area` VALUES (1264, 1254, '360430', '彭泽县', '3');
INSERT INTO `sys_area` VALUES (1265, 1254, '360481', '瑞昌市', '3');
INSERT INTO `sys_area` VALUES (1266, 1254, '360482', '共青城市', '3');
INSERT INTO `sys_area` VALUES (1267, 1254, '360483', '庐山市', '3');
INSERT INTO `sys_area` VALUES (1268, 1232, '360500', '新余市', '2');
INSERT INTO `sys_area` VALUES (1269, 1268, '360502', '渝水区', '3');
INSERT INTO `sys_area` VALUES (1270, 1268, '360521', '分宜县', '3');
INSERT INTO `sys_area` VALUES (1271, 1232, '360600', '鹰潭市', '2');
INSERT INTO `sys_area` VALUES (1272, 1271, '360602', '月湖区', '3');
INSERT INTO `sys_area` VALUES (1273, 1271, '360603', '余江区', '3');
INSERT INTO `sys_area` VALUES (1274, 1271, '360681', '贵溪市', '3');
INSERT INTO `sys_area` VALUES (1275, 1232, '360700', '赣州市', '2');
INSERT INTO `sys_area` VALUES (1276, 1275, '360702', '章贡区', '3');
INSERT INTO `sys_area` VALUES (1277, 1275, '360703', '南康区', '3');
INSERT INTO `sys_area` VALUES (1278, 1275, '360704', '赣县区', '3');
INSERT INTO `sys_area` VALUES (1279, 1275, '360722', '信丰县', '3');
INSERT INTO `sys_area` VALUES (1280, 1275, '360723', '大余县', '3');
INSERT INTO `sys_area` VALUES (1281, 1275, '360724', '上犹县', '3');
INSERT INTO `sys_area` VALUES (1282, 1275, '360725', '崇义县', '3');
INSERT INTO `sys_area` VALUES (1283, 1275, '360726', '安远县', '3');
INSERT INTO `sys_area` VALUES (1284, 1275, '360727', '龙南县', '3');
INSERT INTO `sys_area` VALUES (1285, 1275, '360728', '定南县', '3');
INSERT INTO `sys_area` VALUES (1286, 1275, '360729', '全南县', '3');
INSERT INTO `sys_area` VALUES (1287, 1275, '360730', '宁都县', '3');
INSERT INTO `sys_area` VALUES (1288, 1275, '360731', '于都县', '3');
INSERT INTO `sys_area` VALUES (1289, 1275, '360732', '兴国县', '3');
INSERT INTO `sys_area` VALUES (1290, 1275, '360733', '会昌县', '3');
INSERT INTO `sys_area` VALUES (1291, 1275, '360734', '寻乌县', '3');
INSERT INTO `sys_area` VALUES (1292, 1275, '360735', '石城县', '3');
INSERT INTO `sys_area` VALUES (1293, 1275, '360781', '瑞金市', '3');
INSERT INTO `sys_area` VALUES (1294, 1232, '360800', '吉安市', '2');
INSERT INTO `sys_area` VALUES (1295, 1294, '360802', '吉州区', '3');
INSERT INTO `sys_area` VALUES (1296, 1294, '360803', '青原区', '3');
INSERT INTO `sys_area` VALUES (1297, 1294, '360821', '吉安县', '3');
INSERT INTO `sys_area` VALUES (1298, 1294, '360822', '吉水县', '3');
INSERT INTO `sys_area` VALUES (1299, 1294, '360823', '峡江县', '3');
INSERT INTO `sys_area` VALUES (1300, 1294, '360824', '新干县', '3');
INSERT INTO `sys_area` VALUES (1301, 1294, '360825', '永丰县', '3');
INSERT INTO `sys_area` VALUES (1302, 1294, '360826', '泰和县', '3');
INSERT INTO `sys_area` VALUES (1303, 1294, '360827', '遂川县', '3');
INSERT INTO `sys_area` VALUES (1304, 1294, '360828', '万安县', '3');
INSERT INTO `sys_area` VALUES (1305, 1294, '360829', '安福县', '3');
INSERT INTO `sys_area` VALUES (1306, 1294, '360830', '永新县', '3');
INSERT INTO `sys_area` VALUES (1307, 1294, '360881', '井冈山市', '3');
INSERT INTO `sys_area` VALUES (1308, 1232, '360900', '宜春市', '2');
INSERT INTO `sys_area` VALUES (1309, 1308, '360902', '袁州区', '3');
INSERT INTO `sys_area` VALUES (1310, 1308, '360921', '奉新县', '3');
INSERT INTO `sys_area` VALUES (1311, 1308, '360922', '万载县', '3');
INSERT INTO `sys_area` VALUES (1312, 1308, '360923', '上高县', '3');
INSERT INTO `sys_area` VALUES (1313, 1308, '360924', '宜丰县', '3');
INSERT INTO `sys_area` VALUES (1314, 1308, '360925', '靖安县', '3');
INSERT INTO `sys_area` VALUES (1315, 1308, '360926', '铜鼓县', '3');
INSERT INTO `sys_area` VALUES (1316, 1308, '360981', '丰城市', '3');
INSERT INTO `sys_area` VALUES (1317, 1308, '360982', '樟树市', '3');
INSERT INTO `sys_area` VALUES (1318, 1308, '360983', '高安市', '3');
INSERT INTO `sys_area` VALUES (1319, 1232, '361000', '抚州市', '2');
INSERT INTO `sys_area` VALUES (1320, 1319, '361002', '临川区', '3');
INSERT INTO `sys_area` VALUES (1321, 1319, '361003', '东乡区', '3');
INSERT INTO `sys_area` VALUES (1322, 1319, '361021', '南城县', '3');
INSERT INTO `sys_area` VALUES (1323, 1319, '361022', '黎川县', '3');
INSERT INTO `sys_area` VALUES (1324, 1319, '361023', '南丰县', '3');
INSERT INTO `sys_area` VALUES (1325, 1319, '361024', '崇仁县', '3');
INSERT INTO `sys_area` VALUES (1326, 1319, '361025', '乐安县', '3');
INSERT INTO `sys_area` VALUES (1327, 1319, '361026', '宜黄县', '3');
INSERT INTO `sys_area` VALUES (1328, 1319, '361027', '金溪县', '3');
INSERT INTO `sys_area` VALUES (1329, 1319, '361028', '资溪县', '3');
INSERT INTO `sys_area` VALUES (1330, 1319, '361030', '广昌县', '3');
INSERT INTO `sys_area` VALUES (1331, 1232, '361100', '上饶市', '2');
INSERT INTO `sys_area` VALUES (1332, 1331, '361102', '信州区', '3');
INSERT INTO `sys_area` VALUES (1333, 1331, '361103', '广丰区', '3');
INSERT INTO `sys_area` VALUES (1334, 1331, '361121', '上饶县', '3');
INSERT INTO `sys_area` VALUES (1335, 1331, '361123', '玉山县', '3');
INSERT INTO `sys_area` VALUES (1336, 1331, '361124', '铅山县', '3');
INSERT INTO `sys_area` VALUES (1337, 1331, '361125', '横峰县', '3');
INSERT INTO `sys_area` VALUES (1338, 1331, '361126', '弋阳县', '3');
INSERT INTO `sys_area` VALUES (1339, 1331, '361127', '余干县', '3');
INSERT INTO `sys_area` VALUES (1340, 1331, '361128', '鄱阳县', '3');
INSERT INTO `sys_area` VALUES (1341, 1331, '361129', '万年县', '3');
INSERT INTO `sys_area` VALUES (1342, 1331, '361130', '婺源县', '3');
INSERT INTO `sys_area` VALUES (1343, 1331, '361181', '德兴市', '3');
INSERT INTO `sys_area` VALUES (1344, -1, '370000', '山东省', '1');
INSERT INTO `sys_area` VALUES (1345, 1344, '370100', '济南市', '2');
INSERT INTO `sys_area` VALUES (1346, 1345, '370102', '历下区', '3');
INSERT INTO `sys_area` VALUES (1347, 1345, '370103', '市中区', '3');
INSERT INTO `sys_area` VALUES (1348, 1345, '370104', '槐荫区', '3');
INSERT INTO `sys_area` VALUES (1349, 1345, '370105', '天桥区', '3');
INSERT INTO `sys_area` VALUES (1350, 1345, '370112', '历城区', '3');
INSERT INTO `sys_area` VALUES (1351, 1345, '370113', '长清区', '3');
INSERT INTO `sys_area` VALUES (1352, 1345, '370114', '章丘区', '3');
INSERT INTO `sys_area` VALUES (1353, 1345, '370115', '济阳区', '3');
INSERT INTO `sys_area` VALUES (1354, 1345, '370124', '平阴县', '3');
INSERT INTO `sys_area` VALUES (1355, 1345, '370126', '商河县', '3');
INSERT INTO `sys_area` VALUES (1356, 1344, '370200', '青岛市', '2');
INSERT INTO `sys_area` VALUES (1357, 1356, '370202', '市南区', '3');
INSERT INTO `sys_area` VALUES (1358, 1356, '370203', '市北区', '3');
INSERT INTO `sys_area` VALUES (1359, 1356, '370211', '黄岛区', '3');
INSERT INTO `sys_area` VALUES (1360, 1356, '370212', '崂山区', '3');
INSERT INTO `sys_area` VALUES (1361, 1356, '370213', '李沧区', '3');
INSERT INTO `sys_area` VALUES (1362, 1356, '370214', '城阳区', '3');
INSERT INTO `sys_area` VALUES (1363, 1356, '370215', '即墨区', '3');
INSERT INTO `sys_area` VALUES (1364, 1356, '370281', '胶州市', '3');
INSERT INTO `sys_area` VALUES (1365, 1356, '370283', '平度市', '3');
INSERT INTO `sys_area` VALUES (1366, 1356, '370285', '莱西市', '3');
INSERT INTO `sys_area` VALUES (1367, 1344, '370300', '淄博市', '2');
INSERT INTO `sys_area` VALUES (1368, 1367, '370302', '淄川区', '3');
INSERT INTO `sys_area` VALUES (1369, 1367, '370303', '张店区', '3');
INSERT INTO `sys_area` VALUES (1370, 1367, '370304', '博山区', '3');
INSERT INTO `sys_area` VALUES (1371, 1367, '370305', '临淄区', '3');
INSERT INTO `sys_area` VALUES (1372, 1367, '370306', '周村区', '3');
INSERT INTO `sys_area` VALUES (1373, 1367, '370321', '桓台县', '3');
INSERT INTO `sys_area` VALUES (1374, 1367, '370322', '高青县', '3');
INSERT INTO `sys_area` VALUES (1375, 1367, '370323', '沂源县', '3');
INSERT INTO `sys_area` VALUES (1376, 1344, '370400', '枣庄市', '2');
INSERT INTO `sys_area` VALUES (1377, 1376, '370402', '市中区', '3');
INSERT INTO `sys_area` VALUES (1378, 1376, '370403', '薛城区', '3');
INSERT INTO `sys_area` VALUES (1379, 1376, '370404', '峄城区', '3');
INSERT INTO `sys_area` VALUES (1380, 1376, '370405', '台儿庄区', '3');
INSERT INTO `sys_area` VALUES (1381, 1376, '370406', '山亭区', '3');
INSERT INTO `sys_area` VALUES (1382, 1376, '370481', '滕州市', '3');
INSERT INTO `sys_area` VALUES (1383, 1344, '370500', '东营市', '2');
INSERT INTO `sys_area` VALUES (1384, 1383, '370502', '东营区', '3');
INSERT INTO `sys_area` VALUES (1385, 1383, '370503', '河口区', '3');
INSERT INTO `sys_area` VALUES (1386, 1383, '370505', '垦利区', '3');
INSERT INTO `sys_area` VALUES (1387, 1383, '370522', '利津县', '3');
INSERT INTO `sys_area` VALUES (1388, 1383, '370523', '广饶县', '3');
INSERT INTO `sys_area` VALUES (1389, 1344, '370600', '烟台市', '2');
INSERT INTO `sys_area` VALUES (1390, 1389, '370602', '芝罘区', '3');
INSERT INTO `sys_area` VALUES (1391, 1389, '370611', '福山区', '3');
INSERT INTO `sys_area` VALUES (1392, 1389, '370612', '牟平区', '3');
INSERT INTO `sys_area` VALUES (1393, 1389, '370613', '莱山区', '3');
INSERT INTO `sys_area` VALUES (1394, 1389, '370634', '长岛县', '3');
INSERT INTO `sys_area` VALUES (1395, 1389, '370681', '龙口市', '3');
INSERT INTO `sys_area` VALUES (1396, 1389, '370682', '莱阳市', '3');
INSERT INTO `sys_area` VALUES (1397, 1389, '370683', '莱州市', '3');
INSERT INTO `sys_area` VALUES (1398, 1389, '370684', '蓬莱市', '3');
INSERT INTO `sys_area` VALUES (1399, 1389, '370685', '招远市', '3');
INSERT INTO `sys_area` VALUES (1400, 1389, '370686', '栖霞市', '3');
INSERT INTO `sys_area` VALUES (1401, 1389, '370687', '海阳市', '3');
INSERT INTO `sys_area` VALUES (1402, 1344, '370700', '潍坊市', '2');
INSERT INTO `sys_area` VALUES (1403, 1402, '370702', '潍城区', '3');
INSERT INTO `sys_area` VALUES (1404, 1402, '370703', '寒亭区', '3');
INSERT INTO `sys_area` VALUES (1405, 1402, '370704', '坊子区', '3');
INSERT INTO `sys_area` VALUES (1406, 1402, '370705', '奎文区', '3');
INSERT INTO `sys_area` VALUES (1407, 1402, '370724', '临朐县', '3');
INSERT INTO `sys_area` VALUES (1408, 1402, '370725', '昌乐县', '3');
INSERT INTO `sys_area` VALUES (1409, 1402, '370781', '青州市', '3');
INSERT INTO `sys_area` VALUES (1410, 1402, '370782', '诸城市', '3');
INSERT INTO `sys_area` VALUES (1411, 1402, '370783', '寿光市', '3');
INSERT INTO `sys_area` VALUES (1412, 1402, '370784', '安丘市', '3');
INSERT INTO `sys_area` VALUES (1413, 1402, '370785', '高密市', '3');
INSERT INTO `sys_area` VALUES (1414, 1402, '370786', '昌邑市', '3');
INSERT INTO `sys_area` VALUES (1415, 1344, '370800', '济宁市', '2');
INSERT INTO `sys_area` VALUES (1416, 1415, '370811', '任城区', '3');
INSERT INTO `sys_area` VALUES (1417, 1415, '370812', '兖州区', '3');
INSERT INTO `sys_area` VALUES (1418, 1415, '370826', '微山县', '3');
INSERT INTO `sys_area` VALUES (1419, 1415, '370827', '鱼台县', '3');
INSERT INTO `sys_area` VALUES (1420, 1415, '370828', '金乡县', '3');
INSERT INTO `sys_area` VALUES (1421, 1415, '370829', '嘉祥县', '3');
INSERT INTO `sys_area` VALUES (1422, 1415, '370830', '汶上县', '3');
INSERT INTO `sys_area` VALUES (1423, 1415, '370831', '泗水县', '3');
INSERT INTO `sys_area` VALUES (1424, 1415, '370832', '梁山县', '3');
INSERT INTO `sys_area` VALUES (1425, 1415, '370881', '曲阜市', '3');
INSERT INTO `sys_area` VALUES (1426, 1415, '370883', '邹城市', '3');
INSERT INTO `sys_area` VALUES (1427, 1344, '370900', '泰安市', '2');
INSERT INTO `sys_area` VALUES (1428, 1427, '370902', '泰山区', '3');
INSERT INTO `sys_area` VALUES (1429, 1427, '370911', '岱岳区', '3');
INSERT INTO `sys_area` VALUES (1430, 1427, '370921', '宁阳县', '3');
INSERT INTO `sys_area` VALUES (1431, 1427, '370923', '东平县', '3');
INSERT INTO `sys_area` VALUES (1432, 1427, '370982', '新泰市', '3');
INSERT INTO `sys_area` VALUES (1433, 1427, '370983', '肥城市', '3');
INSERT INTO `sys_area` VALUES (1434, 1344, '371000', '威海市', '2');
INSERT INTO `sys_area` VALUES (1435, 1434, '371002', '环翠区', '3');
INSERT INTO `sys_area` VALUES (1436, 1434, '371003', '文登区', '3');
INSERT INTO `sys_area` VALUES (1437, 1434, '371082', '荣成市', '3');
INSERT INTO `sys_area` VALUES (1438, 1434, '371083', '乳山市', '3');
INSERT INTO `sys_area` VALUES (1439, 1344, '371100', '日照市', '2');
INSERT INTO `sys_area` VALUES (1440, 1439, '371102', '东港区', '3');
INSERT INTO `sys_area` VALUES (1441, 1439, '371103', '岚山区', '3');
INSERT INTO `sys_area` VALUES (1442, 1439, '371121', '五莲县', '3');
INSERT INTO `sys_area` VALUES (1443, 1439, '371122', '莒县', '3');
INSERT INTO `sys_area` VALUES (1444, 1344, '371200', '莱芜市', '2');
INSERT INTO `sys_area` VALUES (1445, 1444, '371202', '莱城区', '3');
INSERT INTO `sys_area` VALUES (1446, 1444, '371203', '钢城区', '3');
INSERT INTO `sys_area` VALUES (1447, 1344, '371300', '临沂市', '2');
INSERT INTO `sys_area` VALUES (1448, 1447, '371302', '兰山区', '3');
INSERT INTO `sys_area` VALUES (1449, 1447, '371311', '罗庄区', '3');
INSERT INTO `sys_area` VALUES (1450, 1447, '371312', '河东区', '3');
INSERT INTO `sys_area` VALUES (1451, 1447, '371321', '沂南县', '3');
INSERT INTO `sys_area` VALUES (1452, 1447, '371322', '郯城县', '3');
INSERT INTO `sys_area` VALUES (1453, 1447, '371323', '沂水县', '3');
INSERT INTO `sys_area` VALUES (1454, 1447, '371324', '兰陵县', '3');
INSERT INTO `sys_area` VALUES (1455, 1447, '371325', '费县', '3');
INSERT INTO `sys_area` VALUES (1456, 1447, '371326', '平邑县', '3');
INSERT INTO `sys_area` VALUES (1457, 1447, '371327', '莒南县', '3');
INSERT INTO `sys_area` VALUES (1458, 1447, '371328', '蒙阴县', '3');
INSERT INTO `sys_area` VALUES (1459, 1447, '371329', '临沭县', '3');
INSERT INTO `sys_area` VALUES (1460, 1344, '371400', '德州市', '2');
INSERT INTO `sys_area` VALUES (1461, 1460, '371402', '德城区', '3');
INSERT INTO `sys_area` VALUES (1462, 1460, '371403', '陵城区', '3');
INSERT INTO `sys_area` VALUES (1463, 1460, '371422', '宁津县', '3');
INSERT INTO `sys_area` VALUES (1464, 1460, '371423', '庆云县', '3');
INSERT INTO `sys_area` VALUES (1465, 1460, '371424', '临邑县', '3');
INSERT INTO `sys_area` VALUES (1466, 1460, '371425', '齐河县', '3');
INSERT INTO `sys_area` VALUES (1467, 1460, '371426', '平原县', '3');
INSERT INTO `sys_area` VALUES (1468, 1460, '371427', '夏津县', '3');
INSERT INTO `sys_area` VALUES (1469, 1460, '371428', '武城县', '3');
INSERT INTO `sys_area` VALUES (1470, 1460, '371481', '乐陵市', '3');
INSERT INTO `sys_area` VALUES (1471, 1460, '371482', '禹城市', '3');
INSERT INTO `sys_area` VALUES (1472, 1344, '371500', '聊城市', '2');
INSERT INTO `sys_area` VALUES (1473, 1472, '371502', '东昌府区', '3');
INSERT INTO `sys_area` VALUES (1474, 1472, '371521', '阳谷县', '3');
INSERT INTO `sys_area` VALUES (1475, 1472, '371522', '莘县', '3');
INSERT INTO `sys_area` VALUES (1476, 1472, '371523', '茌平县', '3');
INSERT INTO `sys_area` VALUES (1477, 1472, '371524', '东阿县', '3');
INSERT INTO `sys_area` VALUES (1478, 1472, '371525', '冠县', '3');
INSERT INTO `sys_area` VALUES (1479, 1472, '371526', '高唐县', '3');
INSERT INTO `sys_area` VALUES (1480, 1472, '371581', '临清市', '3');
INSERT INTO `sys_area` VALUES (1481, 1344, '371600', '滨州市', '2');
INSERT INTO `sys_area` VALUES (1482, 1481, '371602', '滨城区', '3');
INSERT INTO `sys_area` VALUES (1483, 1481, '371603', '沾化区', '3');
INSERT INTO `sys_area` VALUES (1484, 1481, '371621', '惠民县', '3');
INSERT INTO `sys_area` VALUES (1485, 1481, '371622', '阳信县', '3');
INSERT INTO `sys_area` VALUES (1486, 1481, '371623', '无棣县', '3');
INSERT INTO `sys_area` VALUES (1487, 1481, '371625', '博兴县', '3');
INSERT INTO `sys_area` VALUES (1488, 1481, '371681', '邹平市', '3');
INSERT INTO `sys_area` VALUES (1489, 1344, '371700', '菏泽市', '2');
INSERT INTO `sys_area` VALUES (1490, 1489, '371702', '牡丹区', '3');
INSERT INTO `sys_area` VALUES (1491, 1489, '371703', '定陶区', '3');
INSERT INTO `sys_area` VALUES (1492, 1489, '371721', '曹县', '3');
INSERT INTO `sys_area` VALUES (1493, 1489, '371722', '单县', '3');
INSERT INTO `sys_area` VALUES (1494, 1489, '371723', '成武县', '3');
INSERT INTO `sys_area` VALUES (1495, 1489, '371724', '巨野县', '3');
INSERT INTO `sys_area` VALUES (1496, 1489, '371725', '郓城县', '3');
INSERT INTO `sys_area` VALUES (1497, 1489, '371726', '鄄城县', '3');
INSERT INTO `sys_area` VALUES (1498, 1489, '371728', '东明县', '3');
INSERT INTO `sys_area` VALUES (1499, -1, '410000', '河南省', '1');
INSERT INTO `sys_area` VALUES (1500, 1499, '410100', '郑州市', '2');
INSERT INTO `sys_area` VALUES (1501, 1500, '410102', '中原区', '3');
INSERT INTO `sys_area` VALUES (1502, 1500, '410103', '二七区', '3');
INSERT INTO `sys_area` VALUES (1503, 1500, '410104', '管城回族区', '3');
INSERT INTO `sys_area` VALUES (1504, 1500, '410105', '金水区', '3');
INSERT INTO `sys_area` VALUES (1505, 1500, '410106', '上街区', '3');
INSERT INTO `sys_area` VALUES (1506, 1500, '410108', '惠济区', '3');
INSERT INTO `sys_area` VALUES (1507, 1500, '410122', '中牟县', '3');
INSERT INTO `sys_area` VALUES (1508, 1500, '410181', '巩义市', '3');
INSERT INTO `sys_area` VALUES (1509, 1500, '410182', '荥阳市', '3');
INSERT INTO `sys_area` VALUES (1510, 1500, '410183', '新密市', '3');
INSERT INTO `sys_area` VALUES (1511, 1500, '410184', '新郑市', '3');
INSERT INTO `sys_area` VALUES (1512, 1500, '410185', '登封市', '3');
INSERT INTO `sys_area` VALUES (1513, 1499, '410200', '开封市', '2');
INSERT INTO `sys_area` VALUES (1514, 1513, '410202', '龙亭区', '3');
INSERT INTO `sys_area` VALUES (1515, 1513, '410203', '顺河回族区', '3');
INSERT INTO `sys_area` VALUES (1516, 1513, '410204', '鼓楼区', '3');
INSERT INTO `sys_area` VALUES (1517, 1513, '410205', '禹王台区', '3');
INSERT INTO `sys_area` VALUES (1518, 1513, '410212', '祥符区', '3');
INSERT INTO `sys_area` VALUES (1519, 1513, '410221', '杞县', '3');
INSERT INTO `sys_area` VALUES (1520, 1513, '410222', '通许县', '3');
INSERT INTO `sys_area` VALUES (1521, 1513, '410223', '尉氏县', '3');
INSERT INTO `sys_area` VALUES (1522, 1513, '410225', '兰考县', '3');
INSERT INTO `sys_area` VALUES (1523, 1499, '410300', '洛阳市', '2');
INSERT INTO `sys_area` VALUES (1524, 1523, '410302', '老城区', '3');
INSERT INTO `sys_area` VALUES (1525, 1523, '410303', '西工区', '3');
INSERT INTO `sys_area` VALUES (1526, 1523, '410304', '瀍河回族区', '3');
INSERT INTO `sys_area` VALUES (1527, 1523, '410305', '涧西区', '3');
INSERT INTO `sys_area` VALUES (1528, 1523, '410306', '吉利区', '3');
INSERT INTO `sys_area` VALUES (1529, 1523, '410311', '洛龙区', '3');
INSERT INTO `sys_area` VALUES (1530, 1523, '410322', '孟津县', '3');
INSERT INTO `sys_area` VALUES (1531, 1523, '410323', '新安县', '3');
INSERT INTO `sys_area` VALUES (1532, 1523, '410324', '栾川县', '3');
INSERT INTO `sys_area` VALUES (1533, 1523, '410325', '嵩县', '3');
INSERT INTO `sys_area` VALUES (1534, 1523, '410326', '汝阳县', '3');
INSERT INTO `sys_area` VALUES (1535, 1523, '410327', '宜阳县', '3');
INSERT INTO `sys_area` VALUES (1536, 1523, '410328', '洛宁县', '3');
INSERT INTO `sys_area` VALUES (1537, 1523, '410329', '伊川县', '3');
INSERT INTO `sys_area` VALUES (1538, 1523, '410381', '偃师市', '3');
INSERT INTO `sys_area` VALUES (1539, 1499, '410400', '平顶山市', '2');
INSERT INTO `sys_area` VALUES (1540, 1539, '410402', '新华区', '3');
INSERT INTO `sys_area` VALUES (1541, 1539, '410403', '卫东区', '3');
INSERT INTO `sys_area` VALUES (1542, 1539, '410404', '石龙区', '3');
INSERT INTO `sys_area` VALUES (1543, 1539, '410411', '湛河区', '3');
INSERT INTO `sys_area` VALUES (1544, 1539, '410421', '宝丰县', '3');
INSERT INTO `sys_area` VALUES (1545, 1539, '410422', '叶县', '3');
INSERT INTO `sys_area` VALUES (1546, 1539, '410423', '鲁山县', '3');
INSERT INTO `sys_area` VALUES (1547, 1539, '410425', '郏县', '3');
INSERT INTO `sys_area` VALUES (1548, 1539, '410481', '舞钢市', '3');
INSERT INTO `sys_area` VALUES (1549, 1539, '410482', '汝州市', '3');
INSERT INTO `sys_area` VALUES (1550, 1499, '410500', '安阳市', '2');
INSERT INTO `sys_area` VALUES (1551, 1550, '410502', '文峰区', '3');
INSERT INTO `sys_area` VALUES (1552, 1550, '410503', '北关区', '3');
INSERT INTO `sys_area` VALUES (1553, 1550, '410505', '殷都区', '3');
INSERT INTO `sys_area` VALUES (1554, 1550, '410506', '龙安区', '3');
INSERT INTO `sys_area` VALUES (1555, 1550, '410522', '安阳县', '3');
INSERT INTO `sys_area` VALUES (1556, 1550, '410523', '汤阴县', '3');
INSERT INTO `sys_area` VALUES (1557, 1550, '410526', '滑县', '3');
INSERT INTO `sys_area` VALUES (1558, 1550, '410527', '内黄县', '3');
INSERT INTO `sys_area` VALUES (1559, 1550, '410581', '林州市', '3');
INSERT INTO `sys_area` VALUES (1560, 1499, '410600', '鹤壁市', '2');
INSERT INTO `sys_area` VALUES (1561, 1560, '410602', '鹤山区', '3');
INSERT INTO `sys_area` VALUES (1562, 1560, '410603', '山城区', '3');
INSERT INTO `sys_area` VALUES (1563, 1560, '410611', '淇滨区', '3');
INSERT INTO `sys_area` VALUES (1564, 1560, '410621', '浚县', '3');
INSERT INTO `sys_area` VALUES (1565, 1560, '410622', '淇县', '3');
INSERT INTO `sys_area` VALUES (1566, 1499, '410700', '新乡市', '2');
INSERT INTO `sys_area` VALUES (1567, 1566, '410702', '红旗区', '3');
INSERT INTO `sys_area` VALUES (1568, 1566, '410703', '卫滨区', '3');
INSERT INTO `sys_area` VALUES (1569, 1566, '410704', '凤泉区', '3');
INSERT INTO `sys_area` VALUES (1570, 1566, '410711', '牧野区', '3');
INSERT INTO `sys_area` VALUES (1571, 1566, '410721', '新乡县', '3');
INSERT INTO `sys_area` VALUES (1572, 1566, '410724', '获嘉县', '3');
INSERT INTO `sys_area` VALUES (1573, 1566, '410725', '原阳县', '3');
INSERT INTO `sys_area` VALUES (1574, 1566, '410726', '延津县', '3');
INSERT INTO `sys_area` VALUES (1575, 1566, '410727', '封丘县', '3');
INSERT INTO `sys_area` VALUES (1576, 1566, '410728', '长垣县', '3');
INSERT INTO `sys_area` VALUES (1577, 1566, '410781', '卫辉市', '3');
INSERT INTO `sys_area` VALUES (1578, 1566, '410782', '辉县市', '3');
INSERT INTO `sys_area` VALUES (1579, 1499, '410800', '焦作市', '2');
INSERT INTO `sys_area` VALUES (1580, 1579, '410802', '解放区', '3');
INSERT INTO `sys_area` VALUES (1581, 1579, '410803', '中站区', '3');
INSERT INTO `sys_area` VALUES (1582, 1579, '410804', '马村区', '3');
INSERT INTO `sys_area` VALUES (1583, 1579, '410811', '山阳区', '3');
INSERT INTO `sys_area` VALUES (1584, 1579, '410821', '修武县', '3');
INSERT INTO `sys_area` VALUES (1585, 1579, '410822', '博爱县', '3');
INSERT INTO `sys_area` VALUES (1586, 1579, '410823', '武陟县', '3');
INSERT INTO `sys_area` VALUES (1587, 1579, '410825', '温县', '3');
INSERT INTO `sys_area` VALUES (1588, 1579, '410882', '沁阳市', '3');
INSERT INTO `sys_area` VALUES (1589, 1579, '410883', '孟州市', '3');
INSERT INTO `sys_area` VALUES (1590, 1499, '410900', '濮阳市', '2');
INSERT INTO `sys_area` VALUES (1591, 1590, '410902', '华龙区', '3');
INSERT INTO `sys_area` VALUES (1592, 1590, '410922', '清丰县', '3');
INSERT INTO `sys_area` VALUES (1593, 1590, '410923', '南乐县', '3');
INSERT INTO `sys_area` VALUES (1594, 1590, '410926', '范县', '3');
INSERT INTO `sys_area` VALUES (1595, 1590, '410927', '台前县', '3');
INSERT INTO `sys_area` VALUES (1596, 1590, '410928', '濮阳县', '3');
INSERT INTO `sys_area` VALUES (1597, 1499, '411000', '许昌市', '2');
INSERT INTO `sys_area` VALUES (1598, 1597, '411002', '魏都区', '3');
INSERT INTO `sys_area` VALUES (1599, 1597, '411003', '建安区', '3');
INSERT INTO `sys_area` VALUES (1600, 1597, '411024', '鄢陵县', '3');
INSERT INTO `sys_area` VALUES (1601, 1597, '411025', '襄城县', '3');
INSERT INTO `sys_area` VALUES (1602, 1597, '411081', '禹州市', '3');
INSERT INTO `sys_area` VALUES (1603, 1597, '411082', '长葛市', '3');
INSERT INTO `sys_area` VALUES (1604, 1499, '411100', '漯河市', '2');
INSERT INTO `sys_area` VALUES (1605, 1604, '411102', '源汇区', '3');
INSERT INTO `sys_area` VALUES (1606, 1604, '411103', '郾城区', '3');
INSERT INTO `sys_area` VALUES (1607, 1604, '411104', '召陵区', '3');
INSERT INTO `sys_area` VALUES (1608, 1604, '411121', '舞阳县', '3');
INSERT INTO `sys_area` VALUES (1609, 1604, '411122', '临颍县', '3');
INSERT INTO `sys_area` VALUES (1610, 1499, '411200', '三门峡市', '2');
INSERT INTO `sys_area` VALUES (1611, 1610, '411202', '湖滨区', '3');
INSERT INTO `sys_area` VALUES (1612, 1610, '411203', '陕州区', '3');
INSERT INTO `sys_area` VALUES (1613, 1610, '411221', '渑池县', '3');
INSERT INTO `sys_area` VALUES (1614, 1610, '411224', '卢氏县', '3');
INSERT INTO `sys_area` VALUES (1615, 1610, '411281', '义马市', '3');
INSERT INTO `sys_area` VALUES (1616, 1610, '411282', '灵宝市', '3');
INSERT INTO `sys_area` VALUES (1617, 1499, '411300', '南阳市', '2');
INSERT INTO `sys_area` VALUES (1618, 1617, '411302', '宛城区', '3');
INSERT INTO `sys_area` VALUES (1619, 1617, '411303', '卧龙区', '3');
INSERT INTO `sys_area` VALUES (1620, 1617, '411321', '南召县', '3');
INSERT INTO `sys_area` VALUES (1621, 1617, '411322', '方城县', '3');
INSERT INTO `sys_area` VALUES (1622, 1617, '411323', '西峡县', '3');
INSERT INTO `sys_area` VALUES (1623, 1617, '411324', '镇平县', '3');
INSERT INTO `sys_area` VALUES (1624, 1617, '411325', '内乡县', '3');
INSERT INTO `sys_area` VALUES (1625, 1617, '411326', '淅川县', '3');
INSERT INTO `sys_area` VALUES (1626, 1617, '411327', '社旗县', '3');
INSERT INTO `sys_area` VALUES (1627, 1617, '411328', '唐河县', '3');
INSERT INTO `sys_area` VALUES (1628, 1617, '411329', '新野县', '3');
INSERT INTO `sys_area` VALUES (1629, 1617, '411330', '桐柏县', '3');
INSERT INTO `sys_area` VALUES (1630, 1617, '411381', '邓州市', '3');
INSERT INTO `sys_area` VALUES (1631, 1499, '411400', '商丘市', '2');
INSERT INTO `sys_area` VALUES (1632, 1631, '411402', '梁园区', '3');
INSERT INTO `sys_area` VALUES (1633, 1631, '411403', '睢阳区', '3');
INSERT INTO `sys_area` VALUES (1634, 1631, '411421', '民权县', '3');
INSERT INTO `sys_area` VALUES (1635, 1631, '411422', '睢县', '3');
INSERT INTO `sys_area` VALUES (1636, 1631, '411423', '宁陵县', '3');
INSERT INTO `sys_area` VALUES (1637, 1631, '411424', '柘城县', '3');
INSERT INTO `sys_area` VALUES (1638, 1631, '411425', '虞城县', '3');
INSERT INTO `sys_area` VALUES (1639, 1631, '411426', '夏邑县', '3');
INSERT INTO `sys_area` VALUES (1640, 1631, '411481', '永城市', '3');
INSERT INTO `sys_area` VALUES (1641, 1499, '411500', '信阳市', '2');
INSERT INTO `sys_area` VALUES (1642, 1641, '411502', '浉河区', '3');
INSERT INTO `sys_area` VALUES (1643, 1641, '411503', '平桥区', '3');
INSERT INTO `sys_area` VALUES (1644, 1641, '411521', '罗山县', '3');
INSERT INTO `sys_area` VALUES (1645, 1641, '411522', '光山县', '3');
INSERT INTO `sys_area` VALUES (1646, 1641, '411523', '新县', '3');
INSERT INTO `sys_area` VALUES (1647, 1641, '411524', '商城县', '3');
INSERT INTO `sys_area` VALUES (1648, 1641, '411525', '固始县', '3');
INSERT INTO `sys_area` VALUES (1649, 1641, '411526', '潢川县', '3');
INSERT INTO `sys_area` VALUES (1650, 1641, '411527', '淮滨县', '3');
INSERT INTO `sys_area` VALUES (1651, 1641, '411528', '息县', '3');
INSERT INTO `sys_area` VALUES (1652, 1499, '411600', '周口市', '2');
INSERT INTO `sys_area` VALUES (1653, 1652, '411602', '川汇区', '3');
INSERT INTO `sys_area` VALUES (1654, 1652, '411621', '扶沟县', '3');
INSERT INTO `sys_area` VALUES (1655, 1652, '411622', '西华县', '3');
INSERT INTO `sys_area` VALUES (1656, 1652, '411623', '商水县', '3');
INSERT INTO `sys_area` VALUES (1657, 1652, '411624', '沈丘县', '3');
INSERT INTO `sys_area` VALUES (1658, 1652, '411625', '郸城县', '3');
INSERT INTO `sys_area` VALUES (1659, 1652, '411626', '淮阳县', '3');
INSERT INTO `sys_area` VALUES (1660, 1652, '411627', '太康县', '3');
INSERT INTO `sys_area` VALUES (1661, 1652, '411628', '鹿邑县', '3');
INSERT INTO `sys_area` VALUES (1662, 1652, '411681', '项城市', '3');
INSERT INTO `sys_area` VALUES (1663, 1499, '411700', '驻马店市', '2');
INSERT INTO `sys_area` VALUES (1664, 1663, '411702', '驿城区', '3');
INSERT INTO `sys_area` VALUES (1665, 1663, '411721', '西平县', '3');
INSERT INTO `sys_area` VALUES (1666, 1663, '411722', '上蔡县', '3');
INSERT INTO `sys_area` VALUES (1667, 1663, '411723', '平舆县', '3');
INSERT INTO `sys_area` VALUES (1668, 1663, '411724', '正阳县', '3');
INSERT INTO `sys_area` VALUES (1669, 1663, '411725', '确山县', '3');
INSERT INTO `sys_area` VALUES (1670, 1663, '411726', '泌阳县', '3');
INSERT INTO `sys_area` VALUES (1671, 1663, '411727', '汝南县', '3');
INSERT INTO `sys_area` VALUES (1672, 1663, '411728', '遂平县', '3');
INSERT INTO `sys_area` VALUES (1673, 1663, '411729', '新蔡县', '3');
INSERT INTO `sys_area` VALUES (1674, 1499, '419001', '济源市', '3');
INSERT INTO `sys_area` VALUES (1675, -1, '420000', '湖北省', '1');
INSERT INTO `sys_area` VALUES (1676, 1675, '420100', '武汉市', '2');
INSERT INTO `sys_area` VALUES (1677, 1676, '420102', '江岸区', '3');
INSERT INTO `sys_area` VALUES (1678, 1676, '420103', '江汉区', '3');
INSERT INTO `sys_area` VALUES (1679, 1676, '420104', '硚口区', '3');
INSERT INTO `sys_area` VALUES (1680, 1676, '420105', '汉阳区', '3');
INSERT INTO `sys_area` VALUES (1681, 1676, '420106', '武昌区', '3');
INSERT INTO `sys_area` VALUES (1682, 1676, '420107', '青山区', '3');
INSERT INTO `sys_area` VALUES (1683, 1676, '420111', '洪山区', '3');
INSERT INTO `sys_area` VALUES (1684, 1676, '420112', '东西湖区', '3');
INSERT INTO `sys_area` VALUES (1685, 1676, '420113', '汉南区', '3');
INSERT INTO `sys_area` VALUES (1686, 1676, '420114', '蔡甸区', '3');
INSERT INTO `sys_area` VALUES (1687, 1676, '420115', '江夏区', '3');
INSERT INTO `sys_area` VALUES (1688, 1676, '420116', '黄陂区', '3');
INSERT INTO `sys_area` VALUES (1689, 1676, '420117', '新洲区', '3');
INSERT INTO `sys_area` VALUES (1690, 1675, '420200', '黄石市', '2');
INSERT INTO `sys_area` VALUES (1691, 1690, '420202', '黄石港区', '3');
INSERT INTO `sys_area` VALUES (1692, 1690, '420203', '西塞山区', '3');
INSERT INTO `sys_area` VALUES (1693, 1690, '420204', '下陆区', '3');
INSERT INTO `sys_area` VALUES (1694, 1690, '420205', '铁山区', '3');
INSERT INTO `sys_area` VALUES (1695, 1690, '420222', '阳新县', '3');
INSERT INTO `sys_area` VALUES (1696, 1690, '420281', '大冶市', '3');
INSERT INTO `sys_area` VALUES (1697, 1675, '420300', '十堰市', '2');
INSERT INTO `sys_area` VALUES (1698, 1697, '420302', '茅箭区', '3');
INSERT INTO `sys_area` VALUES (1699, 1697, '420303', '张湾区', '3');
INSERT INTO `sys_area` VALUES (1700, 1697, '420304', '郧阳区', '3');
INSERT INTO `sys_area` VALUES (1701, 1697, '420322', '郧西县', '3');
INSERT INTO `sys_area` VALUES (1702, 1697, '420323', '竹山县', '3');
INSERT INTO `sys_area` VALUES (1703, 1697, '420324', '竹溪县', '3');
INSERT INTO `sys_area` VALUES (1704, 1697, '420325', '房县', '3');
INSERT INTO `sys_area` VALUES (1705, 1697, '420381', '丹江口市', '3');
INSERT INTO `sys_area` VALUES (1706, 1675, '420500', '宜昌市', '2');
INSERT INTO `sys_area` VALUES (1707, 1706, '420502', '西陵区', '3');
INSERT INTO `sys_area` VALUES (1708, 1706, '420503', '伍家岗区', '3');
INSERT INTO `sys_area` VALUES (1709, 1706, '420504', '点军区', '3');
INSERT INTO `sys_area` VALUES (1710, 1706, '420505', '猇亭区', '3');
INSERT INTO `sys_area` VALUES (1711, 1706, '420506', '夷陵区', '3');
INSERT INTO `sys_area` VALUES (1712, 1706, '420525', '远安县', '3');
INSERT INTO `sys_area` VALUES (1713, 1706, '420526', '兴山县', '3');
INSERT INTO `sys_area` VALUES (1714, 1706, '420527', '秭归县', '3');
INSERT INTO `sys_area` VALUES (1715, 1706, '420528', '长阳土家族自治县', '3');
INSERT INTO `sys_area` VALUES (1716, 1706, '420529', '五峰土家族自治县', '3');
INSERT INTO `sys_area` VALUES (1717, 1706, '420581', '宜都市', '3');
INSERT INTO `sys_area` VALUES (1718, 1706, '420582', '当阳市', '3');
INSERT INTO `sys_area` VALUES (1719, 1706, '420583', '枝江市', '3');
INSERT INTO `sys_area` VALUES (1720, 1675, '420600', '襄阳市', '2');
INSERT INTO `sys_area` VALUES (1721, 1720, '420602', '襄城区', '3');
INSERT INTO `sys_area` VALUES (1722, 1720, '420606', '樊城区', '3');
INSERT INTO `sys_area` VALUES (1723, 1720, '420607', '襄州区', '3');
INSERT INTO `sys_area` VALUES (1724, 1720, '420624', '南漳县', '3');
INSERT INTO `sys_area` VALUES (1725, 1720, '420625', '谷城县', '3');
INSERT INTO `sys_area` VALUES (1726, 1720, '420626', '保康县', '3');
INSERT INTO `sys_area` VALUES (1727, 1720, '420682', '老河口市', '3');
INSERT INTO `sys_area` VALUES (1728, 1720, '420683', '枣阳市', '3');
INSERT INTO `sys_area` VALUES (1729, 1720, '420684', '宜城市', '3');
INSERT INTO `sys_area` VALUES (1730, 1675, '420700', '鄂州市', '2');
INSERT INTO `sys_area` VALUES (1731, 1730, '420702', '梁子湖区', '3');
INSERT INTO `sys_area` VALUES (1732, 1730, '420703', '华容区', '3');
INSERT INTO `sys_area` VALUES (1733, 1730, '420704', '鄂城区', '3');
INSERT INTO `sys_area` VALUES (1734, 1675, '420800', '荆门市', '2');
INSERT INTO `sys_area` VALUES (1735, 1734, '420802', '东宝区', '3');
INSERT INTO `sys_area` VALUES (1736, 1734, '420804', '掇刀区', '3');
INSERT INTO `sys_area` VALUES (1737, 1734, '420822', '沙洋县', '3');
INSERT INTO `sys_area` VALUES (1738, 1734, '420881', '钟祥市', '3');
INSERT INTO `sys_area` VALUES (1739, 1734, '420882', '京山市', '3');
INSERT INTO `sys_area` VALUES (1740, 1675, '420900', '孝感市', '2');
INSERT INTO `sys_area` VALUES (1741, 1740, '420902', '孝南区', '3');
INSERT INTO `sys_area` VALUES (1742, 1740, '420921', '孝昌县', '3');
INSERT INTO `sys_area` VALUES (1743, 1740, '420922', '大悟县', '3');
INSERT INTO `sys_area` VALUES (1744, 1740, '420923', '云梦县', '3');
INSERT INTO `sys_area` VALUES (1745, 1740, '420981', '应城市', '3');
INSERT INTO `sys_area` VALUES (1746, 1740, '420982', '安陆市', '3');
INSERT INTO `sys_area` VALUES (1747, 1740, '420984', '汉川市', '3');
INSERT INTO `sys_area` VALUES (1748, 1675, '421000', '荆州市', '2');
INSERT INTO `sys_area` VALUES (1749, 1748, '421002', '沙市区', '3');
INSERT INTO `sys_area` VALUES (1750, 1748, '421003', '荆州区', '3');
INSERT INTO `sys_area` VALUES (1751, 1748, '421022', '公安县', '3');
INSERT INTO `sys_area` VALUES (1752, 1748, '421023', '监利县', '3');
INSERT INTO `sys_area` VALUES (1753, 1748, '421024', '江陵县', '3');
INSERT INTO `sys_area` VALUES (1754, 1748, '421081', '石首市', '3');
INSERT INTO `sys_area` VALUES (1755, 1748, '421083', '洪湖市', '3');
INSERT INTO `sys_area` VALUES (1756, 1748, '421087', '松滋市', '3');
INSERT INTO `sys_area` VALUES (1757, 1675, '421100', '黄冈市', '2');
INSERT INTO `sys_area` VALUES (1758, 1757, '421102', '黄州区', '3');
INSERT INTO `sys_area` VALUES (1759, 1757, '421121', '团风县', '3');
INSERT INTO `sys_area` VALUES (1760, 1757, '421122', '红安县', '3');
INSERT INTO `sys_area` VALUES (1761, 1757, '421123', '罗田县', '3');
INSERT INTO `sys_area` VALUES (1762, 1757, '421124', '英山县', '3');
INSERT INTO `sys_area` VALUES (1763, 1757, '421125', '浠水县', '3');
INSERT INTO `sys_area` VALUES (1764, 1757, '421126', '蕲春县', '3');
INSERT INTO `sys_area` VALUES (1765, 1757, '421127', '黄梅县', '3');
INSERT INTO `sys_area` VALUES (1766, 1757, '421181', '麻城市', '3');
INSERT INTO `sys_area` VALUES (1767, 1757, '421182', '武穴市', '3');
INSERT INTO `sys_area` VALUES (1768, 1675, '421200', '咸宁市', '2');
INSERT INTO `sys_area` VALUES (1769, 1768, '421202', '咸安区', '3');
INSERT INTO `sys_area` VALUES (1770, 1768, '421221', '嘉鱼县', '3');
INSERT INTO `sys_area` VALUES (1771, 1768, '421222', '通城县', '3');
INSERT INTO `sys_area` VALUES (1772, 1768, '421223', '崇阳县', '3');
INSERT INTO `sys_area` VALUES (1773, 1768, '421224', '通山县', '3');
INSERT INTO `sys_area` VALUES (1774, 1768, '421281', '赤壁市', '3');
INSERT INTO `sys_area` VALUES (1775, 1675, '421300', '随州市', '2');
INSERT INTO `sys_area` VALUES (1776, 1775, '421303', '曾都区', '3');
INSERT INTO `sys_area` VALUES (1777, 1775, '421321', '随县', '3');
INSERT INTO `sys_area` VALUES (1778, 1775, '421381', '广水市', '3');
INSERT INTO `sys_area` VALUES (1779, 1675, '422800', '恩施土家族苗族自治州', '2');
INSERT INTO `sys_area` VALUES (1780, 1779, '422801', '恩施市', '3');
INSERT INTO `sys_area` VALUES (1781, 1779, '422802', '利川市', '3');
INSERT INTO `sys_area` VALUES (1782, 1779, '422822', '建始县', '3');
INSERT INTO `sys_area` VALUES (1783, 1779, '422823', '巴东县', '3');
INSERT INTO `sys_area` VALUES (1784, 1779, '422825', '宣恩县', '3');
INSERT INTO `sys_area` VALUES (1785, 1779, '422826', '咸丰县', '3');
INSERT INTO `sys_area` VALUES (1786, 1779, '422827', '来凤县', '3');
INSERT INTO `sys_area` VALUES (1787, 1779, '422828', '鹤峰县', '3');
INSERT INTO `sys_area` VALUES (1788, 1675, '429004', '仙桃市', '3');
INSERT INTO `sys_area` VALUES (1789, 1675, '429005', '潜江市', '3');
INSERT INTO `sys_area` VALUES (1790, 1675, '429006', '天门市', '3');
INSERT INTO `sys_area` VALUES (1791, 1675, '429021', '神农架林区', '3');
INSERT INTO `sys_area` VALUES (1792, -1, '430000', '湖南省', '1');
INSERT INTO `sys_area` VALUES (1793, 1792, '430100', '长沙市', '2');
INSERT INTO `sys_area` VALUES (1794, 1793, '430102', '芙蓉区', '3');
INSERT INTO `sys_area` VALUES (1795, 1793, '430103', '天心区', '3');
INSERT INTO `sys_area` VALUES (1796, 1793, '430104', '岳麓区', '3');
INSERT INTO `sys_area` VALUES (1797, 1793, '430105', '开福区', '3');
INSERT INTO `sys_area` VALUES (1798, 1793, '430111', '雨花区', '3');
INSERT INTO `sys_area` VALUES (1799, 1793, '430112', '望城区', '3');
INSERT INTO `sys_area` VALUES (1800, 1793, '430121', '长沙县', '3');
INSERT INTO `sys_area` VALUES (1801, 1793, '430181', '浏阳市', '3');
INSERT INTO `sys_area` VALUES (1802, 1793, '430182', '宁乡市', '3');
INSERT INTO `sys_area` VALUES (1803, 1792, '430200', '株洲市', '2');
INSERT INTO `sys_area` VALUES (1804, 1803, '430202', '荷塘区', '3');
INSERT INTO `sys_area` VALUES (1805, 1803, '430203', '芦淞区', '3');
INSERT INTO `sys_area` VALUES (1806, 1803, '430204', '石峰区', '3');
INSERT INTO `sys_area` VALUES (1807, 1803, '430211', '天元区', '3');
INSERT INTO `sys_area` VALUES (1808, 1803, '430212', '渌口区', '3');
INSERT INTO `sys_area` VALUES (1809, 1803, '430223', '攸县', '3');
INSERT INTO `sys_area` VALUES (1810, 1803, '430224', '茶陵县', '3');
INSERT INTO `sys_area` VALUES (1811, 1803, '430225', '炎陵县', '3');
INSERT INTO `sys_area` VALUES (1812, 1803, '430281', '醴陵市', '3');
INSERT INTO `sys_area` VALUES (1813, 1792, '430300', '湘潭市', '2');
INSERT INTO `sys_area` VALUES (1814, 1813, '430302', '雨湖区', '3');
INSERT INTO `sys_area` VALUES (1815, 1813, '430304', '岳塘区', '3');
INSERT INTO `sys_area` VALUES (1816, 1813, '430321', '湘潭县', '3');
INSERT INTO `sys_area` VALUES (1817, 1813, '430381', '湘乡市', '3');
INSERT INTO `sys_area` VALUES (1818, 1813, '430382', '韶山市', '3');
INSERT INTO `sys_area` VALUES (1819, 1792, '430400', '衡阳市', '2');
INSERT INTO `sys_area` VALUES (1820, 1819, '430405', '珠晖区', '3');
INSERT INTO `sys_area` VALUES (1821, 1819, '430406', '雁峰区', '3');
INSERT INTO `sys_area` VALUES (1822, 1819, '430407', '石鼓区', '3');
INSERT INTO `sys_area` VALUES (1823, 1819, '430408', '蒸湘区', '3');
INSERT INTO `sys_area` VALUES (1824, 1819, '430412', '南岳区', '3');
INSERT INTO `sys_area` VALUES (1825, 1819, '430421', '衡阳县', '3');
INSERT INTO `sys_area` VALUES (1826, 1819, '430422', '衡南县', '3');
INSERT INTO `sys_area` VALUES (1827, 1819, '430423', '衡山县', '3');
INSERT INTO `sys_area` VALUES (1828, 1819, '430424', '衡东县', '3');
INSERT INTO `sys_area` VALUES (1829, 1819, '430426', '祁东县', '3');
INSERT INTO `sys_area` VALUES (1830, 1819, '430481', '耒阳市', '3');
INSERT INTO `sys_area` VALUES (1831, 1819, '430482', '常宁市', '3');
INSERT INTO `sys_area` VALUES (1832, 1792, '430500', '邵阳市', '2');
INSERT INTO `sys_area` VALUES (1833, 1832, '430502', '双清区', '3');
INSERT INTO `sys_area` VALUES (1834, 1832, '430503', '大祥区', '3');
INSERT INTO `sys_area` VALUES (1835, 1832, '430511', '北塔区', '3');
INSERT INTO `sys_area` VALUES (1836, 1832, '430521', '邵东县', '3');
INSERT INTO `sys_area` VALUES (1837, 1832, '430522', '新邵县', '3');
INSERT INTO `sys_area` VALUES (1838, 1832, '430523', '邵阳县', '3');
INSERT INTO `sys_area` VALUES (1839, 1832, '430524', '隆回县', '3');
INSERT INTO `sys_area` VALUES (1840, 1832, '430525', '洞口县', '3');
INSERT INTO `sys_area` VALUES (1841, 1832, '430527', '绥宁县', '3');
INSERT INTO `sys_area` VALUES (1842, 1832, '430528', '新宁县', '3');
INSERT INTO `sys_area` VALUES (1843, 1832, '430529', '城步苗族自治县', '3');
INSERT INTO `sys_area` VALUES (1844, 1832, '430581', '武冈市', '3');
INSERT INTO `sys_area` VALUES (1845, 1792, '430600', '岳阳市', '2');
INSERT INTO `sys_area` VALUES (1846, 1845, '430602', '岳阳楼区', '3');
INSERT INTO `sys_area` VALUES (1847, 1845, '430603', '云溪区', '3');
INSERT INTO `sys_area` VALUES (1848, 1845, '430611', '君山区', '3');
INSERT INTO `sys_area` VALUES (1849, 1845, '430621', '岳阳县', '3');
INSERT INTO `sys_area` VALUES (1850, 1845, '430623', '华容县', '3');
INSERT INTO `sys_area` VALUES (1851, 1845, '430624', '湘阴县', '3');
INSERT INTO `sys_area` VALUES (1852, 1845, '430626', '平江县', '3');
INSERT INTO `sys_area` VALUES (1853, 1845, '430681', '汨罗市', '3');
INSERT INTO `sys_area` VALUES (1854, 1845, '430682', '临湘市', '3');
INSERT INTO `sys_area` VALUES (1855, 1792, '430700', '常德市', '2');
INSERT INTO `sys_area` VALUES (1856, 1855, '430702', '武陵区', '3');
INSERT INTO `sys_area` VALUES (1857, 1855, '430703', '鼎城区', '3');
INSERT INTO `sys_area` VALUES (1858, 1855, '430721', '安乡县', '3');
INSERT INTO `sys_area` VALUES (1859, 1855, '430722', '汉寿县', '3');
INSERT INTO `sys_area` VALUES (1860, 1855, '430723', '澧县', '3');
INSERT INTO `sys_area` VALUES (1861, 1855, '430724', '临澧县', '3');
INSERT INTO `sys_area` VALUES (1862, 1855, '430725', '桃源县', '3');
INSERT INTO `sys_area` VALUES (1863, 1855, '430726', '石门县', '3');
INSERT INTO `sys_area` VALUES (1864, 1855, '430781', '津市市', '3');
INSERT INTO `sys_area` VALUES (1865, 1792, '430800', '张家界市', '2');
INSERT INTO `sys_area` VALUES (1866, 1865, '430802', '永定区', '3');
INSERT INTO `sys_area` VALUES (1867, 1865, '430811', '武陵源区', '3');
INSERT INTO `sys_area` VALUES (1868, 1865, '430821', '慈利县', '3');
INSERT INTO `sys_area` VALUES (1869, 1865, '430822', '桑植县', '3');
INSERT INTO `sys_area` VALUES (1870, 1792, '430900', '益阳市', '2');
INSERT INTO `sys_area` VALUES (1871, 1870, '430902', '资阳区', '3');
INSERT INTO `sys_area` VALUES (1872, 1870, '430903', '赫山区', '3');
INSERT INTO `sys_area` VALUES (1873, 1870, '430921', '南县', '3');
INSERT INTO `sys_area` VALUES (1874, 1870, '430922', '桃江县', '3');
INSERT INTO `sys_area` VALUES (1875, 1870, '430923', '安化县', '3');
INSERT INTO `sys_area` VALUES (1876, 1870, '430981', '沅江市', '3');
INSERT INTO `sys_area` VALUES (1877, 1792, '431000', '郴州市', '2');
INSERT INTO `sys_area` VALUES (1878, 1877, '431002', '北湖区', '3');
INSERT INTO `sys_area` VALUES (1879, 1877, '431003', '苏仙区', '3');
INSERT INTO `sys_area` VALUES (1880, 1877, '431021', '桂阳县', '3');
INSERT INTO `sys_area` VALUES (1881, 1877, '431022', '宜章县', '3');
INSERT INTO `sys_area` VALUES (1882, 1877, '431023', '永兴县', '3');
INSERT INTO `sys_area` VALUES (1883, 1877, '431024', '嘉禾县', '3');
INSERT INTO `sys_area` VALUES (1884, 1877, '431025', '临武县', '3');
INSERT INTO `sys_area` VALUES (1885, 1877, '431026', '汝城县', '3');
INSERT INTO `sys_area` VALUES (1886, 1877, '431027', '桂东县', '3');
INSERT INTO `sys_area` VALUES (1887, 1877, '431028', '安仁县', '3');
INSERT INTO `sys_area` VALUES (1888, 1877, '431081', '资兴市', '3');
INSERT INTO `sys_area` VALUES (1889, 1792, '431100', '永州市', '2');
INSERT INTO `sys_area` VALUES (1890, 1889, '431102', '零陵区', '3');
INSERT INTO `sys_area` VALUES (1891, 1889, '431103', '冷水滩区', '3');
INSERT INTO `sys_area` VALUES (1892, 1889, '431121', '祁阳县', '3');
INSERT INTO `sys_area` VALUES (1893, 1889, '431122', '东安县', '3');
INSERT INTO `sys_area` VALUES (1894, 1889, '431123', '双牌县', '3');
INSERT INTO `sys_area` VALUES (1895, 1889, '431124', '道县', '3');
INSERT INTO `sys_area` VALUES (1896, 1889, '431125', '江永县', '3');
INSERT INTO `sys_area` VALUES (1897, 1889, '431126', '宁远县', '3');
INSERT INTO `sys_area` VALUES (1898, 1889, '431127', '蓝山县', '3');
INSERT INTO `sys_area` VALUES (1899, 1889, '431128', '新田县', '3');
INSERT INTO `sys_area` VALUES (1900, 1889, '431129', '江华瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (1901, 1792, '431200', '怀化市', '2');
INSERT INTO `sys_area` VALUES (1902, 1901, '431202', '鹤城区', '3');
INSERT INTO `sys_area` VALUES (1903, 1901, '431221', '中方县', '3');
INSERT INTO `sys_area` VALUES (1904, 1901, '431222', '沅陵县', '3');
INSERT INTO `sys_area` VALUES (1905, 1901, '431223', '辰溪县', '3');
INSERT INTO `sys_area` VALUES (1906, 1901, '431224', '溆浦县', '3');
INSERT INTO `sys_area` VALUES (1907, 1901, '431225', '会同县', '3');
INSERT INTO `sys_area` VALUES (1908, 1901, '431226', '麻阳苗族自治县', '3');
INSERT INTO `sys_area` VALUES (1909, 1901, '431227', '新晃侗族自治县', '3');
INSERT INTO `sys_area` VALUES (1910, 1901, '431228', '芷江侗族自治县', '3');
INSERT INTO `sys_area` VALUES (1911, 1901, '431229', '靖州苗族侗族自治县', '3');
INSERT INTO `sys_area` VALUES (1912, 1901, '431230', '通道侗族自治县', '3');
INSERT INTO `sys_area` VALUES (1913, 1901, '431281', '洪江市', '3');
INSERT INTO `sys_area` VALUES (1914, 1792, '431300', '娄底市', '2');
INSERT INTO `sys_area` VALUES (1915, 1914, '431302', '娄星区', '3');
INSERT INTO `sys_area` VALUES (1916, 1914, '431321', '双峰县', '3');
INSERT INTO `sys_area` VALUES (1917, 1914, '431322', '新化县', '3');
INSERT INTO `sys_area` VALUES (1918, 1914, '431381', '冷水江市', '3');
INSERT INTO `sys_area` VALUES (1919, 1914, '431382', '涟源市', '3');
INSERT INTO `sys_area` VALUES (1920, 1792, '433100', '湘西土家族苗族自治州', '2');
INSERT INTO `sys_area` VALUES (1921, 1920, '433101', '吉首市', '3');
INSERT INTO `sys_area` VALUES (1922, 1920, '433122', '泸溪县', '3');
INSERT INTO `sys_area` VALUES (1923, 1920, '433123', '凤凰县', '3');
INSERT INTO `sys_area` VALUES (1924, 1920, '433124', '花垣县', '3');
INSERT INTO `sys_area` VALUES (1925, 1920, '433125', '保靖县', '3');
INSERT INTO `sys_area` VALUES (1926, 1920, '433126', '古丈县', '3');
INSERT INTO `sys_area` VALUES (1927, 1920, '433127', '永顺县', '3');
INSERT INTO `sys_area` VALUES (1928, 1920, '433130', '龙山县', '3');
INSERT INTO `sys_area` VALUES (1929, -1, '440000', '广东省', '1');
INSERT INTO `sys_area` VALUES (1930, 1929, '440100', '广州市', '2');
INSERT INTO `sys_area` VALUES (1931, 1930, '440103', '荔湾区', '3');
INSERT INTO `sys_area` VALUES (1932, 1930, '440104', '越秀区', '3');
INSERT INTO `sys_area` VALUES (1933, 1930, '440105', '海珠区', '3');
INSERT INTO `sys_area` VALUES (1934, 1930, '440106', '天河区', '3');
INSERT INTO `sys_area` VALUES (1935, 1930, '440111', '白云区', '3');
INSERT INTO `sys_area` VALUES (1936, 1930, '440112', '黄埔区', '3');
INSERT INTO `sys_area` VALUES (1937, 1930, '440113', '番禺区', '3');
INSERT INTO `sys_area` VALUES (1938, 1930, '440114', '花都区', '3');
INSERT INTO `sys_area` VALUES (1939, 1930, '440115', '南沙区', '3');
INSERT INTO `sys_area` VALUES (1940, 1930, '440117', '从化区', '3');
INSERT INTO `sys_area` VALUES (1941, 1930, '440118', '增城区', '3');
INSERT INTO `sys_area` VALUES (1942, 1929, '440200', '韶关市', '2');
INSERT INTO `sys_area` VALUES (1943, 1942, '440203', '武江区', '3');
INSERT INTO `sys_area` VALUES (1944, 1942, '440204', '浈江区', '3');
INSERT INTO `sys_area` VALUES (1945, 1942, '440205', '曲江区', '3');
INSERT INTO `sys_area` VALUES (1946, 1942, '440222', '始兴县', '3');
INSERT INTO `sys_area` VALUES (1947, 1942, '440224', '仁化县', '3');
INSERT INTO `sys_area` VALUES (1948, 1942, '440229', '翁源县', '3');
INSERT INTO `sys_area` VALUES (1949, 1942, '440232', '乳源瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (1950, 1942, '440233', '新丰县', '3');
INSERT INTO `sys_area` VALUES (1951, 1942, '440281', '乐昌市', '3');
INSERT INTO `sys_area` VALUES (1952, 1942, '440282', '南雄市', '3');
INSERT INTO `sys_area` VALUES (1953, 1929, '440300', '深圳市', '2');
INSERT INTO `sys_area` VALUES (1954, 1953, '440303', '罗湖区', '3');
INSERT INTO `sys_area` VALUES (1955, 1953, '440304', '福田区', '3');
INSERT INTO `sys_area` VALUES (1956, 1953, '440305', '南山区', '3');
INSERT INTO `sys_area` VALUES (1957, 1953, '440306', '宝安区', '3');
INSERT INTO `sys_area` VALUES (1958, 1953, '440307', '龙岗区', '3');
INSERT INTO `sys_area` VALUES (1959, 1953, '440308', '盐田区', '3');
INSERT INTO `sys_area` VALUES (1960, 1953, '440309', '龙华区', '3');
INSERT INTO `sys_area` VALUES (1961, 1953, '440310', '坪山区', '3');
INSERT INTO `sys_area` VALUES (1962, 1953, '440311', '光明区', '3');
INSERT INTO `sys_area` VALUES (1963, 1929, '440400', '珠海市', '2');
INSERT INTO `sys_area` VALUES (1964, 1963, '440402', '香洲区', '3');
INSERT INTO `sys_area` VALUES (1965, 1963, '440403', '斗门区', '3');
INSERT INTO `sys_area` VALUES (1966, 1963, '440404', '金湾区', '3');
INSERT INTO `sys_area` VALUES (1967, 1929, '440500', '汕头市', '2');
INSERT INTO `sys_area` VALUES (1968, 1967, '440507', '龙湖区', '3');
INSERT INTO `sys_area` VALUES (1969, 1967, '440511', '金平区', '3');
INSERT INTO `sys_area` VALUES (1970, 1967, '440512', '濠江区', '3');
INSERT INTO `sys_area` VALUES (1971, 1967, '440513', '潮阳区', '3');
INSERT INTO `sys_area` VALUES (1972, 1967, '440514', '潮南区', '3');
INSERT INTO `sys_area` VALUES (1973, 1967, '440515', '澄海区', '3');
INSERT INTO `sys_area` VALUES (1974, 1967, '440523', '南澳县', '3');
INSERT INTO `sys_area` VALUES (1975, 1929, '440600', '佛山市', '2');
INSERT INTO `sys_area` VALUES (1976, 1975, '440604', '禅城区', '3');
INSERT INTO `sys_area` VALUES (1977, 1975, '440605', '南海区', '3');
INSERT INTO `sys_area` VALUES (1978, 1975, '440606', '顺德区', '3');
INSERT INTO `sys_area` VALUES (1979, 1975, '440607', '三水区', '3');
INSERT INTO `sys_area` VALUES (1980, 1975, '440608', '高明区', '3');
INSERT INTO `sys_area` VALUES (1981, 1929, '440700', '江门市', '2');
INSERT INTO `sys_area` VALUES (1982, 1981, '440703', '蓬江区', '3');
INSERT INTO `sys_area` VALUES (1983, 1981, '440704', '江海区', '3');
INSERT INTO `sys_area` VALUES (1984, 1981, '440705', '新会区', '3');
INSERT INTO `sys_area` VALUES (1985, 1981, '440781', '台山市', '3');
INSERT INTO `sys_area` VALUES (1986, 1981, '440783', '开平市', '3');
INSERT INTO `sys_area` VALUES (1987, 1981, '440784', '鹤山市', '3');
INSERT INTO `sys_area` VALUES (1988, 1981, '440785', '恩平市', '3');
INSERT INTO `sys_area` VALUES (1989, 1929, '440800', '湛江市', '2');
INSERT INTO `sys_area` VALUES (1990, 1989, '440802', '赤坎区', '3');
INSERT INTO `sys_area` VALUES (1991, 1989, '440803', '霞山区', '3');
INSERT INTO `sys_area` VALUES (1992, 1989, '440804', '坡头区', '3');
INSERT INTO `sys_area` VALUES (1993, 1989, '440811', '麻章区', '3');
INSERT INTO `sys_area` VALUES (1994, 1989, '440823', '遂溪县', '3');
INSERT INTO `sys_area` VALUES (1995, 1989, '440825', '徐闻县', '3');
INSERT INTO `sys_area` VALUES (1996, 1989, '440881', '廉江市', '3');
INSERT INTO `sys_area` VALUES (1997, 1989, '440882', '雷州市', '3');
INSERT INTO `sys_area` VALUES (1998, 1989, '440883', '吴川市', '3');
INSERT INTO `sys_area` VALUES (1999, 1929, '440900', '茂名市', '2');
INSERT INTO `sys_area` VALUES (2000, 1999, '440902', '茂南区', '3');
INSERT INTO `sys_area` VALUES (2001, 1999, '440904', '电白区', '3');
INSERT INTO `sys_area` VALUES (2002, 1999, '440981', '高州市', '3');
INSERT INTO `sys_area` VALUES (2003, 1999, '440982', '化州市', '3');
INSERT INTO `sys_area` VALUES (2004, 1999, '440983', '信宜市', '3');
INSERT INTO `sys_area` VALUES (2005, 1929, '441200', '肇庆市', '2');
INSERT INTO `sys_area` VALUES (2006, 2005, '441202', '端州区', '3');
INSERT INTO `sys_area` VALUES (2007, 2005, '441203', '鼎湖区', '3');
INSERT INTO `sys_area` VALUES (2008, 2005, '441204', '高要区', '3');
INSERT INTO `sys_area` VALUES (2009, 2005, '441223', '广宁县', '3');
INSERT INTO `sys_area` VALUES (2010, 2005, '441224', '怀集县', '3');
INSERT INTO `sys_area` VALUES (2011, 2005, '441225', '封开县', '3');
INSERT INTO `sys_area` VALUES (2012, 2005, '441226', '德庆县', '3');
INSERT INTO `sys_area` VALUES (2013, 2005, '441284', '四会市', '3');
INSERT INTO `sys_area` VALUES (2014, 1929, '441300', '惠州市', '2');
INSERT INTO `sys_area` VALUES (2015, 2014, '441302', '惠城区', '3');
INSERT INTO `sys_area` VALUES (2016, 2014, '441303', '惠阳区', '3');
INSERT INTO `sys_area` VALUES (2017, 2014, '441322', '博罗县', '3');
INSERT INTO `sys_area` VALUES (2018, 2014, '441323', '惠东县', '3');
INSERT INTO `sys_area` VALUES (2019, 2014, '441324', '龙门县', '3');
INSERT INTO `sys_area` VALUES (2020, 1929, '441400', '梅州市', '2');
INSERT INTO `sys_area` VALUES (2021, 2020, '441402', '梅江区', '3');
INSERT INTO `sys_area` VALUES (2022, 2020, '441403', '梅县区', '3');
INSERT INTO `sys_area` VALUES (2023, 2020, '441422', '大埔县', '3');
INSERT INTO `sys_area` VALUES (2024, 2020, '441423', '丰顺县', '3');
INSERT INTO `sys_area` VALUES (2025, 2020, '441424', '五华县', '3');
INSERT INTO `sys_area` VALUES (2026, 2020, '441426', '平远县', '3');
INSERT INTO `sys_area` VALUES (2027, 2020, '441427', '蕉岭县', '3');
INSERT INTO `sys_area` VALUES (2028, 2020, '441481', '兴宁市', '3');
INSERT INTO `sys_area` VALUES (2029, 1929, '441500', '汕尾市', '2');
INSERT INTO `sys_area` VALUES (2030, 2029, '441502', '城区', '3');
INSERT INTO `sys_area` VALUES (2031, 2029, '441521', '海丰县', '3');
INSERT INTO `sys_area` VALUES (2032, 2029, '441523', '陆河县', '3');
INSERT INTO `sys_area` VALUES (2033, 2029, '441581', '陆丰市', '3');
INSERT INTO `sys_area` VALUES (2034, 1929, '441600', '河源市', '2');
INSERT INTO `sys_area` VALUES (2035, 2034, '441602', '源城区', '3');
INSERT INTO `sys_area` VALUES (2036, 2034, '441621', '紫金县', '3');
INSERT INTO `sys_area` VALUES (2037, 2034, '441622', '龙川县', '3');
INSERT INTO `sys_area` VALUES (2038, 2034, '441623', '连平县', '3');
INSERT INTO `sys_area` VALUES (2039, 2034, '441624', '和平县', '3');
INSERT INTO `sys_area` VALUES (2040, 2034, '441625', '东源县', '3');
INSERT INTO `sys_area` VALUES (2041, 1929, '441700', '阳江市', '2');
INSERT INTO `sys_area` VALUES (2042, 2041, '441702', '江城区', '3');
INSERT INTO `sys_area` VALUES (2043, 2041, '441704', '阳东区', '3');
INSERT INTO `sys_area` VALUES (2044, 2041, '441721', '阳西县', '3');
INSERT INTO `sys_area` VALUES (2045, 2041, '441781', '阳春市', '3');
INSERT INTO `sys_area` VALUES (2046, 1929, '441800', '清远市', '2');
INSERT INTO `sys_area` VALUES (2047, 2046, '441802', '清城区', '3');
INSERT INTO `sys_area` VALUES (2048, 2046, '441803', '清新区', '3');
INSERT INTO `sys_area` VALUES (2049, 2046, '441821', '佛冈县', '3');
INSERT INTO `sys_area` VALUES (2050, 2046, '441823', '阳山县', '3');
INSERT INTO `sys_area` VALUES (2051, 2046, '441825', '连山壮族瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (2052, 2046, '441826', '连南瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (2053, 2046, '441881', '英德市', '3');
INSERT INTO `sys_area` VALUES (2054, 2046, '441882', '连州市', '3');
INSERT INTO `sys_area` VALUES (2055, 1929, '441900', '东莞市', '2');
INSERT INTO `sys_area` VALUES (2056, 1929, '442000', '中山市', '2');
INSERT INTO `sys_area` VALUES (2057, 1929, '445100', '潮州市', '2');
INSERT INTO `sys_area` VALUES (2058, 2057, '445102', '湘桥区', '3');
INSERT INTO `sys_area` VALUES (2059, 2057, '445103', '潮安区', '3');
INSERT INTO `sys_area` VALUES (2060, 2057, '445122', '饶平县', '3');
INSERT INTO `sys_area` VALUES (2061, 1929, '445200', '揭阳市', '2');
INSERT INTO `sys_area` VALUES (2062, 2061, '445202', '榕城区', '3');
INSERT INTO `sys_area` VALUES (2063, 2061, '445203', '揭东区', '3');
INSERT INTO `sys_area` VALUES (2064, 2061, '445222', '揭西县', '3');
INSERT INTO `sys_area` VALUES (2065, 2061, '445224', '惠来县', '3');
INSERT INTO `sys_area` VALUES (2066, 2061, '445281', '普宁市', '3');
INSERT INTO `sys_area` VALUES (2067, 1929, '445300', '云浮市', '2');
INSERT INTO `sys_area` VALUES (2068, 2067, '445302', '云城区', '3');
INSERT INTO `sys_area` VALUES (2069, 2067, '445303', '云安区', '3');
INSERT INTO `sys_area` VALUES (2070, 2067, '445321', '新兴县', '3');
INSERT INTO `sys_area` VALUES (2071, 2067, '445322', '郁南县', '3');
INSERT INTO `sys_area` VALUES (2072, 2067, '445381', '罗定市', '3');
INSERT INTO `sys_area` VALUES (2073, -1, '450000', '广西壮族自治区', '1');
INSERT INTO `sys_area` VALUES (2074, 2073, '450100', '南宁市', '2');
INSERT INTO `sys_area` VALUES (2075, 2074, '450102', '兴宁区', '3');
INSERT INTO `sys_area` VALUES (2076, 2074, '450103', '青秀区', '3');
INSERT INTO `sys_area` VALUES (2077, 2074, '450105', '江南区', '3');
INSERT INTO `sys_area` VALUES (2078, 2074, '450107', '西乡塘区', '3');
INSERT INTO `sys_area` VALUES (2079, 2074, '450108', '良庆区', '3');
INSERT INTO `sys_area` VALUES (2080, 2074, '450109', '邕宁区', '3');
INSERT INTO `sys_area` VALUES (2081, 2074, '450110', '武鸣区', '3');
INSERT INTO `sys_area` VALUES (2082, 2074, '450123', '隆安县', '3');
INSERT INTO `sys_area` VALUES (2083, 2074, '450124', '马山县', '3');
INSERT INTO `sys_area` VALUES (2084, 2074, '450125', '上林县', '3');
INSERT INTO `sys_area` VALUES (2085, 2074, '450126', '宾阳县', '3');
INSERT INTO `sys_area` VALUES (2086, 2074, '450127', '横县', '3');
INSERT INTO `sys_area` VALUES (2087, 2073, '450200', '柳州市', '2');
INSERT INTO `sys_area` VALUES (2088, 2087, '450202', '城中区', '3');
INSERT INTO `sys_area` VALUES (2089, 2087, '450203', '鱼峰区', '3');
INSERT INTO `sys_area` VALUES (2090, 2087, '450204', '柳南区', '3');
INSERT INTO `sys_area` VALUES (2091, 2087, '450205', '柳北区', '3');
INSERT INTO `sys_area` VALUES (2092, 2087, '450206', '柳江区', '3');
INSERT INTO `sys_area` VALUES (2093, 2087, '450222', '柳城县', '3');
INSERT INTO `sys_area` VALUES (2094, 2087, '450223', '鹿寨县', '3');
INSERT INTO `sys_area` VALUES (2095, 2087, '450224', '融安县', '3');
INSERT INTO `sys_area` VALUES (2096, 2087, '450225', '融水苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2097, 2087, '450226', '三江侗族自治县', '3');
INSERT INTO `sys_area` VALUES (2098, 2073, '450300', '桂林市', '2');
INSERT INTO `sys_area` VALUES (2099, 2098, '450302', '秀峰区', '3');
INSERT INTO `sys_area` VALUES (2100, 2098, '450303', '叠彩区', '3');
INSERT INTO `sys_area` VALUES (2101, 2098, '450304', '象山区', '3');
INSERT INTO `sys_area` VALUES (2102, 2098, '450305', '七星区', '3');
INSERT INTO `sys_area` VALUES (2103, 2098, '450311', '雁山区', '3');
INSERT INTO `sys_area` VALUES (2104, 2098, '450312', '临桂区', '3');
INSERT INTO `sys_area` VALUES (2105, 2098, '450321', '阳朔县', '3');
INSERT INTO `sys_area` VALUES (2106, 2098, '450323', '灵川县', '3');
INSERT INTO `sys_area` VALUES (2107, 2098, '450324', '全州县', '3');
INSERT INTO `sys_area` VALUES (2108, 2098, '450325', '兴安县', '3');
INSERT INTO `sys_area` VALUES (2109, 2098, '450326', '永福县', '3');
INSERT INTO `sys_area` VALUES (2110, 2098, '450327', '灌阳县', '3');
INSERT INTO `sys_area` VALUES (2111, 2098, '450328', '龙胜各族自治县', '3');
INSERT INTO `sys_area` VALUES (2112, 2098, '450329', '资源县', '3');
INSERT INTO `sys_area` VALUES (2113, 2098, '450330', '平乐县', '3');
INSERT INTO `sys_area` VALUES (2114, 2098, '450381', '荔浦市', '3');
INSERT INTO `sys_area` VALUES (2115, 2098, '450332', '恭城瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (2116, 2073, '450400', '梧州市', '2');
INSERT INTO `sys_area` VALUES (2117, 2116, '450403', '万秀区', '3');
INSERT INTO `sys_area` VALUES (2118, 2116, '450405', '长洲区', '3');
INSERT INTO `sys_area` VALUES (2119, 2116, '450406', '龙圩区', '3');
INSERT INTO `sys_area` VALUES (2120, 2116, '450421', '苍梧县', '3');
INSERT INTO `sys_area` VALUES (2121, 2116, '450422', '藤县', '3');
INSERT INTO `sys_area` VALUES (2122, 2116, '450423', '蒙山县', '3');
INSERT INTO `sys_area` VALUES (2123, 2116, '450481', '岑溪市', '3');
INSERT INTO `sys_area` VALUES (2124, 2073, '450500', '北海市', '2');
INSERT INTO `sys_area` VALUES (2125, 2124, '450502', '海城区', '3');
INSERT INTO `sys_area` VALUES (2126, 2124, '450503', '银海区', '3');
INSERT INTO `sys_area` VALUES (2127, 2124, '450512', '铁山港区', '3');
INSERT INTO `sys_area` VALUES (2128, 2124, '450521', '合浦县', '3');
INSERT INTO `sys_area` VALUES (2129, 2073, '450600', '防城港市', '2');
INSERT INTO `sys_area` VALUES (2130, 2129, '450602', '港口区', '3');
INSERT INTO `sys_area` VALUES (2131, 2129, '450603', '防城区', '3');
INSERT INTO `sys_area` VALUES (2132, 2129, '450621', '上思县', '3');
INSERT INTO `sys_area` VALUES (2133, 2129, '450681', '东兴市', '3');
INSERT INTO `sys_area` VALUES (2134, 2073, '450700', '钦州市', '2');
INSERT INTO `sys_area` VALUES (2135, 2134, '450702', '钦南区', '3');
INSERT INTO `sys_area` VALUES (2136, 2134, '450703', '钦北区', '3');
INSERT INTO `sys_area` VALUES (2137, 2134, '450721', '灵山县', '3');
INSERT INTO `sys_area` VALUES (2138, 2134, '450722', '浦北县', '3');
INSERT INTO `sys_area` VALUES (2139, 2073, '450800', '贵港市', '2');
INSERT INTO `sys_area` VALUES (2140, 2139, '450802', '港北区', '3');
INSERT INTO `sys_area` VALUES (2141, 2139, '450803', '港南区', '3');
INSERT INTO `sys_area` VALUES (2142, 2139, '450804', '覃塘区', '3');
INSERT INTO `sys_area` VALUES (2143, 2139, '450821', '平南县', '3');
INSERT INTO `sys_area` VALUES (2144, 2139, '450881', '桂平市', '3');
INSERT INTO `sys_area` VALUES (2145, 2073, '450900', '玉林市', '2');
INSERT INTO `sys_area` VALUES (2146, 2145, '450902', '玉州区', '3');
INSERT INTO `sys_area` VALUES (2147, 2145, '450903', '福绵区', '3');
INSERT INTO `sys_area` VALUES (2148, 2145, '450921', '容县', '3');
INSERT INTO `sys_area` VALUES (2149, 2145, '450922', '陆川县', '3');
INSERT INTO `sys_area` VALUES (2150, 2145, '450923', '博白县', '3');
INSERT INTO `sys_area` VALUES (2151, 2145, '450924', '兴业县', '3');
INSERT INTO `sys_area` VALUES (2152, 2145, '450981', '北流市', '3');
INSERT INTO `sys_area` VALUES (2153, 2073, '451000', '百色市', '2');
INSERT INTO `sys_area` VALUES (2154, 2153, '451002', '右江区', '3');
INSERT INTO `sys_area` VALUES (2155, 2153, '451021', '田阳县', '3');
INSERT INTO `sys_area` VALUES (2156, 2153, '451022', '田东县', '3');
INSERT INTO `sys_area` VALUES (2157, 2153, '451023', '平果县', '3');
INSERT INTO `sys_area` VALUES (2158, 2153, '451024', '德保县', '3');
INSERT INTO `sys_area` VALUES (2159, 2153, '451026', '那坡县', '3');
INSERT INTO `sys_area` VALUES (2160, 2153, '451027', '凌云县', '3');
INSERT INTO `sys_area` VALUES (2161, 2153, '451028', '乐业县', '3');
INSERT INTO `sys_area` VALUES (2162, 2153, '451029', '田林县', '3');
INSERT INTO `sys_area` VALUES (2163, 2153, '451030', '西林县', '3');
INSERT INTO `sys_area` VALUES (2164, 2153, '451031', '隆林各族自治县', '3');
INSERT INTO `sys_area` VALUES (2165, 2153, '451081', '靖西市', '3');
INSERT INTO `sys_area` VALUES (2166, 2073, '451100', '贺州市', '2');
INSERT INTO `sys_area` VALUES (2167, 2166, '451102', '八步区', '3');
INSERT INTO `sys_area` VALUES (2168, 2166, '451103', '平桂区', '3');
INSERT INTO `sys_area` VALUES (2169, 2166, '451121', '昭平县', '3');
INSERT INTO `sys_area` VALUES (2170, 2166, '451122', '钟山县', '3');
INSERT INTO `sys_area` VALUES (2171, 2166, '451123', '富川瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (2172, 2073, '451200', '河池市', '2');
INSERT INTO `sys_area` VALUES (2173, 2172, '451202', '金城江区', '3');
INSERT INTO `sys_area` VALUES (2174, 2172, '451203', '宜州区', '3');
INSERT INTO `sys_area` VALUES (2175, 2172, '451221', '南丹县', '3');
INSERT INTO `sys_area` VALUES (2176, 2172, '451222', '天峨县', '3');
INSERT INTO `sys_area` VALUES (2177, 2172, '451223', '凤山县', '3');
INSERT INTO `sys_area` VALUES (2178, 2172, '451224', '东兰县', '3');
INSERT INTO `sys_area` VALUES (2179, 2172, '451225', '罗城仫佬族自治县', '3');
INSERT INTO `sys_area` VALUES (2180, 2172, '451226', '环江毛南族自治县', '3');
INSERT INTO `sys_area` VALUES (2181, 2172, '451227', '巴马瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (2182, 2172, '451228', '都安瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (2183, 2172, '451229', '大化瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (2184, 2073, '451300', '来宾市', '2');
INSERT INTO `sys_area` VALUES (2185, 2184, '451302', '兴宾区', '3');
INSERT INTO `sys_area` VALUES (2186, 2184, '451321', '忻城县', '3');
INSERT INTO `sys_area` VALUES (2187, 2184, '451322', '象州县', '3');
INSERT INTO `sys_area` VALUES (2188, 2184, '451323', '武宣县', '3');
INSERT INTO `sys_area` VALUES (2189, 2184, '451324', '金秀瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (2190, 2184, '451381', '合山市', '3');
INSERT INTO `sys_area` VALUES (2191, 2073, '451400', '崇左市', '2');
INSERT INTO `sys_area` VALUES (2192, 2191, '451402', '江州区', '3');
INSERT INTO `sys_area` VALUES (2193, 2191, '451421', '扶绥县', '3');
INSERT INTO `sys_area` VALUES (2194, 2191, '451422', '宁明县', '3');
INSERT INTO `sys_area` VALUES (2195, 2191, '451423', '龙州县', '3');
INSERT INTO `sys_area` VALUES (2196, 2191, '451424', '大新县', '3');
INSERT INTO `sys_area` VALUES (2197, 2191, '451425', '天等县', '3');
INSERT INTO `sys_area` VALUES (2198, 2191, '451481', '凭祥市', '3');
INSERT INTO `sys_area` VALUES (2199, -1, '460000', '海南省', '1');
INSERT INTO `sys_area` VALUES (2200, 2199, '460100', '海口市', '2');
INSERT INTO `sys_area` VALUES (2201, 2200, '460105', '秀英区', '3');
INSERT INTO `sys_area` VALUES (2202, 2200, '460106', '龙华区', '3');
INSERT INTO `sys_area` VALUES (2203, 2200, '460107', '琼山区', '3');
INSERT INTO `sys_area` VALUES (2204, 2200, '460108', '美兰区', '3');
INSERT INTO `sys_area` VALUES (2205, 2199, '460200', '三亚市', '2');
INSERT INTO `sys_area` VALUES (2206, 2205, '460202', '海棠区', '3');
INSERT INTO `sys_area` VALUES (2207, 2205, '460203', '吉阳区', '3');
INSERT INTO `sys_area` VALUES (2208, 2205, '460204', '天涯区', '3');
INSERT INTO `sys_area` VALUES (2209, 2205, '460205', '崖州区', '3');
INSERT INTO `sys_area` VALUES (2210, 2199, '460300', '三沙市', '2');
INSERT INTO `sys_area` VALUES (2211, 2199, '460400', '儋州市', '2');
INSERT INTO `sys_area` VALUES (2212, 2199, '469001', '五指山市', '3');
INSERT INTO `sys_area` VALUES (2213, 2199, '469002', '琼海市', '3');
INSERT INTO `sys_area` VALUES (2214, 2199, '469005', '文昌市', '3');
INSERT INTO `sys_area` VALUES (2215, 2199, '469006', '万宁市', '3');
INSERT INTO `sys_area` VALUES (2216, 2199, '469007', '东方市', '3');
INSERT INTO `sys_area` VALUES (2217, 2199, '469021', '定安县', '3');
INSERT INTO `sys_area` VALUES (2218, 2199, '469022', '屯昌县', '3');
INSERT INTO `sys_area` VALUES (2219, 2199, '469023', '澄迈县', '3');
INSERT INTO `sys_area` VALUES (2220, 2199, '469024', '临高县', '3');
INSERT INTO `sys_area` VALUES (2221, 2199, '469025', '白沙黎族自治县', '3');
INSERT INTO `sys_area` VALUES (2222, 2199, '469026', '昌江黎族自治县', '3');
INSERT INTO `sys_area` VALUES (2223, 2199, '469027', '乐东黎族自治县', '3');
INSERT INTO `sys_area` VALUES (2224, 2199, '469028', '陵水黎族自治县', '3');
INSERT INTO `sys_area` VALUES (2225, 2199, '469029', '保亭黎族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2226, 2199, '469030', '琼中黎族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2227, -1, '500000', '重庆市', '1');
INSERT INTO `sys_area` VALUES (2228, 2227, '500101', '万州区', '3');
INSERT INTO `sys_area` VALUES (2229, 2227, '500102', '涪陵区', '3');
INSERT INTO `sys_area` VALUES (2230, 2227, '500103', '渝中区', '3');
INSERT INTO `sys_area` VALUES (2231, 2227, '500104', '大渡口区', '3');
INSERT INTO `sys_area` VALUES (2232, 2227, '500105', '江北区', '3');
INSERT INTO `sys_area` VALUES (2233, 2227, '500106', '沙坪坝区', '3');
INSERT INTO `sys_area` VALUES (2234, 2227, '500107', '九龙坡区', '3');
INSERT INTO `sys_area` VALUES (2235, 2227, '500108', '南岸区', '3');
INSERT INTO `sys_area` VALUES (2236, 2227, '500109', '北碚区', '3');
INSERT INTO `sys_area` VALUES (2237, 2227, '500110', '綦江区', '3');
INSERT INTO `sys_area` VALUES (2238, 2227, '500111', '大足区', '3');
INSERT INTO `sys_area` VALUES (2239, 2227, '500112', '渝北区', '3');
INSERT INTO `sys_area` VALUES (2240, 2227, '500113', '巴南区', '3');
INSERT INTO `sys_area` VALUES (2241, 2227, '500114', '黔江区', '3');
INSERT INTO `sys_area` VALUES (2242, 2227, '500115', '长寿区', '3');
INSERT INTO `sys_area` VALUES (2243, 2227, '500116', '江津区', '3');
INSERT INTO `sys_area` VALUES (2244, 2227, '500117', '合川区', '3');
INSERT INTO `sys_area` VALUES (2245, 2227, '500118', '永川区', '3');
INSERT INTO `sys_area` VALUES (2246, 2227, '500119', '南川区', '3');
INSERT INTO `sys_area` VALUES (2247, 2227, '500120', '璧山区', '3');
INSERT INTO `sys_area` VALUES (2248, 2227, '500151', '铜梁区', '3');
INSERT INTO `sys_area` VALUES (2249, 2227, '500152', '潼南区', '3');
INSERT INTO `sys_area` VALUES (2250, 2227, '500153', '荣昌区', '3');
INSERT INTO `sys_area` VALUES (2251, 2227, '500154', '开州区', '3');
INSERT INTO `sys_area` VALUES (2252, 2227, '500155', '梁平区', '3');
INSERT INTO `sys_area` VALUES (2253, 2227, '500156', '武隆区', '3');
INSERT INTO `sys_area` VALUES (2254, 2227, '500229', '城口县', '3');
INSERT INTO `sys_area` VALUES (2255, 2227, '500230', '丰都县', '3');
INSERT INTO `sys_area` VALUES (2256, 2227, '500231', '垫江县', '3');
INSERT INTO `sys_area` VALUES (2257, 2227, '500233', '忠县', '3');
INSERT INTO `sys_area` VALUES (2258, 2227, '500235', '云阳县', '3');
INSERT INTO `sys_area` VALUES (2259, 2227, '500236', '奉节县', '3');
INSERT INTO `sys_area` VALUES (2260, 2227, '500237', '巫山县', '3');
INSERT INTO `sys_area` VALUES (2261, 2227, '500238', '巫溪县', '3');
INSERT INTO `sys_area` VALUES (2262, 2227, '500240', '石柱土家族自治县', '3');
INSERT INTO `sys_area` VALUES (2263, 2227, '500241', '秀山土家族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2264, 2227, '500242', '酉阳土家族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2265, 2227, '500243', '彭水苗族土家族自治县', '3');
INSERT INTO `sys_area` VALUES (2266, -1, '510000', '四川省', '1');
INSERT INTO `sys_area` VALUES (2267, 2266, '510100', '成都市', '2');
INSERT INTO `sys_area` VALUES (2268, 2267, '510104', '锦江区', '3');
INSERT INTO `sys_area` VALUES (2269, 2267, '510105', '青羊区', '3');
INSERT INTO `sys_area` VALUES (2270, 2267, '510106', '金牛区', '3');
INSERT INTO `sys_area` VALUES (2271, 2267, '510107', '武侯区', '3');
INSERT INTO `sys_area` VALUES (2272, 2267, '510108', '成华区', '3');
INSERT INTO `sys_area` VALUES (2273, 2267, '510112', '龙泉驿区', '3');
INSERT INTO `sys_area` VALUES (2274, 2267, '510113', '青白江区', '3');
INSERT INTO `sys_area` VALUES (2275, 2267, '510114', '新都区', '3');
INSERT INTO `sys_area` VALUES (2276, 2267, '510115', '温江区', '3');
INSERT INTO `sys_area` VALUES (2277, 2267, '510116', '双流区', '3');
INSERT INTO `sys_area` VALUES (2278, 2267, '510117', '郫都区', '3');
INSERT INTO `sys_area` VALUES (2279, 2267, '510121', '金堂县', '3');
INSERT INTO `sys_area` VALUES (2280, 2267, '510129', '大邑县', '3');
INSERT INTO `sys_area` VALUES (2281, 2267, '510131', '蒲江县', '3');
INSERT INTO `sys_area` VALUES (2282, 2267, '510132', '新津县', '3');
INSERT INTO `sys_area` VALUES (2283, 2267, '510181', '都江堰市', '3');
INSERT INTO `sys_area` VALUES (2284, 2267, '510182', '彭州市', '3');
INSERT INTO `sys_area` VALUES (2285, 2267, '510183', '邛崃市', '3');
INSERT INTO `sys_area` VALUES (2286, 2267, '510184', '崇州市', '3');
INSERT INTO `sys_area` VALUES (2287, 2267, '510185', '简阳市', '3');
INSERT INTO `sys_area` VALUES (2288, 2266, '510300', '自贡市', '2');
INSERT INTO `sys_area` VALUES (2289, 2288, '510302', '自流井区', '3');
INSERT INTO `sys_area` VALUES (2290, 2288, '510303', '贡井区', '3');
INSERT INTO `sys_area` VALUES (2291, 2288, '510304', '大安区', '3');
INSERT INTO `sys_area` VALUES (2292, 2288, '510311', '沿滩区', '3');
INSERT INTO `sys_area` VALUES (2293, 2288, '510321', '荣县', '3');
INSERT INTO `sys_area` VALUES (2294, 2288, '510322', '富顺县', '3');
INSERT INTO `sys_area` VALUES (2295, 2266, '510400', '攀枝花市', '2');
INSERT INTO `sys_area` VALUES (2296, 2295, '510402', '东区', '3');
INSERT INTO `sys_area` VALUES (2297, 2295, '510403', '西区', '3');
INSERT INTO `sys_area` VALUES (2298, 2295, '510411', '仁和区', '3');
INSERT INTO `sys_area` VALUES (2299, 2295, '510421', '米易县', '3');
INSERT INTO `sys_area` VALUES (2300, 2295, '510422', '盐边县', '3');
INSERT INTO `sys_area` VALUES (2301, 2266, '510500', '泸州市', '2');
INSERT INTO `sys_area` VALUES (2302, 2301, '510502', '江阳区', '3');
INSERT INTO `sys_area` VALUES (2303, 2301, '510503', '纳溪区', '3');
INSERT INTO `sys_area` VALUES (2304, 2301, '510504', '龙马潭区', '3');
INSERT INTO `sys_area` VALUES (2305, 2301, '510521', '泸县', '3');
INSERT INTO `sys_area` VALUES (2306, 2301, '510522', '合江县', '3');
INSERT INTO `sys_area` VALUES (2307, 2301, '510524', '叙永县', '3');
INSERT INTO `sys_area` VALUES (2308, 2301, '510525', '古蔺县', '3');
INSERT INTO `sys_area` VALUES (2309, 2266, '510600', '德阳市', '2');
INSERT INTO `sys_area` VALUES (2310, 2309, '510603', '旌阳区', '3');
INSERT INTO `sys_area` VALUES (2311, 2309, '510604', '罗江区', '3');
INSERT INTO `sys_area` VALUES (2312, 2309, '510623', '中江县', '3');
INSERT INTO `sys_area` VALUES (2313, 2309, '510681', '广汉市', '3');
INSERT INTO `sys_area` VALUES (2314, 2309, '510682', '什邡市', '3');
INSERT INTO `sys_area` VALUES (2315, 2309, '510683', '绵竹市', '3');
INSERT INTO `sys_area` VALUES (2316, 2266, '510700', '绵阳市', '2');
INSERT INTO `sys_area` VALUES (2317, 2316, '510703', '涪城区', '3');
INSERT INTO `sys_area` VALUES (2318, 2316, '510704', '游仙区', '3');
INSERT INTO `sys_area` VALUES (2319, 2316, '510705', '安州区', '3');
INSERT INTO `sys_area` VALUES (2320, 2316, '510722', '三台县', '3');
INSERT INTO `sys_area` VALUES (2321, 2316, '510723', '盐亭县', '3');
INSERT INTO `sys_area` VALUES (2322, 2316, '510725', '梓潼县', '3');
INSERT INTO `sys_area` VALUES (2323, 2316, '510726', '北川羌族自治县', '3');
INSERT INTO `sys_area` VALUES (2324, 2316, '510727', '平武县', '3');
INSERT INTO `sys_area` VALUES (2325, 2316, '510781', '江油市', '3');
INSERT INTO `sys_area` VALUES (2326, 2266, '510800', '广元市', '2');
INSERT INTO `sys_area` VALUES (2327, 2326, '510802', '利州区', '3');
INSERT INTO `sys_area` VALUES (2328, 2326, '510811', '昭化区', '3');
INSERT INTO `sys_area` VALUES (2329, 2326, '510812', '朝天区', '3');
INSERT INTO `sys_area` VALUES (2330, 2326, '510821', '旺苍县', '3');
INSERT INTO `sys_area` VALUES (2331, 2326, '510822', '青川县', '3');
INSERT INTO `sys_area` VALUES (2332, 2326, '510823', '剑阁县', '3');
INSERT INTO `sys_area` VALUES (2333, 2326, '510824', '苍溪县', '3');
INSERT INTO `sys_area` VALUES (2334, 2266, '510900', '遂宁市', '2');
INSERT INTO `sys_area` VALUES (2335, 2334, '510903', '船山区', '3');
INSERT INTO `sys_area` VALUES (2336, 2334, '510904', '安居区', '3');
INSERT INTO `sys_area` VALUES (2337, 2334, '510921', '蓬溪县', '3');
INSERT INTO `sys_area` VALUES (2338, 2334, '510922', '射洪县', '3');
INSERT INTO `sys_area` VALUES (2339, 2334, '510923', '大英县', '3');
INSERT INTO `sys_area` VALUES (2340, 2266, '511000', '内江市', '2');
INSERT INTO `sys_area` VALUES (2341, 2340, '511002', '市中区', '3');
INSERT INTO `sys_area` VALUES (2342, 2340, '511011', '东兴区', '3');
INSERT INTO `sys_area` VALUES (2343, 2340, '511024', '威远县', '3');
INSERT INTO `sys_area` VALUES (2344, 2340, '511025', '资中县', '3');
INSERT INTO `sys_area` VALUES (2345, 2340, '511083', '隆昌市', '3');
INSERT INTO `sys_area` VALUES (2346, 2266, '511100', '乐山市', '2');
INSERT INTO `sys_area` VALUES (2347, 2346, '511102', '市中区', '3');
INSERT INTO `sys_area` VALUES (2348, 2346, '511111', '沙湾区', '3');
INSERT INTO `sys_area` VALUES (2349, 2346, '511112', '五通桥区', '3');
INSERT INTO `sys_area` VALUES (2350, 2346, '511113', '金口河区', '3');
INSERT INTO `sys_area` VALUES (2351, 2346, '511123', '犍为县', '3');
INSERT INTO `sys_area` VALUES (2352, 2346, '511124', '井研县', '3');
INSERT INTO `sys_area` VALUES (2353, 2346, '511126', '夹江县', '3');
INSERT INTO `sys_area` VALUES (2354, 2346, '511129', '沐川县', '3');
INSERT INTO `sys_area` VALUES (2355, 2346, '511132', '峨边彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2356, 2346, '511133', '马边彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2357, 2346, '511181', '峨眉山市', '3');
INSERT INTO `sys_area` VALUES (2358, 2266, '511300', '南充市', '2');
INSERT INTO `sys_area` VALUES (2359, 2358, '511302', '顺庆区', '3');
INSERT INTO `sys_area` VALUES (2360, 2358, '511303', '高坪区', '3');
INSERT INTO `sys_area` VALUES (2361, 2358, '511304', '嘉陵区', '3');
INSERT INTO `sys_area` VALUES (2362, 2358, '511321', '南部县', '3');
INSERT INTO `sys_area` VALUES (2363, 2358, '511322', '营山县', '3');
INSERT INTO `sys_area` VALUES (2364, 2358, '511323', '蓬安县', '3');
INSERT INTO `sys_area` VALUES (2365, 2358, '511324', '仪陇县', '3');
INSERT INTO `sys_area` VALUES (2366, 2358, '511325', '西充县', '3');
INSERT INTO `sys_area` VALUES (2367, 2358, '511381', '阆中市', '3');
INSERT INTO `sys_area` VALUES (2368, 2266, '511400', '眉山市', '2');
INSERT INTO `sys_area` VALUES (2369, 2368, '511402', '东坡区', '3');
INSERT INTO `sys_area` VALUES (2370, 2368, '511403', '彭山区', '3');
INSERT INTO `sys_area` VALUES (2371, 2368, '511421', '仁寿县', '3');
INSERT INTO `sys_area` VALUES (2372, 2368, '511423', '洪雅县', '3');
INSERT INTO `sys_area` VALUES (2373, 2368, '511424', '丹棱县', '3');
INSERT INTO `sys_area` VALUES (2374, 2368, '511425', '青神县', '3');
INSERT INTO `sys_area` VALUES (2375, 2266, '511500', '宜宾市', '2');
INSERT INTO `sys_area` VALUES (2376, 2375, '511502', '翠屏区', '3');
INSERT INTO `sys_area` VALUES (2377, 2375, '511503', '南溪区', '3');
INSERT INTO `sys_area` VALUES (2378, 2375, '511504', '叙州区', '3');
INSERT INTO `sys_area` VALUES (2379, 2375, '511523', '江安县', '3');
INSERT INTO `sys_area` VALUES (2380, 2375, '511524', '长宁县', '3');
INSERT INTO `sys_area` VALUES (2381, 2375, '511525', '高县', '3');
INSERT INTO `sys_area` VALUES (2382, 2375, '511526', '珙县', '3');
INSERT INTO `sys_area` VALUES (2383, 2375, '511527', '筠连县', '3');
INSERT INTO `sys_area` VALUES (2384, 2375, '511528', '兴文县', '3');
INSERT INTO `sys_area` VALUES (2385, 2375, '511529', '屏山县', '3');
INSERT INTO `sys_area` VALUES (2386, 2266, '511600', '广安市', '2');
INSERT INTO `sys_area` VALUES (2387, 2386, '511602', '广安区', '3');
INSERT INTO `sys_area` VALUES (2388, 2386, '511603', '前锋区', '3');
INSERT INTO `sys_area` VALUES (2389, 2386, '511621', '岳池县', '3');
INSERT INTO `sys_area` VALUES (2390, 2386, '511622', '武胜县', '3');
INSERT INTO `sys_area` VALUES (2391, 2386, '511623', '邻水县', '3');
INSERT INTO `sys_area` VALUES (2392, 2386, '511681', '华蓥市', '3');
INSERT INTO `sys_area` VALUES (2393, 2266, '511700', '达州市', '2');
INSERT INTO `sys_area` VALUES (2394, 2393, '511702', '通川区', '3');
INSERT INTO `sys_area` VALUES (2395, 2393, '511703', '达川区', '3');
INSERT INTO `sys_area` VALUES (2396, 2393, '511722', '宣汉县', '3');
INSERT INTO `sys_area` VALUES (2397, 2393, '511723', '开江县', '3');
INSERT INTO `sys_area` VALUES (2398, 2393, '511724', '大竹县', '3');
INSERT INTO `sys_area` VALUES (2399, 2393, '511725', '渠县', '3');
INSERT INTO `sys_area` VALUES (2400, 2393, '511781', '万源市', '3');
INSERT INTO `sys_area` VALUES (2401, 2266, '511800', '雅安市', '2');
INSERT INTO `sys_area` VALUES (2402, 2401, '511802', '雨城区', '3');
INSERT INTO `sys_area` VALUES (2403, 2401, '511803', '名山区', '3');
INSERT INTO `sys_area` VALUES (2404, 2401, '511822', '荥经县', '3');
INSERT INTO `sys_area` VALUES (2405, 2401, '511823', '汉源县', '3');
INSERT INTO `sys_area` VALUES (2406, 2401, '511824', '石棉县', '3');
INSERT INTO `sys_area` VALUES (2407, 2401, '511825', '天全县', '3');
INSERT INTO `sys_area` VALUES (2408, 2401, '511826', '芦山县', '3');
INSERT INTO `sys_area` VALUES (2409, 2401, '511827', '宝兴县', '3');
INSERT INTO `sys_area` VALUES (2410, 2266, '511900', '巴中市', '2');
INSERT INTO `sys_area` VALUES (2411, 2410, '511902', '巴州区', '3');
INSERT INTO `sys_area` VALUES (2412, 2410, '511903', '恩阳区', '3');
INSERT INTO `sys_area` VALUES (2413, 2410, '511921', '通江县', '3');
INSERT INTO `sys_area` VALUES (2414, 2410, '511922', '南江县', '3');
INSERT INTO `sys_area` VALUES (2415, 2410, '511923', '平昌县', '3');
INSERT INTO `sys_area` VALUES (2416, 2266, '512000', '资阳市', '2');
INSERT INTO `sys_area` VALUES (2417, 2416, '512002', '雁江区', '3');
INSERT INTO `sys_area` VALUES (2418, 2416, '512021', '安岳县', '3');
INSERT INTO `sys_area` VALUES (2419, 2416, '512022', '乐至县', '3');
INSERT INTO `sys_area` VALUES (2420, 2266, '513200', '阿坝藏族羌族自治州', '2');
INSERT INTO `sys_area` VALUES (2421, 2420, '513201', '马尔康市', '3');
INSERT INTO `sys_area` VALUES (2422, 2420, '513221', '汶川县', '3');
INSERT INTO `sys_area` VALUES (2423, 2420, '513222', '理县', '3');
INSERT INTO `sys_area` VALUES (2424, 2420, '513223', '茂县', '3');
INSERT INTO `sys_area` VALUES (2425, 2420, '513224', '松潘县', '3');
INSERT INTO `sys_area` VALUES (2426, 2420, '513225', '九寨沟县', '3');
INSERT INTO `sys_area` VALUES (2427, 2420, '513226', '金川县', '3');
INSERT INTO `sys_area` VALUES (2428, 2420, '513227', '小金县', '3');
INSERT INTO `sys_area` VALUES (2429, 2420, '513228', '黑水县', '3');
INSERT INTO `sys_area` VALUES (2430, 2420, '513230', '壤塘县', '3');
INSERT INTO `sys_area` VALUES (2431, 2420, '513231', '阿坝县', '3');
INSERT INTO `sys_area` VALUES (2432, 2420, '513232', '若尔盖县', '3');
INSERT INTO `sys_area` VALUES (2433, 2420, '513233', '红原县', '3');
INSERT INTO `sys_area` VALUES (2434, 2266, '513300', '甘孜藏族自治州', '2');
INSERT INTO `sys_area` VALUES (2435, 2434, '513301', '康定市', '3');
INSERT INTO `sys_area` VALUES (2436, 2434, '513322', '泸定县', '3');
INSERT INTO `sys_area` VALUES (2437, 2434, '513323', '丹巴县', '3');
INSERT INTO `sys_area` VALUES (2438, 2434, '513324', '九龙县', '3');
INSERT INTO `sys_area` VALUES (2439, 2434, '513325', '雅江县', '3');
INSERT INTO `sys_area` VALUES (2440, 2434, '513326', '道孚县', '3');
INSERT INTO `sys_area` VALUES (2441, 2434, '513327', '炉霍县', '3');
INSERT INTO `sys_area` VALUES (2442, 2434, '513328', '甘孜县', '3');
INSERT INTO `sys_area` VALUES (2443, 2434, '513329', '新龙县', '3');
INSERT INTO `sys_area` VALUES (2444, 2434, '513330', '德格县', '3');
INSERT INTO `sys_area` VALUES (2445, 2434, '513331', '白玉县', '3');
INSERT INTO `sys_area` VALUES (2446, 2434, '513332', '石渠县', '3');
INSERT INTO `sys_area` VALUES (2447, 2434, '513333', '色达县', '3');
INSERT INTO `sys_area` VALUES (2448, 2434, '513334', '理塘县', '3');
INSERT INTO `sys_area` VALUES (2449, 2434, '513335', '巴塘县', '3');
INSERT INTO `sys_area` VALUES (2450, 2434, '513336', '乡城县', '3');
INSERT INTO `sys_area` VALUES (2451, 2434, '513337', '稻城县', '3');
INSERT INTO `sys_area` VALUES (2452, 2434, '513338', '得荣县', '3');
INSERT INTO `sys_area` VALUES (2453, 2266, '513400', '凉山彝族自治州', '2');
INSERT INTO `sys_area` VALUES (2454, 2453, '513401', '西昌市', '3');
INSERT INTO `sys_area` VALUES (2455, 2453, '513422', '木里藏族自治县', '3');
INSERT INTO `sys_area` VALUES (2456, 2453, '513423', '盐源县', '3');
INSERT INTO `sys_area` VALUES (2457, 2453, '513424', '德昌县', '3');
INSERT INTO `sys_area` VALUES (2458, 2453, '513425', '会理县', '3');
INSERT INTO `sys_area` VALUES (2459, 2453, '513426', '会东县', '3');
INSERT INTO `sys_area` VALUES (2460, 2453, '513427', '宁南县', '3');
INSERT INTO `sys_area` VALUES (2461, 2453, '513428', '普格县', '3');
INSERT INTO `sys_area` VALUES (2462, 2453, '513429', '布拖县', '3');
INSERT INTO `sys_area` VALUES (2463, 2453, '513430', '金阳县', '3');
INSERT INTO `sys_area` VALUES (2464, 2453, '513431', '昭觉县', '3');
INSERT INTO `sys_area` VALUES (2465, 2453, '513432', '喜德县', '3');
INSERT INTO `sys_area` VALUES (2466, 2453, '513433', '冕宁县', '3');
INSERT INTO `sys_area` VALUES (2467, 2453, '513434', '越西县', '3');
INSERT INTO `sys_area` VALUES (2468, 2453, '513435', '甘洛县', '3');
INSERT INTO `sys_area` VALUES (2469, 2453, '513436', '美姑县', '3');
INSERT INTO `sys_area` VALUES (2470, 2453, '513437', '雷波县', '3');
INSERT INTO `sys_area` VALUES (2471, -1, '520000', '贵州省', '1');
INSERT INTO `sys_area` VALUES (2472, 2471, '520100', '贵阳市', '2');
INSERT INTO `sys_area` VALUES (2473, 2472, '520102', '南明区', '3');
INSERT INTO `sys_area` VALUES (2474, 2472, '520103', '云岩区', '3');
INSERT INTO `sys_area` VALUES (2475, 2472, '520111', '花溪区', '3');
INSERT INTO `sys_area` VALUES (2476, 2472, '520112', '乌当区', '3');
INSERT INTO `sys_area` VALUES (2477, 2472, '520113', '白云区', '3');
INSERT INTO `sys_area` VALUES (2478, 2472, '520115', '观山湖区', '3');
INSERT INTO `sys_area` VALUES (2479, 2472, '520121', '开阳县', '3');
INSERT INTO `sys_area` VALUES (2480, 2472, '520122', '息烽县', '3');
INSERT INTO `sys_area` VALUES (2481, 2472, '520123', '修文县', '3');
INSERT INTO `sys_area` VALUES (2482, 2472, '520181', '清镇市', '3');
INSERT INTO `sys_area` VALUES (2483, 2471, '520200', '六盘水市', '2');
INSERT INTO `sys_area` VALUES (2484, 2483, '520201', '钟山区', '3');
INSERT INTO `sys_area` VALUES (2485, 2483, '520203', '六枝特区', '3');
INSERT INTO `sys_area` VALUES (2486, 2483, '520221', '水城县', '3');
INSERT INTO `sys_area` VALUES (2487, 2483, '520281', '盘州市', '3');
INSERT INTO `sys_area` VALUES (2488, 2471, '520300', '遵义市', '2');
INSERT INTO `sys_area` VALUES (2489, 2488, '520302', '红花岗区', '3');
INSERT INTO `sys_area` VALUES (2490, 2488, '520303', '汇川区', '3');
INSERT INTO `sys_area` VALUES (2491, 2488, '520304', '播州区', '3');
INSERT INTO `sys_area` VALUES (2492, 2488, '520322', '桐梓县', '3');
INSERT INTO `sys_area` VALUES (2493, 2488, '520323', '绥阳县', '3');
INSERT INTO `sys_area` VALUES (2494, 2488, '520324', '正安县', '3');
INSERT INTO `sys_area` VALUES (2495, 2488, '520325', '道真仡佬族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2496, 2488, '520326', '务川仡佬族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2497, 2488, '520327', '凤冈县', '3');
INSERT INTO `sys_area` VALUES (2498, 2488, '520328', '湄潭县', '3');
INSERT INTO `sys_area` VALUES (2499, 2488, '520329', '余庆县', '3');
INSERT INTO `sys_area` VALUES (2500, 2488, '520330', '习水县', '3');
INSERT INTO `sys_area` VALUES (2501, 2488, '520381', '赤水市', '3');
INSERT INTO `sys_area` VALUES (2502, 2488, '520382', '仁怀市', '3');
INSERT INTO `sys_area` VALUES (2503, 2471, '520400', '安顺市', '2');
INSERT INTO `sys_area` VALUES (2504, 2503, '520402', '西秀区', '3');
INSERT INTO `sys_area` VALUES (2505, 2503, '520403', '平坝区', '3');
INSERT INTO `sys_area` VALUES (2506, 2503, '520422', '普定县', '3');
INSERT INTO `sys_area` VALUES (2507, 2503, '520423', '镇宁布依族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2508, 2503, '520424', '关岭布依族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2509, 2503, '520425', '紫云苗族布依族自治县', '3');
INSERT INTO `sys_area` VALUES (2510, 2471, '520500', '毕节市', '2');
INSERT INTO `sys_area` VALUES (2511, 2510, '520502', '七星关区', '3');
INSERT INTO `sys_area` VALUES (2512, 2510, '520521', '大方县', '3');
INSERT INTO `sys_area` VALUES (2513, 2510, '520522', '黔西县', '3');
INSERT INTO `sys_area` VALUES (2514, 2510, '520523', '金沙县', '3');
INSERT INTO `sys_area` VALUES (2515, 2510, '520524', '织金县', '3');
INSERT INTO `sys_area` VALUES (2516, 2510, '520525', '纳雍县', '3');
INSERT INTO `sys_area` VALUES (2517, 2510, '520526', '威宁彝族回族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2518, 2510, '520527', '赫章县', '3');
INSERT INTO `sys_area` VALUES (2519, 2471, '520600', '铜仁市', '2');
INSERT INTO `sys_area` VALUES (2520, 2519, '520602', '碧江区', '3');
INSERT INTO `sys_area` VALUES (2521, 2519, '520603', '万山区', '3');
INSERT INTO `sys_area` VALUES (2522, 2519, '520621', '江口县', '3');
INSERT INTO `sys_area` VALUES (2523, 2519, '520622', '玉屏侗族自治县', '3');
INSERT INTO `sys_area` VALUES (2524, 2519, '520623', '石阡县', '3');
INSERT INTO `sys_area` VALUES (2525, 2519, '520624', '思南县', '3');
INSERT INTO `sys_area` VALUES (2526, 2519, '520625', '印江土家族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2527, 2519, '520626', '德江县', '3');
INSERT INTO `sys_area` VALUES (2528, 2519, '520627', '沿河土家族自治县', '3');
INSERT INTO `sys_area` VALUES (2529, 2519, '520628', '松桃苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2530, 2471, '522300', '黔西南布依族苗族自治州', '2');
INSERT INTO `sys_area` VALUES (2531, 2530, '522301', '兴义市', '3');
INSERT INTO `sys_area` VALUES (2532, 2530, '522302', '兴仁市', '3');
INSERT INTO `sys_area` VALUES (2533, 2530, '522323', '普安县', '3');
INSERT INTO `sys_area` VALUES (2534, 2530, '522324', '晴隆县', '3');
INSERT INTO `sys_area` VALUES (2535, 2530, '522325', '贞丰县', '3');
INSERT INTO `sys_area` VALUES (2536, 2530, '522326', '望谟县', '3');
INSERT INTO `sys_area` VALUES (2537, 2530, '522327', '册亨县', '3');
INSERT INTO `sys_area` VALUES (2538, 2530, '522328', '安龙县', '3');
INSERT INTO `sys_area` VALUES (2539, 2471, '522600', '黔东南苗族侗族自治州', '2');
INSERT INTO `sys_area` VALUES (2540, 2539, '522601', '凯里市', '3');
INSERT INTO `sys_area` VALUES (2541, 2539, '522622', '黄平县', '3');
INSERT INTO `sys_area` VALUES (2542, 2539, '522623', '施秉县', '3');
INSERT INTO `sys_area` VALUES (2543, 2539, '522624', '三穗县', '3');
INSERT INTO `sys_area` VALUES (2544, 2539, '522625', '镇远县', '3');
INSERT INTO `sys_area` VALUES (2545, 2539, '522626', '岑巩县', '3');
INSERT INTO `sys_area` VALUES (2546, 2539, '522627', '天柱县', '3');
INSERT INTO `sys_area` VALUES (2547, 2539, '522628', '锦屏县', '3');
INSERT INTO `sys_area` VALUES (2548, 2539, '522629', '剑河县', '3');
INSERT INTO `sys_area` VALUES (2549, 2539, '522630', '台江县', '3');
INSERT INTO `sys_area` VALUES (2550, 2539, '522631', '黎平县', '3');
INSERT INTO `sys_area` VALUES (2551, 2539, '522632', '榕江县', '3');
INSERT INTO `sys_area` VALUES (2552, 2539, '522633', '从江县', '3');
INSERT INTO `sys_area` VALUES (2553, 2539, '522634', '雷山县', '3');
INSERT INTO `sys_area` VALUES (2554, 2539, '522635', '麻江县', '3');
INSERT INTO `sys_area` VALUES (2555, 2539, '522636', '丹寨县', '3');
INSERT INTO `sys_area` VALUES (2556, 2471, '522700', '黔南布依族苗族自治州', '2');
INSERT INTO `sys_area` VALUES (2557, 2556, '522701', '都匀市', '3');
INSERT INTO `sys_area` VALUES (2558, 2556, '522702', '福泉市', '3');
INSERT INTO `sys_area` VALUES (2559, 2556, '522722', '荔波县', '3');
INSERT INTO `sys_area` VALUES (2560, 2556, '522723', '贵定县', '3');
INSERT INTO `sys_area` VALUES (2561, 2556, '522725', '瓮安县', '3');
INSERT INTO `sys_area` VALUES (2562, 2556, '522726', '独山县', '3');
INSERT INTO `sys_area` VALUES (2563, 2556, '522727', '平塘县', '3');
INSERT INTO `sys_area` VALUES (2564, 2556, '522728', '罗甸县', '3');
INSERT INTO `sys_area` VALUES (2565, 2556, '522729', '长顺县', '3');
INSERT INTO `sys_area` VALUES (2566, 2556, '522730', '龙里县', '3');
INSERT INTO `sys_area` VALUES (2567, 2556, '522731', '惠水县', '3');
INSERT INTO `sys_area` VALUES (2568, 2556, '522732', '三都水族自治县', '3');
INSERT INTO `sys_area` VALUES (2569, -1, '530000', '云南省', '1');
INSERT INTO `sys_area` VALUES (2570, 2569, '530100', '昆明市', '2');
INSERT INTO `sys_area` VALUES (2571, 2570, '530102', '五华区', '3');
INSERT INTO `sys_area` VALUES (2572, 2570, '530103', '盘龙区', '3');
INSERT INTO `sys_area` VALUES (2573, 2570, '530111', '官渡区', '3');
INSERT INTO `sys_area` VALUES (2574, 2570, '530112', '西山区', '3');
INSERT INTO `sys_area` VALUES (2575, 2570, '530113', '东川区', '3');
INSERT INTO `sys_area` VALUES (2576, 2570, '530114', '呈贡区', '3');
INSERT INTO `sys_area` VALUES (2577, 2570, '530115', '晋宁区', '3');
INSERT INTO `sys_area` VALUES (2578, 2570, '530124', '富民县', '3');
INSERT INTO `sys_area` VALUES (2579, 2570, '530125', '宜良县', '3');
INSERT INTO `sys_area` VALUES (2580, 2570, '530126', '石林彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2581, 2570, '530127', '嵩明县', '3');
INSERT INTO `sys_area` VALUES (2582, 2570, '530128', '禄劝彝族苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2583, 2570, '530129', '寻甸回族彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2584, 2570, '530181', '安宁市', '3');
INSERT INTO `sys_area` VALUES (2585, 2569, '530300', '曲靖市', '2');
INSERT INTO `sys_area` VALUES (2586, 2585, '530302', '麒麟区', '3');
INSERT INTO `sys_area` VALUES (2587, 2585, '530303', '沾益区', '3');
INSERT INTO `sys_area` VALUES (2588, 2585, '530304', '马龙区', '3');
INSERT INTO `sys_area` VALUES (2589, 2585, '530322', '陆良县', '3');
INSERT INTO `sys_area` VALUES (2590, 2585, '530323', '师宗县', '3');
INSERT INTO `sys_area` VALUES (2591, 2585, '530324', '罗平县', '3');
INSERT INTO `sys_area` VALUES (2592, 2585, '530325', '富源县', '3');
INSERT INTO `sys_area` VALUES (2593, 2585, '530326', '会泽县', '3');
INSERT INTO `sys_area` VALUES (2594, 2585, '530381', '宣威市', '3');
INSERT INTO `sys_area` VALUES (2595, 2569, '530400', '玉溪市', '2');
INSERT INTO `sys_area` VALUES (2596, 2595, '530402', '红塔区', '3');
INSERT INTO `sys_area` VALUES (2597, 2595, '530403', '江川区', '3');
INSERT INTO `sys_area` VALUES (2598, 2595, '530422', '澄江县', '3');
INSERT INTO `sys_area` VALUES (2599, 2595, '530423', '通海县', '3');
INSERT INTO `sys_area` VALUES (2600, 2595, '530424', '华宁县', '3');
INSERT INTO `sys_area` VALUES (2601, 2595, '530425', '易门县', '3');
INSERT INTO `sys_area` VALUES (2602, 2595, '530426', '峨山彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2603, 2595, '530427', '新平彝族傣族自治县', '3');
INSERT INTO `sys_area` VALUES (2604, 2595, '530428', '元江哈尼族彝族傣族自治县', '3');
INSERT INTO `sys_area` VALUES (2605, 2569, '530500', '保山市', '2');
INSERT INTO `sys_area` VALUES (2606, 2605, '530502', '隆阳区', '3');
INSERT INTO `sys_area` VALUES (2607, 2605, '530521', '施甸县', '3');
INSERT INTO `sys_area` VALUES (2608, 2605, '530523', '龙陵县', '3');
INSERT INTO `sys_area` VALUES (2609, 2605, '530524', '昌宁县', '3');
INSERT INTO `sys_area` VALUES (2610, 2605, '530581', '腾冲市', '3');
INSERT INTO `sys_area` VALUES (2611, 2569, '530600', '昭通市', '2');
INSERT INTO `sys_area` VALUES (2612, 2611, '530602', '昭阳区', '3');
INSERT INTO `sys_area` VALUES (2613, 2611, '530621', '鲁甸县', '3');
INSERT INTO `sys_area` VALUES (2614, 2611, '530622', '巧家县', '3');
INSERT INTO `sys_area` VALUES (2615, 2611, '530623', '盐津县', '3');
INSERT INTO `sys_area` VALUES (2616, 2611, '530624', '大关县', '3');
INSERT INTO `sys_area` VALUES (2617, 2611, '530625', '永善县', '3');
INSERT INTO `sys_area` VALUES (2618, 2611, '530626', '绥江县', '3');
INSERT INTO `sys_area` VALUES (2619, 2611, '530627', '镇雄县', '3');
INSERT INTO `sys_area` VALUES (2620, 2611, '530628', '彝良县', '3');
INSERT INTO `sys_area` VALUES (2621, 2611, '530629', '威信县', '3');
INSERT INTO `sys_area` VALUES (2622, 2611, '530681', '水富市', '3');
INSERT INTO `sys_area` VALUES (2623, 2569, '530700', '丽江市', '2');
INSERT INTO `sys_area` VALUES (2624, 2623, '530702', '古城区', '3');
INSERT INTO `sys_area` VALUES (2625, 2623, '530721', '玉龙纳西族自治县', '3');
INSERT INTO `sys_area` VALUES (2626, 2623, '530722', '永胜县', '3');
INSERT INTO `sys_area` VALUES (2627, 2623, '530723', '华坪县', '3');
INSERT INTO `sys_area` VALUES (2628, 2623, '530724', '宁蒗彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2629, 2569, '530800', '普洱市', '2');
INSERT INTO `sys_area` VALUES (2630, 2629, '530802', '思茅区', '3');
INSERT INTO `sys_area` VALUES (2631, 2629, '530821', '宁洱哈尼族彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2632, 2629, '530822', '墨江哈尼族自治县', '3');
INSERT INTO `sys_area` VALUES (2633, 2629, '530823', '景东彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2634, 2629, '530824', '景谷傣族彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2635, 2629, '530825', '镇沅彝族哈尼族拉祜族自治县', '3');
INSERT INTO `sys_area` VALUES (2636, 2629, '530826', '江城哈尼族彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2637, 2629, '530827', '孟连傣族拉祜族佤族自治县', '3');
INSERT INTO `sys_area` VALUES (2638, 2629, '530828', '澜沧拉祜族自治县', '3');
INSERT INTO `sys_area` VALUES (2639, 2629, '530829', '西盟佤族自治县', '3');
INSERT INTO `sys_area` VALUES (2640, 2569, '530900', '临沧市', '2');
INSERT INTO `sys_area` VALUES (2641, 2640, '530902', '临翔区', '3');
INSERT INTO `sys_area` VALUES (2642, 2640, '530921', '凤庆县', '3');
INSERT INTO `sys_area` VALUES (2643, 2640, '530922', '云县', '3');
INSERT INTO `sys_area` VALUES (2644, 2640, '530923', '永德县', '3');
INSERT INTO `sys_area` VALUES (2645, 2640, '530924', '镇康县', '3');
INSERT INTO `sys_area` VALUES (2646, 2640, '530925', '双江拉祜族佤族布朗族傣族自治县', '3');
INSERT INTO `sys_area` VALUES (2647, 2640, '530926', '耿马傣族佤族自治县', '3');
INSERT INTO `sys_area` VALUES (2648, 2640, '530927', '沧源佤族自治县', '3');
INSERT INTO `sys_area` VALUES (2649, 2569, '532300', '楚雄彝族自治州', '2');
INSERT INTO `sys_area` VALUES (2650, 2649, '532301', '楚雄市', '3');
INSERT INTO `sys_area` VALUES (2651, 2649, '532322', '双柏县', '3');
INSERT INTO `sys_area` VALUES (2652, 2649, '532323', '牟定县', '3');
INSERT INTO `sys_area` VALUES (2653, 2649, '532324', '南华县', '3');
INSERT INTO `sys_area` VALUES (2654, 2649, '532325', '姚安县', '3');
INSERT INTO `sys_area` VALUES (2655, 2649, '532326', '大姚县', '3');
INSERT INTO `sys_area` VALUES (2656, 2649, '532327', '永仁县', '3');
INSERT INTO `sys_area` VALUES (2657, 2649, '532328', '元谋县', '3');
INSERT INTO `sys_area` VALUES (2658, 2649, '532329', '武定县', '3');
INSERT INTO `sys_area` VALUES (2659, 2649, '532331', '禄丰县', '3');
INSERT INTO `sys_area` VALUES (2660, 2569, '532500', '红河哈尼族彝族自治州', '2');
INSERT INTO `sys_area` VALUES (2661, 2660, '532501', '个旧市', '3');
INSERT INTO `sys_area` VALUES (2662, 2660, '532502', '开远市', '3');
INSERT INTO `sys_area` VALUES (2663, 2660, '532503', '蒙自市', '3');
INSERT INTO `sys_area` VALUES (2664, 2660, '532504', '弥勒市', '3');
INSERT INTO `sys_area` VALUES (2665, 2660, '532523', '屏边苗族自治县', '3');
INSERT INTO `sys_area` VALUES (2666, 2660, '532524', '建水县', '3');
INSERT INTO `sys_area` VALUES (2667, 2660, '532525', '石屏县', '3');
INSERT INTO `sys_area` VALUES (2668, 2660, '532527', '泸西县', '3');
INSERT INTO `sys_area` VALUES (2669, 2660, '532528', '元阳县', '3');
INSERT INTO `sys_area` VALUES (2670, 2660, '532529', '红河县', '3');
INSERT INTO `sys_area` VALUES (2671, 2660, '532530', '金平苗族瑶族傣族自治县', '3');
INSERT INTO `sys_area` VALUES (2672, 2660, '532531', '绿春县', '3');
INSERT INTO `sys_area` VALUES (2673, 2660, '532532', '河口瑶族自治县', '3');
INSERT INTO `sys_area` VALUES (2674, 2569, '532600', '文山壮族苗族自治州', '2');
INSERT INTO `sys_area` VALUES (2675, 2674, '532601', '文山市', '3');
INSERT INTO `sys_area` VALUES (2676, 2674, '532622', '砚山县', '3');
INSERT INTO `sys_area` VALUES (2677, 2674, '532623', '西畴县', '3');
INSERT INTO `sys_area` VALUES (2678, 2674, '532624', '麻栗坡县', '3');
INSERT INTO `sys_area` VALUES (2679, 2674, '532625', '马关县', '3');
INSERT INTO `sys_area` VALUES (2680, 2674, '532626', '丘北县', '3');
INSERT INTO `sys_area` VALUES (2681, 2674, '532627', '广南县', '3');
INSERT INTO `sys_area` VALUES (2682, 2674, '532628', '富宁县', '3');
INSERT INTO `sys_area` VALUES (2683, 2569, '532800', '西双版纳傣族自治州', '2');
INSERT INTO `sys_area` VALUES (2684, 2683, '532801', '景洪市', '3');
INSERT INTO `sys_area` VALUES (2685, 2683, '532822', '勐海县', '3');
INSERT INTO `sys_area` VALUES (2686, 2683, '532823', '勐腊县', '3');
INSERT INTO `sys_area` VALUES (2687, 2569, '532900', '大理白族自治州', '2');
INSERT INTO `sys_area` VALUES (2688, 2687, '532901', '大理市', '3');
INSERT INTO `sys_area` VALUES (2689, 2687, '532922', '漾濞彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2690, 2687, '532923', '祥云县', '3');
INSERT INTO `sys_area` VALUES (2691, 2687, '532924', '宾川县', '3');
INSERT INTO `sys_area` VALUES (2692, 2687, '532925', '弥渡县', '3');
INSERT INTO `sys_area` VALUES (2693, 2687, '532926', '南涧彝族自治县', '3');
INSERT INTO `sys_area` VALUES (2694, 2687, '532927', '巍山彝族回族自治县', '3');
INSERT INTO `sys_area` VALUES (2695, 2687, '532928', '永平县', '3');
INSERT INTO `sys_area` VALUES (2696, 2687, '532929', '云龙县', '3');
INSERT INTO `sys_area` VALUES (2697, 2687, '532930', '洱源县', '3');
INSERT INTO `sys_area` VALUES (2698, 2687, '532931', '剑川县', '3');
INSERT INTO `sys_area` VALUES (2699, 2687, '532932', '鹤庆县', '3');
INSERT INTO `sys_area` VALUES (2700, 2569, '533100', '德宏傣族景颇族自治州', '2');
INSERT INTO `sys_area` VALUES (2701, 2700, '533102', '瑞丽市', '3');
INSERT INTO `sys_area` VALUES (2702, 2700, '533103', '芒市', '3');
INSERT INTO `sys_area` VALUES (2703, 2700, '533122', '梁河县', '3');
INSERT INTO `sys_area` VALUES (2704, 2700, '533123', '盈江县', '3');
INSERT INTO `sys_area` VALUES (2705, 2700, '533124', '陇川县', '3');
INSERT INTO `sys_area` VALUES (2706, 2569, '533300', '怒江傈僳族自治州', '2');
INSERT INTO `sys_area` VALUES (2707, 2706, '533301', '泸水市', '3');
INSERT INTO `sys_area` VALUES (2708, 2706, '533323', '福贡县', '3');
INSERT INTO `sys_area` VALUES (2709, 2706, '533324', '贡山独龙族怒族自治县', '3');
INSERT INTO `sys_area` VALUES (2710, 2706, '533325', '兰坪白族普米族自治县', '3');
INSERT INTO `sys_area` VALUES (2711, 2569, '533400', '迪庆藏族自治州', '2');
INSERT INTO `sys_area` VALUES (2712, 2711, '533401', '香格里拉市', '3');
INSERT INTO `sys_area` VALUES (2713, 2711, '533422', '德钦县', '3');
INSERT INTO `sys_area` VALUES (2714, 2711, '533423', '维西傈僳族自治县', '3');
INSERT INTO `sys_area` VALUES (2715, -1, '540000', '西藏自治区', '1');
INSERT INTO `sys_area` VALUES (2716, 2715, '540100', '拉萨市', '2');
INSERT INTO `sys_area` VALUES (2717, 2716, '540102', '城关区', '3');
INSERT INTO `sys_area` VALUES (2718, 2716, '540103', '堆龙德庆区', '3');
INSERT INTO `sys_area` VALUES (2719, 2716, '540104', '达孜区', '3');
INSERT INTO `sys_area` VALUES (2720, 2716, '540121', '林周县', '3');
INSERT INTO `sys_area` VALUES (2721, 2716, '540122', '当雄县', '3');
INSERT INTO `sys_area` VALUES (2722, 2716, '540123', '尼木县', '3');
INSERT INTO `sys_area` VALUES (2723, 2716, '540124', '曲水县', '3');
INSERT INTO `sys_area` VALUES (2724, 2716, '540127', '墨竹工卡县', '3');
INSERT INTO `sys_area` VALUES (2725, 2715, '540200', '日喀则市', '2');
INSERT INTO `sys_area` VALUES (2726, 2725, '540202', '桑珠孜区', '3');
INSERT INTO `sys_area` VALUES (2727, 2725, '540221', '南木林县', '3');
INSERT INTO `sys_area` VALUES (2728, 2725, '540222', '江孜县', '3');
INSERT INTO `sys_area` VALUES (2729, 2725, '540223', '定日县', '3');
INSERT INTO `sys_area` VALUES (2730, 2725, '540224', '萨迦县', '3');
INSERT INTO `sys_area` VALUES (2731, 2725, '540225', '拉孜县', '3');
INSERT INTO `sys_area` VALUES (2732, 2725, '540226', '昂仁县', '3');
INSERT INTO `sys_area` VALUES (2733, 2725, '540227', '谢通门县', '3');
INSERT INTO `sys_area` VALUES (2734, 2725, '540228', '白朗县', '3');
INSERT INTO `sys_area` VALUES (2735, 2725, '540229', '仁布县', '3');
INSERT INTO `sys_area` VALUES (2736, 2725, '540230', '康马县', '3');
INSERT INTO `sys_area` VALUES (2737, 2725, '540231', '定结县', '3');
INSERT INTO `sys_area` VALUES (2738, 2725, '540232', '仲巴县', '3');
INSERT INTO `sys_area` VALUES (2739, 2725, '540233', '亚东县', '3');
INSERT INTO `sys_area` VALUES (2740, 2725, '540234', '吉隆县', '3');
INSERT INTO `sys_area` VALUES (2741, 2725, '540235', '聂拉木县', '3');
INSERT INTO `sys_area` VALUES (2742, 2725, '540236', '萨嘎县', '3');
INSERT INTO `sys_area` VALUES (2743, 2725, '540237', '岗巴县', '3');
INSERT INTO `sys_area` VALUES (2744, 2715, '540300', '昌都市', '2');
INSERT INTO `sys_area` VALUES (2745, 2744, '540302', '卡若区', '3');
INSERT INTO `sys_area` VALUES (2746, 2744, '540321', '江达县', '3');
INSERT INTO `sys_area` VALUES (2747, 2744, '540322', '贡觉县', '3');
INSERT INTO `sys_area` VALUES (2748, 2744, '540323', '类乌齐县', '3');
INSERT INTO `sys_area` VALUES (2749, 2744, '540324', '丁青县', '3');
INSERT INTO `sys_area` VALUES (2750, 2744, '540325', '察雅县', '3');
INSERT INTO `sys_area` VALUES (2751, 2744, '540326', '八宿县', '3');
INSERT INTO `sys_area` VALUES (2752, 2744, '540327', '左贡县', '3');
INSERT INTO `sys_area` VALUES (2753, 2744, '540328', '芒康县', '3');
INSERT INTO `sys_area` VALUES (2754, 2744, '540329', '洛隆县', '3');
INSERT INTO `sys_area` VALUES (2755, 2744, '540330', '边坝县', '3');
INSERT INTO `sys_area` VALUES (2756, 2715, '540400', '林芝市', '2');
INSERT INTO `sys_area` VALUES (2757, 2756, '540402', '巴宜区', '3');
INSERT INTO `sys_area` VALUES (2758, 2756, '540421', '工布江达县', '3');
INSERT INTO `sys_area` VALUES (2759, 2756, '540422', '米林县', '3');
INSERT INTO `sys_area` VALUES (2760, 2756, '540423', '墨脱县', '3');
INSERT INTO `sys_area` VALUES (2761, 2756, '540424', '波密县', '3');
INSERT INTO `sys_area` VALUES (2762, 2756, '540425', '察隅县', '3');
INSERT INTO `sys_area` VALUES (2763, 2756, '540426', '朗县', '3');
INSERT INTO `sys_area` VALUES (2764, 2715, '540500', '山南市', '2');
INSERT INTO `sys_area` VALUES (2765, 2764, '540502', '乃东区', '3');
INSERT INTO `sys_area` VALUES (2766, 2764, '540521', '扎囊县', '3');
INSERT INTO `sys_area` VALUES (2767, 2764, '540522', '贡嘎县', '3');
INSERT INTO `sys_area` VALUES (2768, 2764, '540523', '桑日县', '3');
INSERT INTO `sys_area` VALUES (2769, 2764, '540524', '琼结县', '3');
INSERT INTO `sys_area` VALUES (2770, 2764, '540525', '曲松县', '3');
INSERT INTO `sys_area` VALUES (2771, 2764, '540526', '措美县', '3');
INSERT INTO `sys_area` VALUES (2772, 2764, '540527', '洛扎县', '3');
INSERT INTO `sys_area` VALUES (2773, 2764, '540528', '加查县', '3');
INSERT INTO `sys_area` VALUES (2774, 2764, '540529', '隆子县', '3');
INSERT INTO `sys_area` VALUES (2775, 2764, '540530', '错那县', '3');
INSERT INTO `sys_area` VALUES (2776, 2764, '540531', '浪卡子县', '3');
INSERT INTO `sys_area` VALUES (2777, 2715, '540600', '那曲市', '2');
INSERT INTO `sys_area` VALUES (2778, 2777, '540602', '色尼区', '3');
INSERT INTO `sys_area` VALUES (2779, 2777, '540621', '嘉黎县 ', '3');
INSERT INTO `sys_area` VALUES (2780, 2777, '540622', '比如县 ', '3');
INSERT INTO `sys_area` VALUES (2781, 2777, '540623', '聂荣县 ', '3');
INSERT INTO `sys_area` VALUES (2782, 2777, '540624', '安多县 ', '3');
INSERT INTO `sys_area` VALUES (2783, 2777, '540625', '申扎县 ', '3');
INSERT INTO `sys_area` VALUES (2784, 2777, '540626', '索县   ', '3');
INSERT INTO `sys_area` VALUES (2785, 2777, '540627', '班戈县 ', '3');
INSERT INTO `sys_area` VALUES (2786, 2777, '540628', '巴青县 ', '3');
INSERT INTO `sys_area` VALUES (2787, 2777, '540629', '尼玛县 ', '3');
INSERT INTO `sys_area` VALUES (2788, 2777, '540630', '双湖县 ', '3');
INSERT INTO `sys_area` VALUES (2789, 2715, '542500', '阿里地区', '2');
INSERT INTO `sys_area` VALUES (2790, 2789, '542521', '普兰县', '3');
INSERT INTO `sys_area` VALUES (2791, 2789, '542522', '札达县', '3');
INSERT INTO `sys_area` VALUES (2792, 2789, '542523', '噶尔县', '3');
INSERT INTO `sys_area` VALUES (2793, 2789, '542524', '日土县', '3');
INSERT INTO `sys_area` VALUES (2794, 2789, '542525', '革吉县', '3');
INSERT INTO `sys_area` VALUES (2795, 2789, '542526', '改则县', '3');
INSERT INTO `sys_area` VALUES (2796, 2789, '542527', '措勤县', '3');
INSERT INTO `sys_area` VALUES (2797, -1, '610000', '陕西省', '1');
INSERT INTO `sys_area` VALUES (2798, 2797, '610100', '西安市', '2');
INSERT INTO `sys_area` VALUES (2799, 2798, '610102', '新城区', '3');
INSERT INTO `sys_area` VALUES (2800, 2798, '610103', '碑林区', '3');
INSERT INTO `sys_area` VALUES (2801, 2798, '610104', '莲湖区', '3');
INSERT INTO `sys_area` VALUES (2802, 2798, '610111', '灞桥区', '3');
INSERT INTO `sys_area` VALUES (2803, 2798, '610112', '未央区', '3');
INSERT INTO `sys_area` VALUES (2804, 2798, '610113', '雁塔区', '3');
INSERT INTO `sys_area` VALUES (2805, 2798, '610114', '阎良区', '3');
INSERT INTO `sys_area` VALUES (2806, 2798, '610115', '临潼区', '3');
INSERT INTO `sys_area` VALUES (2807, 2798, '610116', '长安区', '3');
INSERT INTO `sys_area` VALUES (2808, 2798, '610117', '高陵区', '3');
INSERT INTO `sys_area` VALUES (2809, 2798, '610118', '鄠邑区', '3');
INSERT INTO `sys_area` VALUES (2810, 2798, '610122', '蓝田县', '3');
INSERT INTO `sys_area` VALUES (2811, 2798, '610124', '周至县', '3');
INSERT INTO `sys_area` VALUES (2812, 2797, '610200', '铜川市', '2');
INSERT INTO `sys_area` VALUES (2813, 2812, '610202', '王益区', '3');
INSERT INTO `sys_area` VALUES (2814, 2812, '610203', '印台区', '3');
INSERT INTO `sys_area` VALUES (2815, 2812, '610204', '耀州区', '3');
INSERT INTO `sys_area` VALUES (2816, 2812, '610222', '宜君县', '3');
INSERT INTO `sys_area` VALUES (2817, 2797, '610300', '宝鸡市', '2');
INSERT INTO `sys_area` VALUES (2818, 2817, '610302', '渭滨区', '3');
INSERT INTO `sys_area` VALUES (2819, 2817, '610303', '金台区', '3');
INSERT INTO `sys_area` VALUES (2820, 2817, '610304', '陈仓区', '3');
INSERT INTO `sys_area` VALUES (2821, 2817, '610322', '凤翔县', '3');
INSERT INTO `sys_area` VALUES (2822, 2817, '610323', '岐山县', '3');
INSERT INTO `sys_area` VALUES (2823, 2817, '610324', '扶风县', '3');
INSERT INTO `sys_area` VALUES (2824, 2817, '610326', '眉县', '3');
INSERT INTO `sys_area` VALUES (2825, 2817, '610327', '陇县', '3');
INSERT INTO `sys_area` VALUES (2826, 2817, '610328', '千阳县', '3');
INSERT INTO `sys_area` VALUES (2827, 2817, '610329', '麟游县', '3');
INSERT INTO `sys_area` VALUES (2828, 2817, '610330', '凤县', '3');
INSERT INTO `sys_area` VALUES (2829, 2817, '610331', '太白县', '3');
INSERT INTO `sys_area` VALUES (2830, 2797, '610400', '咸阳市', '2');
INSERT INTO `sys_area` VALUES (2831, 2830, '610402', '秦都区', '3');
INSERT INTO `sys_area` VALUES (2832, 2830, '610403', '杨陵区', '3');
INSERT INTO `sys_area` VALUES (2833, 2830, '610404', '渭城区', '3');
INSERT INTO `sys_area` VALUES (2834, 2830, '610422', '三原县', '3');
INSERT INTO `sys_area` VALUES (2835, 2830, '610423', '泾阳县', '3');
INSERT INTO `sys_area` VALUES (2836, 2830, '610424', '乾县', '3');
INSERT INTO `sys_area` VALUES (2837, 2830, '610425', '礼泉县', '3');
INSERT INTO `sys_area` VALUES (2838, 2830, '610426', '永寿县', '3');
INSERT INTO `sys_area` VALUES (2839, 2830, '610428', '长武县', '3');
INSERT INTO `sys_area` VALUES (2840, 2830, '610429', '旬邑县', '3');
INSERT INTO `sys_area` VALUES (2841, 2830, '610430', '淳化县', '3');
INSERT INTO `sys_area` VALUES (2842, 2830, '610431', '武功县', '3');
INSERT INTO `sys_area` VALUES (2843, 2830, '610481', '兴平市', '3');
INSERT INTO `sys_area` VALUES (2844, 2830, '610482', '彬州市', '3');
INSERT INTO `sys_area` VALUES (2845, 2797, '610500', '渭南市', '2');
INSERT INTO `sys_area` VALUES (2846, 2845, '610502', '临渭区', '3');
INSERT INTO `sys_area` VALUES (2847, 2845, '610503', '华州区', '3');
INSERT INTO `sys_area` VALUES (2848, 2845, '610522', '潼关县', '3');
INSERT INTO `sys_area` VALUES (2849, 2845, '610523', '大荔县', '3');
INSERT INTO `sys_area` VALUES (2850, 2845, '610524', '合阳县', '3');
INSERT INTO `sys_area` VALUES (2851, 2845, '610525', '澄城县', '3');
INSERT INTO `sys_area` VALUES (2852, 2845, '610526', '蒲城县', '3');
INSERT INTO `sys_area` VALUES (2853, 2845, '610527', '白水县', '3');
INSERT INTO `sys_area` VALUES (2854, 2845, '610528', '富平县', '3');
INSERT INTO `sys_area` VALUES (2855, 2845, '610581', '韩城市', '3');
INSERT INTO `sys_area` VALUES (2856, 2845, '610582', '华阴市', '3');
INSERT INTO `sys_area` VALUES (2857, 2797, '610600', '延安市', '2');
INSERT INTO `sys_area` VALUES (2858, 2857, '610602', '宝塔区', '3');
INSERT INTO `sys_area` VALUES (2859, 2857, '610603', '安塞区', '3');
INSERT INTO `sys_area` VALUES (2860, 2857, '610621', '延长县', '3');
INSERT INTO `sys_area` VALUES (2861, 2857, '610622', '延川县', '3');
INSERT INTO `sys_area` VALUES (2862, 2857, '610623', '子长县', '3');
INSERT INTO `sys_area` VALUES (2863, 2857, '610625', '志丹县', '3');
INSERT INTO `sys_area` VALUES (2864, 2857, '610626', '吴起县', '3');
INSERT INTO `sys_area` VALUES (2865, 2857, '610627', '甘泉县', '3');
INSERT INTO `sys_area` VALUES (2866, 2857, '610628', '富县', '3');
INSERT INTO `sys_area` VALUES (2867, 2857, '610629', '洛川县', '3');
INSERT INTO `sys_area` VALUES (2868, 2857, '610630', '宜川县', '3');
INSERT INTO `sys_area` VALUES (2869, 2857, '610631', '黄龙县', '3');
INSERT INTO `sys_area` VALUES (2870, 2857, '610632', '黄陵县', '3');
INSERT INTO `sys_area` VALUES (2871, 2797, '610700', '汉中市', '2');
INSERT INTO `sys_area` VALUES (2872, 2871, '610702', '汉台区', '3');
INSERT INTO `sys_area` VALUES (2873, 2871, '610703', '南郑区', '3');
INSERT INTO `sys_area` VALUES (2874, 2871, '610722', '城固县', '3');
INSERT INTO `sys_area` VALUES (2875, 2871, '610723', '洋县', '3');
INSERT INTO `sys_area` VALUES (2876, 2871, '610724', '西乡县', '3');
INSERT INTO `sys_area` VALUES (2877, 2871, '610725', '勉县', '3');
INSERT INTO `sys_area` VALUES (2878, 2871, '610726', '宁强县', '3');
INSERT INTO `sys_area` VALUES (2879, 2871, '610727', '略阳县', '3');
INSERT INTO `sys_area` VALUES (2880, 2871, '610728', '镇巴县', '3');
INSERT INTO `sys_area` VALUES (2881, 2871, '610729', '留坝县', '3');
INSERT INTO `sys_area` VALUES (2882, 2871, '610730', '佛坪县', '3');
INSERT INTO `sys_area` VALUES (2883, 2797, '610800', '榆林市', '2');
INSERT INTO `sys_area` VALUES (2884, 2883, '610802', '榆阳区', '3');
INSERT INTO `sys_area` VALUES (2885, 2883, '610803', '横山区', '3');
INSERT INTO `sys_area` VALUES (2886, 2883, '610822', '府谷县', '3');
INSERT INTO `sys_area` VALUES (2887, 2883, '610824', '靖边县', '3');
INSERT INTO `sys_area` VALUES (2888, 2883, '610825', '定边县', '3');
INSERT INTO `sys_area` VALUES (2889, 2883, '610826', '绥德县', '3');
INSERT INTO `sys_area` VALUES (2890, 2883, '610827', '米脂县', '3');
INSERT INTO `sys_area` VALUES (2891, 2883, '610828', '佳县', '3');
INSERT INTO `sys_area` VALUES (2892, 2883, '610829', '吴堡县', '3');
INSERT INTO `sys_area` VALUES (2893, 2883, '610830', '清涧县', '3');
INSERT INTO `sys_area` VALUES (2894, 2883, '610831', '子洲县', '3');
INSERT INTO `sys_area` VALUES (2895, 2883, '610881', '神木市', '3');
INSERT INTO `sys_area` VALUES (2896, 2797, '610900', '安康市', '2');
INSERT INTO `sys_area` VALUES (2897, 2896, '610902', '汉滨区', '3');
INSERT INTO `sys_area` VALUES (2898, 2896, '610921', '汉阴县', '3');
INSERT INTO `sys_area` VALUES (2899, 2896, '610922', '石泉县', '3');
INSERT INTO `sys_area` VALUES (2900, 2896, '610923', '宁陕县', '3');
INSERT INTO `sys_area` VALUES (2901, 2896, '610924', '紫阳县', '3');
INSERT INTO `sys_area` VALUES (2902, 2896, '610925', '岚皋县', '3');
INSERT INTO `sys_area` VALUES (2903, 2896, '610926', '平利县', '3');
INSERT INTO `sys_area` VALUES (2904, 2896, '610927', '镇坪县', '3');
INSERT INTO `sys_area` VALUES (2905, 2896, '610928', '旬阳县', '3');
INSERT INTO `sys_area` VALUES (2906, 2896, '610929', '白河县', '3');
INSERT INTO `sys_area` VALUES (2907, 2797, '611000', '商洛市', '2');
INSERT INTO `sys_area` VALUES (2908, 2907, '611002', '商州区', '3');
INSERT INTO `sys_area` VALUES (2909, 2907, '611021', '洛南县', '3');
INSERT INTO `sys_area` VALUES (2910, 2907, '611022', '丹凤县', '3');
INSERT INTO `sys_area` VALUES (2911, 2907, '611023', '商南县', '3');
INSERT INTO `sys_area` VALUES (2912, 2907, '611024', '山阳县', '3');
INSERT INTO `sys_area` VALUES (2913, 2907, '611025', '镇安县', '3');
INSERT INTO `sys_area` VALUES (2914, 2907, '611026', '柞水县', '3');
INSERT INTO `sys_area` VALUES (2915, -1, '620000', '甘肃省', '1');
INSERT INTO `sys_area` VALUES (2916, 2915, '620100', '兰州市', '2');
INSERT INTO `sys_area` VALUES (2917, 2916, '620102', '城关区', '3');
INSERT INTO `sys_area` VALUES (2918, 2916, '620103', '七里河区', '3');
INSERT INTO `sys_area` VALUES (2919, 2916, '620104', '西固区', '3');
INSERT INTO `sys_area` VALUES (2920, 2916, '620105', '安宁区', '3');
INSERT INTO `sys_area` VALUES (2921, 2916, '620111', '红古区', '3');
INSERT INTO `sys_area` VALUES (2922, 2916, '620121', '永登县', '3');
INSERT INTO `sys_area` VALUES (2923, 2916, '620122', '皋兰县', '3');
INSERT INTO `sys_area` VALUES (2924, 2916, '620123', '榆中县', '3');
INSERT INTO `sys_area` VALUES (2925, 2915, '620200', '嘉峪关市', '2');
INSERT INTO `sys_area` VALUES (2926, 2915, '620300', '金昌市', '2');
INSERT INTO `sys_area` VALUES (2927, 2926, '620302', '金川区', '3');
INSERT INTO `sys_area` VALUES (2928, 2926, '620321', '永昌县', '3');
INSERT INTO `sys_area` VALUES (2929, 2915, '620400', '白银市', '2');
INSERT INTO `sys_area` VALUES (2930, 2929, '620402', '白银区', '3');
INSERT INTO `sys_area` VALUES (2931, 2929, '620403', '平川区', '3');
INSERT INTO `sys_area` VALUES (2932, 2929, '620421', '靖远县', '3');
INSERT INTO `sys_area` VALUES (2933, 2929, '620422', '会宁县', '3');
INSERT INTO `sys_area` VALUES (2934, 2929, '620423', '景泰县', '3');
INSERT INTO `sys_area` VALUES (2935, 2915, '620500', '天水市', '2');
INSERT INTO `sys_area` VALUES (2936, 2935, '620502', '秦州区', '3');
INSERT INTO `sys_area` VALUES (2937, 2935, '620503', '麦积区', '3');
INSERT INTO `sys_area` VALUES (2938, 2935, '620521', '清水县', '3');
INSERT INTO `sys_area` VALUES (2939, 2935, '620522', '秦安县', '3');
INSERT INTO `sys_area` VALUES (2940, 2935, '620523', '甘谷县', '3');
INSERT INTO `sys_area` VALUES (2941, 2935, '620524', '武山县', '3');
INSERT INTO `sys_area` VALUES (2942, 2935, '620525', '张家川回族自治县', '3');
INSERT INTO `sys_area` VALUES (2943, 2915, '620600', '武威市', '2');
INSERT INTO `sys_area` VALUES (2944, 2943, '620602', '凉州区', '3');
INSERT INTO `sys_area` VALUES (2945, 2943, '620621', '民勤县', '3');
INSERT INTO `sys_area` VALUES (2946, 2943, '620622', '古浪县', '3');
INSERT INTO `sys_area` VALUES (2947, 2943, '620623', '天祝藏族自治县', '3');
INSERT INTO `sys_area` VALUES (2948, 2915, '620700', '张掖市', '2');
INSERT INTO `sys_area` VALUES (2949, 2948, '620702', '甘州区', '3');
INSERT INTO `sys_area` VALUES (2950, 2948, '620721', '肃南裕固族自治县', '3');
INSERT INTO `sys_area` VALUES (2951, 2948, '620722', '民乐县', '3');
INSERT INTO `sys_area` VALUES (2952, 2948, '620723', '临泽县', '3');
INSERT INTO `sys_area` VALUES (2953, 2948, '620724', '高台县', '3');
INSERT INTO `sys_area` VALUES (2954, 2948, '620725', '山丹县', '3');
INSERT INTO `sys_area` VALUES (2955, 2915, '620800', '平凉市', '2');
INSERT INTO `sys_area` VALUES (2956, 2955, '620802', '崆峒区', '3');
INSERT INTO `sys_area` VALUES (2957, 2955, '620821', '泾川县', '3');
INSERT INTO `sys_area` VALUES (2958, 2955, '620822', '灵台县', '3');
INSERT INTO `sys_area` VALUES (2959, 2955, '620823', '崇信县', '3');
INSERT INTO `sys_area` VALUES (2960, 2955, '620825', '庄浪县', '3');
INSERT INTO `sys_area` VALUES (2961, 2955, '620826', '静宁县', '3');
INSERT INTO `sys_area` VALUES (2962, 2955, '620881', '华亭市', '3');
INSERT INTO `sys_area` VALUES (2963, 2915, '620900', '酒泉市', '2');
INSERT INTO `sys_area` VALUES (2964, 2963, '620902', '肃州区', '3');
INSERT INTO `sys_area` VALUES (2965, 2963, '620921', '金塔县', '3');
INSERT INTO `sys_area` VALUES (2966, 2963, '620922', '瓜州县', '3');
INSERT INTO `sys_area` VALUES (2967, 2963, '620923', '肃北蒙古族自治县', '3');
INSERT INTO `sys_area` VALUES (2968, 2963, '620924', '阿克塞哈萨克族自治县', '3');
INSERT INTO `sys_area` VALUES (2969, 2963, '620981', '玉门市', '3');
INSERT INTO `sys_area` VALUES (2970, 2963, '620982', '敦煌市', '3');
INSERT INTO `sys_area` VALUES (2971, 2915, '621000', '庆阳市', '2');
INSERT INTO `sys_area` VALUES (2972, 2971, '621002', '西峰区', '3');
INSERT INTO `sys_area` VALUES (2973, 2971, '621021', '庆城县', '3');
INSERT INTO `sys_area` VALUES (2974, 2971, '621022', '环县', '3');
INSERT INTO `sys_area` VALUES (2975, 2971, '621023', '华池县', '3');
INSERT INTO `sys_area` VALUES (2976, 2971, '621024', '合水县', '3');
INSERT INTO `sys_area` VALUES (2977, 2971, '621025', '正宁县', '3');
INSERT INTO `sys_area` VALUES (2978, 2971, '621026', '宁县', '3');
INSERT INTO `sys_area` VALUES (2979, 2971, '621027', '镇原县', '3');
INSERT INTO `sys_area` VALUES (2980, 2915, '621100', '定西市', '2');
INSERT INTO `sys_area` VALUES (2981, 2980, '621102', '安定区', '3');
INSERT INTO `sys_area` VALUES (2982, 2980, '621121', '通渭县', '3');
INSERT INTO `sys_area` VALUES (2983, 2980, '621122', '陇西县', '3');
INSERT INTO `sys_area` VALUES (2984, 2980, '621123', '渭源县', '3');
INSERT INTO `sys_area` VALUES (2985, 2980, '621124', '临洮县', '3');
INSERT INTO `sys_area` VALUES (2986, 2980, '621125', '漳县', '3');
INSERT INTO `sys_area` VALUES (2987, 2980, '621126', '岷县', '3');
INSERT INTO `sys_area` VALUES (2988, 2915, '621200', '陇南市', '2');
INSERT INTO `sys_area` VALUES (2989, 2988, '621202', '武都区', '3');
INSERT INTO `sys_area` VALUES (2990, 2988, '621221', '成县', '3');
INSERT INTO `sys_area` VALUES (2991, 2988, '621222', '文县', '3');
INSERT INTO `sys_area` VALUES (2992, 2988, '621223', '宕昌县', '3');
INSERT INTO `sys_area` VALUES (2993, 2988, '621224', '康县', '3');
INSERT INTO `sys_area` VALUES (2994, 2988, '621225', '西和县', '3');
INSERT INTO `sys_area` VALUES (2995, 2988, '621226', '礼县', '3');
INSERT INTO `sys_area` VALUES (2996, 2988, '621227', '徽县', '3');
INSERT INTO `sys_area` VALUES (2997, 2988, '621228', '两当县', '3');
INSERT INTO `sys_area` VALUES (2998, 2915, '622900', '临夏回族自治州', '2');
INSERT INTO `sys_area` VALUES (2999, 2998, '622901', '临夏市', '3');
INSERT INTO `sys_area` VALUES (3000, 2998, '622921', '临夏县', '3');
INSERT INTO `sys_area` VALUES (3001, 2998, '622922', '康乐县', '3');
INSERT INTO `sys_area` VALUES (3002, 2998, '622923', '永靖县', '3');
INSERT INTO `sys_area` VALUES (3003, 2998, '622924', '广河县', '3');
INSERT INTO `sys_area` VALUES (3004, 2998, '622925', '和政县', '3');
INSERT INTO `sys_area` VALUES (3005, 2998, '622926', '东乡族自治县', '3');
INSERT INTO `sys_area` VALUES (3006, 2998, '622927', '积石山保安族东乡族撒拉族自治县', '3');
INSERT INTO `sys_area` VALUES (3007, 2915, '623000', '甘南藏族自治州', '2');
INSERT INTO `sys_area` VALUES (3008, 3007, '623001', '合作市', '3');
INSERT INTO `sys_area` VALUES (3009, 3007, '623021', '临潭县', '3');
INSERT INTO `sys_area` VALUES (3010, 3007, '623022', '卓尼县', '3');
INSERT INTO `sys_area` VALUES (3011, 3007, '623023', '舟曲县', '3');
INSERT INTO `sys_area` VALUES (3012, 3007, '623024', '迭部县', '3');
INSERT INTO `sys_area` VALUES (3013, 3007, '623025', '玛曲县', '3');
INSERT INTO `sys_area` VALUES (3014, 3007, '623026', '碌曲县', '3');
INSERT INTO `sys_area` VALUES (3015, 3007, '623027', '夏河县', '3');
INSERT INTO `sys_area` VALUES (3016, -1, '630000', '青海省', '1');
INSERT INTO `sys_area` VALUES (3017, 3016, '630100', '西宁市', '2');
INSERT INTO `sys_area` VALUES (3018, 3017, '630102', '城东区', '3');
INSERT INTO `sys_area` VALUES (3019, 3017, '630103', '城中区', '3');
INSERT INTO `sys_area` VALUES (3020, 3017, '630104', '城西区', '3');
INSERT INTO `sys_area` VALUES (3021, 3017, '630105', '城北区', '3');
INSERT INTO `sys_area` VALUES (3022, 3017, '630121', '大通回族土族自治县', '3');
INSERT INTO `sys_area` VALUES (3023, 3017, '630122', '湟中县', '3');
INSERT INTO `sys_area` VALUES (3024, 3017, '630123', '湟源县', '3');
INSERT INTO `sys_area` VALUES (3025, 3016, '630200', '海东市', '2');
INSERT INTO `sys_area` VALUES (3026, 3025, '630202', '乐都区', '3');
INSERT INTO `sys_area` VALUES (3027, 3025, '630203', '平安区', '3');
INSERT INTO `sys_area` VALUES (3028, 3025, '630222', '民和回族土族自治县', '3');
INSERT INTO `sys_area` VALUES (3029, 3025, '630223', '互助土族自治县', '3');
INSERT INTO `sys_area` VALUES (3030, 3025, '630224', '化隆回族自治县', '3');
INSERT INTO `sys_area` VALUES (3031, 3025, '630225', '循化撒拉族自治县', '3');
INSERT INTO `sys_area` VALUES (3032, 3016, '632200', '海北藏族自治州', '2');
INSERT INTO `sys_area` VALUES (3033, 3032, '632221', '门源回族自治县', '3');
INSERT INTO `sys_area` VALUES (3034, 3032, '632222', '祁连县', '3');
INSERT INTO `sys_area` VALUES (3035, 3032, '632223', '海晏县', '3');
INSERT INTO `sys_area` VALUES (3036, 3032, '632224', '刚察县', '3');
INSERT INTO `sys_area` VALUES (3037, 3016, '632300', '黄南藏族自治州', '2');
INSERT INTO `sys_area` VALUES (3038, 3037, '632321', '同仁县', '3');
INSERT INTO `sys_area` VALUES (3039, 3037, '632322', '尖扎县', '3');
INSERT INTO `sys_area` VALUES (3040, 3037, '632323', '泽库县', '3');
INSERT INTO `sys_area` VALUES (3041, 3037, '632324', '河南蒙古族自治县', '3');
INSERT INTO `sys_area` VALUES (3042, 3016, '632500', '海南藏族自治州', '2');
INSERT INTO `sys_area` VALUES (3043, 3042, '632521', '共和县', '3');
INSERT INTO `sys_area` VALUES (3044, 3042, '632522', '同德县', '3');
INSERT INTO `sys_area` VALUES (3045, 3042, '632523', '贵德县', '3');
INSERT INTO `sys_area` VALUES (3046, 3042, '632524', '兴海县', '3');
INSERT INTO `sys_area` VALUES (3047, 3042, '632525', '贵南县', '3');
INSERT INTO `sys_area` VALUES (3048, 3016, '632600', '果洛藏族自治州', '2');
INSERT INTO `sys_area` VALUES (3049, 3048, '632621', '玛沁县', '3');
INSERT INTO `sys_area` VALUES (3050, 3048, '632622', '班玛县', '3');
INSERT INTO `sys_area` VALUES (3051, 3048, '632623', '甘德县', '3');
INSERT INTO `sys_area` VALUES (3052, 3048, '632624', '达日县', '3');
INSERT INTO `sys_area` VALUES (3053, 3048, '632625', '久治县', '3');
INSERT INTO `sys_area` VALUES (3054, 3048, '632626', '玛多县', '3');
INSERT INTO `sys_area` VALUES (3055, 3016, '632700', '玉树藏族自治州', '2');
INSERT INTO `sys_area` VALUES (3056, 3055, '632701', '玉树市', '3');
INSERT INTO `sys_area` VALUES (3057, 3055, '632722', '杂多县', '3');
INSERT INTO `sys_area` VALUES (3058, 3055, '632723', '称多县', '3');
INSERT INTO `sys_area` VALUES (3059, 3055, '632724', '治多县', '3');
INSERT INTO `sys_area` VALUES (3060, 3055, '632725', '囊谦县', '3');
INSERT INTO `sys_area` VALUES (3061, 3055, '632726', '曲麻莱县', '3');
INSERT INTO `sys_area` VALUES (3062, 3016, '632800', '海西蒙古族藏族自治州', '2');
INSERT INTO `sys_area` VALUES (3063, 3062, '632801', '格尔木市', '3');
INSERT INTO `sys_area` VALUES (3064, 3062, '632802', '德令哈市', '3');
INSERT INTO `sys_area` VALUES (3065, 3062, '632803', '茫崖市', '3');
INSERT INTO `sys_area` VALUES (3066, 3062, '632821', '乌兰县', '3');
INSERT INTO `sys_area` VALUES (3067, 3062, '632822', '都兰县', '3');
INSERT INTO `sys_area` VALUES (3068, 3062, '632823', '天峻县', '3');
INSERT INTO `sys_area` VALUES (3069, -1, '640000', '宁夏回族自治区', '1');
INSERT INTO `sys_area` VALUES (3070, 3069, '640100', '银川市', '2');
INSERT INTO `sys_area` VALUES (3071, 3070, '640104', '兴庆区', '3');
INSERT INTO `sys_area` VALUES (3072, 3070, '640105', '西夏区', '3');
INSERT INTO `sys_area` VALUES (3073, 3070, '640106', '金凤区', '3');
INSERT INTO `sys_area` VALUES (3074, 3070, '640121', '永宁县', '3');
INSERT INTO `sys_area` VALUES (3075, 3070, '640122', '贺兰县', '3');
INSERT INTO `sys_area` VALUES (3076, 3070, '640181', '灵武市', '3');
INSERT INTO `sys_area` VALUES (3077, 3069, '640200', '石嘴山市', '2');
INSERT INTO `sys_area` VALUES (3078, 3077, '640202', '大武口区', '3');
INSERT INTO `sys_area` VALUES (3079, 3077, '640205', '惠农区', '3');
INSERT INTO `sys_area` VALUES (3080, 3077, '640221', '平罗县', '3');
INSERT INTO `sys_area` VALUES (3081, 3069, '640300', '吴忠市', '2');
INSERT INTO `sys_area` VALUES (3082, 3081, '640302', '利通区', '3');
INSERT INTO `sys_area` VALUES (3083, 3081, '640303', '红寺堡区', '3');
INSERT INTO `sys_area` VALUES (3084, 3081, '640323', '盐池县', '3');
INSERT INTO `sys_area` VALUES (3085, 3081, '640324', '同心县', '3');
INSERT INTO `sys_area` VALUES (3086, 3081, '640381', '青铜峡市', '3');
INSERT INTO `sys_area` VALUES (3087, 3069, '640400', '固原市', '2');
INSERT INTO `sys_area` VALUES (3088, 3087, '640402', '原州区', '3');
INSERT INTO `sys_area` VALUES (3089, 3087, '640422', '西吉县', '3');
INSERT INTO `sys_area` VALUES (3090, 3087, '640423', '隆德县', '3');
INSERT INTO `sys_area` VALUES (3091, 3087, '640424', '泾源县', '3');
INSERT INTO `sys_area` VALUES (3092, 3087, '640425', '彭阳县', '3');
INSERT INTO `sys_area` VALUES (3093, 3069, '640500', '中卫市', '2');
INSERT INTO `sys_area` VALUES (3094, 3093, '640502', '沙坡头区', '3');
INSERT INTO `sys_area` VALUES (3095, 3093, '640521', '中宁县', '3');
INSERT INTO `sys_area` VALUES (3096, 3093, '640522', '海原县', '3');
INSERT INTO `sys_area` VALUES (3097, -1, '650000', '新疆维吾尔自治区', '1');
INSERT INTO `sys_area` VALUES (3098, 3097, '650100', '乌鲁木齐市', '2');
INSERT INTO `sys_area` VALUES (3099, 3098, '650102', '天山区', '3');
INSERT INTO `sys_area` VALUES (3100, 3098, '650103', '沙依巴克区', '3');
INSERT INTO `sys_area` VALUES (3101, 3098, '650104', '新市区', '3');
INSERT INTO `sys_area` VALUES (3102, 3098, '650105', '水磨沟区', '3');
INSERT INTO `sys_area` VALUES (3103, 3098, '650106', '头屯河区', '3');
INSERT INTO `sys_area` VALUES (3104, 3098, '650107', '达坂城区', '3');
INSERT INTO `sys_area` VALUES (3105, 3098, '650109', '米东区', '3');
INSERT INTO `sys_area` VALUES (3106, 3098, '650121', '乌鲁木齐县', '3');
INSERT INTO `sys_area` VALUES (3107, 3097, '650200', '克拉玛依市', '2');
INSERT INTO `sys_area` VALUES (3108, 3107, '650202', '独山子区', '3');
INSERT INTO `sys_area` VALUES (3109, 3107, '650203', '克拉玛依区', '3');
INSERT INTO `sys_area` VALUES (3110, 3107, '650204', '白碱滩区', '3');
INSERT INTO `sys_area` VALUES (3111, 3107, '650205', '乌尔禾区', '3');
INSERT INTO `sys_area` VALUES (3112, 3097, '650400', '吐鲁番市', '2');
INSERT INTO `sys_area` VALUES (3113, 3112, '650402', '高昌区', '3');
INSERT INTO `sys_area` VALUES (3114, 3112, '650421', '鄯善县', '3');
INSERT INTO `sys_area` VALUES (3115, 3112, '650422', '托克逊县', '3');
INSERT INTO `sys_area` VALUES (3116, 3097, '650500', '哈密市', '2');
INSERT INTO `sys_area` VALUES (3117, 3116, '650502', '伊州区', '3');
INSERT INTO `sys_area` VALUES (3118, 3116, '650521', '巴里坤哈萨克自治县', '3');
INSERT INTO `sys_area` VALUES (3119, 3116, '650522', '伊吾县', '3');
INSERT INTO `sys_area` VALUES (3120, 3097, '652300', '昌吉回族自治州', '2');
INSERT INTO `sys_area` VALUES (3121, 3120, '652301', '昌吉市', '3');
INSERT INTO `sys_area` VALUES (3122, 3120, '652302', '阜康市', '3');
INSERT INTO `sys_area` VALUES (3123, 3120, '652323', '呼图壁县', '3');
INSERT INTO `sys_area` VALUES (3124, 3120, '652324', '玛纳斯县', '3');
INSERT INTO `sys_area` VALUES (3125, 3120, '652325', '奇台县', '3');
INSERT INTO `sys_area` VALUES (3126, 3120, '652327', '吉木萨尔县', '3');
INSERT INTO `sys_area` VALUES (3127, 3120, '652328', '木垒哈萨克自治县', '3');
INSERT INTO `sys_area` VALUES (3128, 3097, '652700', '博尔塔拉蒙古自治州', '2');
INSERT INTO `sys_area` VALUES (3129, 3128, '652701', '博乐市', '3');
INSERT INTO `sys_area` VALUES (3130, 3128, '652702', '阿拉山口市', '3');
INSERT INTO `sys_area` VALUES (3131, 3128, '652722', '精河县', '3');
INSERT INTO `sys_area` VALUES (3132, 3128, '652723', '温泉县', '3');
INSERT INTO `sys_area` VALUES (3133, 3097, '652800', '巴音郭楞蒙古自治州', '2');
INSERT INTO `sys_area` VALUES (3134, 3133, '652801', '库尔勒市', '3');
INSERT INTO `sys_area` VALUES (3135, 3133, '652822', '轮台县', '3');
INSERT INTO `sys_area` VALUES (3136, 3133, '652823', '尉犁县', '3');
INSERT INTO `sys_area` VALUES (3137, 3133, '652824', '若羌县', '3');
INSERT INTO `sys_area` VALUES (3138, 3133, '652825', '且末县', '3');
INSERT INTO `sys_area` VALUES (3139, 3133, '652826', '焉耆回族自治县', '3');
INSERT INTO `sys_area` VALUES (3140, 3133, '652827', '和静县', '3');
INSERT INTO `sys_area` VALUES (3141, 3133, '652828', '和硕县', '3');
INSERT INTO `sys_area` VALUES (3142, 3133, '652829', '博湖县', '3');
INSERT INTO `sys_area` VALUES (3143, 3097, '652900', '阿克苏地区', '2');
INSERT INTO `sys_area` VALUES (3144, 3143, '652901', '阿克苏市', '3');
INSERT INTO `sys_area` VALUES (3145, 3143, '652922', '温宿县', '3');
INSERT INTO `sys_area` VALUES (3146, 3143, '652923', '库车县', '3');
INSERT INTO `sys_area` VALUES (3147, 3143, '652924', '沙雅县', '3');
INSERT INTO `sys_area` VALUES (3148, 3143, '652925', '新和县', '3');
INSERT INTO `sys_area` VALUES (3149, 3143, '652926', '拜城县', '3');
INSERT INTO `sys_area` VALUES (3150, 3143, '652927', '乌什县', '3');
INSERT INTO `sys_area` VALUES (3151, 3143, '652928', '阿瓦提县', '3');
INSERT INTO `sys_area` VALUES (3152, 3143, '652929', '柯坪县', '3');
INSERT INTO `sys_area` VALUES (3153, 3097, '653000', '克孜勒苏柯尔克孜自治州', '2');
INSERT INTO `sys_area` VALUES (3154, 3153, '653001', '阿图什市', '3');
INSERT INTO `sys_area` VALUES (3155, 3153, '653022', '阿克陶县', '3');
INSERT INTO `sys_area` VALUES (3156, 3153, '653023', '阿合奇县', '3');
INSERT INTO `sys_area` VALUES (3157, 3153, '653024', '乌恰县', '3');
INSERT INTO `sys_area` VALUES (3158, 3097, '653100', '喀什地区', '2');
INSERT INTO `sys_area` VALUES (3159, 3158, '653101', '喀什市', '3');
INSERT INTO `sys_area` VALUES (3160, 3158, '653121', '疏附县', '3');
INSERT INTO `sys_area` VALUES (3161, 3158, '653122', '疏勒县', '3');
INSERT INTO `sys_area` VALUES (3162, 3158, '653123', '英吉沙县', '3');
INSERT INTO `sys_area` VALUES (3163, 3158, '653124', '泽普县', '3');
INSERT INTO `sys_area` VALUES (3164, 3158, '653125', '莎车县', '3');
INSERT INTO `sys_area` VALUES (3165, 3158, '653126', '叶城县', '3');
INSERT INTO `sys_area` VALUES (3166, 3158, '653127', '麦盖提县', '3');
INSERT INTO `sys_area` VALUES (3167, 3158, '653128', '岳普湖县', '3');
INSERT INTO `sys_area` VALUES (3168, 3158, '653129', '伽师县', '3');
INSERT INTO `sys_area` VALUES (3169, 3158, '653130', '巴楚县', '3');
INSERT INTO `sys_area` VALUES (3170, 3158, '653131', '塔什库尔干塔吉克自治县', '3');
INSERT INTO `sys_area` VALUES (3171, 3097, '653200', '和田地区', '2');
INSERT INTO `sys_area` VALUES (3172, 3171, '653201', '和田市', '3');
INSERT INTO `sys_area` VALUES (3173, 3171, '653221', '和田县', '3');
INSERT INTO `sys_area` VALUES (3174, 3171, '653222', '墨玉县', '3');
INSERT INTO `sys_area` VALUES (3175, 3171, '653223', '皮山县', '3');
INSERT INTO `sys_area` VALUES (3176, 3171, '653224', '洛浦县', '3');
INSERT INTO `sys_area` VALUES (3177, 3171, '653225', '策勒县', '3');
INSERT INTO `sys_area` VALUES (3178, 3171, '653226', '于田县', '3');
INSERT INTO `sys_area` VALUES (3179, 3171, '653227', '民丰县', '3');
INSERT INTO `sys_area` VALUES (3180, 3097, '654000', '伊犁哈萨克自治州', '2');
INSERT INTO `sys_area` VALUES (3181, 3180, '654002', '伊宁市', '3');
INSERT INTO `sys_area` VALUES (3182, 3180, '654003', '奎屯市', '3');
INSERT INTO `sys_area` VALUES (3183, 3180, '654004', '霍尔果斯市', '3');
INSERT INTO `sys_area` VALUES (3184, 3180, '654021', '伊宁县', '3');
INSERT INTO `sys_area` VALUES (3185, 3180, '654022', '察布查尔锡伯自治县', '3');
INSERT INTO `sys_area` VALUES (3186, 3180, '654023', '霍城县', '3');
INSERT INTO `sys_area` VALUES (3187, 3180, '654024', '巩留县', '3');
INSERT INTO `sys_area` VALUES (3188, 3180, '654025', '新源县', '3');
INSERT INTO `sys_area` VALUES (3189, 3180, '654026', '昭苏县', '3');
INSERT INTO `sys_area` VALUES (3190, 3180, '654027', '特克斯县', '3');
INSERT INTO `sys_area` VALUES (3191, 3180, '654028', '尼勒克县', '3');
INSERT INTO `sys_area` VALUES (3192, 3097, '654200', '塔城地区', '2');
INSERT INTO `sys_area` VALUES (3193, 3192, '654201', '塔城市', '3');
INSERT INTO `sys_area` VALUES (3194, 3192, '654202', '乌苏市', '3');
INSERT INTO `sys_area` VALUES (3195, 3192, '654221', '额敏县', '3');
INSERT INTO `sys_area` VALUES (3196, 3192, '654223', '沙湾县', '3');
INSERT INTO `sys_area` VALUES (3197, 3192, '654224', '托里县', '3');
INSERT INTO `sys_area` VALUES (3198, 3192, '654225', '裕民县', '3');
INSERT INTO `sys_area` VALUES (3199, 3192, '654226', '和布克赛尔蒙古自治县', '3');
INSERT INTO `sys_area` VALUES (3200, 3097, '654300', '阿勒泰地区', '2');
INSERT INTO `sys_area` VALUES (3201, 3200, '654301', '阿勒泰市', '3');
INSERT INTO `sys_area` VALUES (3202, 3200, '654321', '布尔津县', '3');
INSERT INTO `sys_area` VALUES (3203, 3200, '654322', '富蕴县', '3');
INSERT INTO `sys_area` VALUES (3204, 3200, '654323', '福海县', '3');
INSERT INTO `sys_area` VALUES (3205, 3200, '654324', '哈巴河县', '3');
INSERT INTO `sys_area` VALUES (3206, 3200, '654325', '青河县', '3');
INSERT INTO `sys_area` VALUES (3207, 3200, '654326', '吉木乃县', '3');
INSERT INTO `sys_area` VALUES (3208, 3097, '659001', '石河子市', '3');
INSERT INTO `sys_area` VALUES (3209, 3097, '659002', '阿拉尔市', '3');
INSERT INTO `sys_area` VALUES (3210, 3097, '659003', '图木舒克市', '3');
INSERT INTO `sys_area` VALUES (3211, 3097, '659004', '五家渠市', '3');
INSERT INTO `sys_area` VALUES (3212, 3097, '659005', '北屯市', '3');
INSERT INTO `sys_area` VALUES (3213, 3097, '659006', '铁门关市', '3');
INSERT INTO `sys_area` VALUES (3214, 3097, '659007', '双河市', '3');
INSERT INTO `sys_area` VALUES (3215, 3097, '659008', '可克达拉市', '3');
INSERT INTO `sys_area` VALUES (3216, 3097, '659009', '昆玉市', '3');
INSERT INTO `sys_area` VALUES (3217, -1, '710000', '台湾省', '1');
INSERT INTO `sys_area` VALUES (3218, -1, '810000', '香港特别行政区', '1');
INSERT INTO `sys_area` VALUES (3219, -1, '820000', '澳门特别行政区', '1');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  `parent_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_部门管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation`  (
  `ancestor` int(11) NOT NULL COMMENT '祖先节点',
  `descendant` int(11) NOT NULL COMMENT '后代节点',
  PRIMARY KEY (`ancestor`, `descendant`) USING BTREE,
  INDEX `idx1`(`ancestor`) USING BTREE,
  INDEX `idx2`(`descendant`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_部门关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据值',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签名',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型',
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `sort` int(10) NULL DEFAULT NULL COMMENT '排序（升序）',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_dict_value`(`value`) USING BTREE,
  INDEX `sys_dict_label`(`label`) USING BTREE,
  INDEX `sys_dict_del_flag`(`del_flag`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `type_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典类型值',
  `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典类型名',
  PRIMARY KEY (`type_value`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '日志类型 0-登录日志 1-操作日志',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `service_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务ID',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `remote_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作方式',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '操作提交的数据',
  `time` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '执行时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标记',
  `exception` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作平台',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_log_create_by`(`create_by`) USING BTREE,
  INDEX `sys_log_request_uri`(`request_uri`) USING BTREE,
  INDEX `sys_log_type`(`type`) USING BTREE,
  INDEX `sys_log_create_date`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端URL',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父菜单ID',
  `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `component` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'VUE页面',
  `sort` int(11) NULL DEFAULT 1 COMMENT '排序值',
  `keep_alive` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '0-开启，1- 关闭',
  `client_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端类型 0-运管中心 1-数据中心',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单类型 （0菜单 1按钮）',
  `is_sys` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否系统菜单  0-否 1-是',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '逻辑删除标记(0--正常 1--删除)',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', NULL, '/systemManage', -1, 'icon-xitongguanli', NULL, 120, '0', 'admin', '0', '1', '2020-07-16 10:54:51', '2020-11-10 10:52:53', '0');
INSERT INTO `sys_menu` VALUES (2, '用户管理', NULL, '/systemManage/accountManage', 1, NULL, NULL, 25, '0', 'admin', '1', '1', '2020-07-16 10:55:11', '2020-11-10 10:54:06', '0');
INSERT INTO `sys_menu` VALUES (3, '角色管理', NULL, '/systemManage/roleManage', 1, NULL, NULL, 35, '0', 'admin', '1', '1', '2020-07-16 10:56:33', '2020-11-10 10:55:39', '0');
INSERT INTO `sys_menu` VALUES (4, '菜单管理', NULL, '/systemManage/menuManage', 1, NULL, NULL, 0, '0', 'admin', '1', '0', '2020-07-16 10:56:15', '2020-11-10 10:56:56', '0');
INSERT INTO `sys_menu` VALUES (5, '登录日志', 'sys:log:list', '/systemManage/loginSystemLog', 1, NULL, NULL, 45, '0', 'admin', '1', '0', '2020-07-29 11:58:24', '2020-11-10 11:30:39', '0');
INSERT INTO `sys_menu` VALUES (6, '操作日志', 'sys:log:list', '/systemManage/systemLog', 1, NULL, NULL, 50, '0', 'admin', '1', '1', '2020-07-16 10:55:52', '2020-11-10 10:52:56', '0');
INSERT INTO `sys_menu` VALUES (7, '三方用户', NULL, '/systemManage/userManage', 1, NULL, NULL, 40, '0', 'admin', '1', '0', '2020-07-16 10:56:47', '2020-11-10 10:57:32', '0');
INSERT INTO `sys_menu` VALUES (8, '字典管理', NULL, '/systemManage/dictionaryMaintenance', 1, NULL, NULL, 60, '0', 'admin', '1', '1', '2020-07-16 10:57:05', '2020-11-10 10:57:50', '0');
INSERT INTO `sys_menu` VALUES (9, '版本管理', NULL, '/appManage/editionManage', 1, 'icon-shebeiguanli', NULL, 94, '0', 'admin', '1', '0', '2020-07-16 11:03:20', '2020-11-10 10:58:14', '0');
INSERT INTO `sys_menu` VALUES (10, '开放平台', 'sys:user:open:list', '/openPlatform', 1, 'icon-kaifangpingtai', NULL, 150, '0', 'admin', '1', '0', '2020-11-02 10:01:33', '2020-11-10 10:59:00', '0');
INSERT INTO `sys_menu` VALUES (11, '列表', 'sys:user:list', NULL, 2, NULL, NULL, 10, '0', 'admin', '2', '0', '2020-07-30 14:02:51', '2020-11-10 10:54:45', '0');
INSERT INTO `sys_menu` VALUES (12, '详情', 'sys:user:info', NULL, 2, NULL, NULL, 70, '0', 'admin', '2', '0', '2020-08-08 16:28:53', '2020-11-10 10:53:49', '0');
INSERT INTO `sys_menu` VALUES (13, '新增', 'sys:user:save', NULL, 2, NULL, NULL, 20, '0', 'admin', '2', '0', '2020-07-30 14:03:07', '2020-11-10 10:54:47', '0');
INSERT INTO `sys_menu` VALUES (14, '删除', 'sys:user:delete', NULL, 2, NULL, NULL, 30, '0', 'admin', '2', '0', '2020-07-30 14:03:19', '2020-11-10 10:54:48', '0');
INSERT INTO `sys_menu` VALUES (15, '禁用', 'sys:user:lock', NULL, 2, NULL, NULL, 40, '0', 'admin', '2', '0', '2020-07-30 14:03:45', '2020-11-10 10:54:50', '0');
INSERT INTO `sys_menu` VALUES (16, '重置', 'sys:user:reset', NULL, 2, NULL, NULL, 50, '0', 'admin', '2', '0', '2020-07-30 14:03:59', '2020-11-10 10:54:52', '0');
INSERT INTO `sys_menu` VALUES (17, '修改', 'sys:user:update,sys:user:info', NULL, 2, NULL, NULL, 60, '0', 'admin', '2', '0', '2020-07-30 14:04:09', '2020-11-10 10:54:58', '0');
INSERT INTO `sys_menu` VALUES (18, '列表', 'sys:role:list', NULL, 3, NULL, NULL, 0, '0', 'admin', '2', '0', '2020-07-30 14:05:05', '2020-11-10 11:20:49', '0');
INSERT INTO `sys_menu` VALUES (19, '新增', 'sys:role:save', NULL, 3, NULL, NULL, 10, '0', 'admin', '2', '0', '2020-07-30 14:05:28', '2020-11-10 11:20:51', '0');
INSERT INTO `sys_menu` VALUES (20, '修改', 'sys:role:update,sys:role:info', NULL, 3, NULL, NULL, 12, '0', 'admin', '2', '0', '2020-07-30 14:05:43', '2020-11-10 11:20:52', '0');
INSERT INTO `sys_menu` VALUES (21, '删除', 'sys:role:delete', NULL, 3, NULL, NULL, 30, '0', 'admin', '2', '0', '2020-07-30 14:05:57', '2020-11-10 11:20:56', '0');
INSERT INTO `sys_menu` VALUES (22, '加权限', 'sys:role:authority,sys:role:info', NULL, 3, NULL, NULL, 50, '0', 'admin', '2', '0', '2020-07-30 14:06:43', '2020-11-10 11:21:21', '0');
INSERT INTO `sys_menu` VALUES (23, '新增', 'sys:version:save', NULL, 9, NULL, NULL, 1, '0', 'admin', '2', '0', '2020-07-29 09:55:04', '2020-11-10 11:36:10', '0');
INSERT INTO `sys_menu` VALUES (24, '查看', 'sys:version:info', NULL, 9, NULL, NULL, 10, '0', 'admin', '2', '0', '2020-07-30 13:56:26', '2020-11-10 11:36:11', '0');
INSERT INTO `sys_menu` VALUES (25, '下载', 'sys:version:download', NULL, 9, NULL, NULL, 3, '0', 'admin', '2', '0', '2020-07-30 13:57:00', '2020-11-10 11:36:13', '0');
INSERT INTO `sys_menu` VALUES (26, '列表', 'sys:version:list', NULL, 9, NULL, NULL, 0, '0', 'admin', '2', '0', '2020-07-30 13:57:28', '2020-11-10 11:36:15', '0');
INSERT INTO `sys_menu` VALUES (27, '列表', 'sys:menu:list', NULL, 4, NULL, NULL, 1, '0', 'admin', '2', '0', '2020-07-30 13:59:12', '2020-11-10 11:30:54', '0');
INSERT INTO `sys_menu` VALUES (28, '新增', 'sys:menu:save', NULL, 4, NULL, NULL, 20, '0', 'admin', '2', '0', '2020-07-30 13:59:55', '2020-11-10 11:30:55', '0');
INSERT INTO `sys_menu` VALUES (29, '编辑', 'sys:menu:info,sys:menu:update', NULL, 4, NULL, NULL, 30, '0', 'admin', '2', '0', '2020-07-30 14:00:13', '2020-11-10 11:30:57', '0');
INSERT INTO `sys_menu` VALUES (30, '删除', 'sys:menu:delete', NULL, 4, NULL, NULL, 40, '0', 'admin', '2', '0', '2020-07-30 14:00:26', '2020-11-10 11:30:59', '0');
INSERT INTO `sys_menu` VALUES (31, '列表', 'sys:user:social:list', NULL, 7, NULL, NULL, 0, '0', 'admin', '2', '0', '2020-07-30 14:08:20', '2020-11-10 11:35:35', '0');
INSERT INTO `sys_menu` VALUES (32, '导出数据', 'sys:user:social:export', NULL, 7, NULL, NULL, 10, '0', 'admin', '2', '0', '2020-07-30 14:43:33', '2020-11-10 11:35:37', '0');
INSERT INTO `sys_menu` VALUES (33, '详情', 'sys:user:social:info', NULL, 7, NULL, NULL, 40, '0', 'admin', '2', '0', '2020-07-30 14:43:58', '2020-11-10 11:35:39', '0');
INSERT INTO `sys_menu` VALUES (34, '列表', 'sys:dict:list', NULL, 8, NULL, NULL, 0, '0', 'admin', '2', '0', '2020-07-30 14:44:47', '2020-11-10 11:35:45', '0');
INSERT INTO `sys_menu` VALUES (35, '新增', 'sys:dict:save', NULL, 8, NULL, NULL, 10, '0', 'admin', '2', '0', '2020-07-30 14:45:33', '2020-11-10 11:35:08', '0');
INSERT INTO `sys_menu` VALUES (36, '编辑', 'sys:dict:update,sys:dict:info', NULL, 8, NULL, NULL, 20, '0', 'admin', '2', '0', '2020-07-30 14:45:48', '2020-11-10 11:35:10', '0');
INSERT INTO `sys_menu` VALUES (37, '删除', 'sys:dict:delete', NULL, 8, NULL, NULL, 50, '0', 'admin', '2', '0', '2020-07-30 14:46:00', '2020-11-10 11:35:11', '0');
INSERT INTO `sys_menu` VALUES (38, '字典类型维护', 'sys:dict:type:list', NULL, 8, NULL, NULL, 60, '0', 'admin', '2', '0', '2020-07-30 14:46:52', '2020-11-10 11:35:13', '0');
INSERT INTO `sys_menu` VALUES (39, '字典类型-新增', 'sys:dict:type:save', NULL, 8, NULL, NULL, 65, '0', 'admin', '2', '0', '2020-07-30 14:47:12', '2020-11-10 11:35:15', '0');
INSERT INTO `sys_menu` VALUES (40, '字典类型-编辑', 'sys:dict:type:update', NULL, 8, NULL, NULL, 70, '0', 'admin', '2', '0', '2020-07-30 14:47:34', '2020-11-10 11:35:17', '0');
INSERT INTO `sys_menu` VALUES (41, '字典类型-删除', 'sys:dict:type:delete', NULL, 8, NULL, NULL, 75, '0', 'admin', '2', '0', '2020-07-30 14:47:51', '2020-11-10 11:35:19', '0');
INSERT INTO `sys_menu` VALUES (42, '新增', 'sys:user:open:save', NULL, 10, NULL, NULL, 0, '0', 'admin', '2', '0', '2020-11-02 11:50:34', '2020-11-10 11:36:28', '0');
INSERT INTO `sys_menu` VALUES (43, '企业信息', 'sys:user:open:info', NULL, 10, NULL, NULL, 0, '0', 'admin', '2', '0', '2020-11-02 14:04:50', '2020-11-10 11:36:32', '0');
INSERT INTO `sys_menu` VALUES (44, '锁定/授权', 'sys:user:open:update', NULL, 10, NULL, NULL, 0, '0', 'admin', '2', '0', '2020-11-02 14:05:35', '2020-11-10 11:36:34', '0');
INSERT INTO `sys_menu` VALUES (45, '应用管理', 'sys:open:api:log:list', NULL, 10, NULL, NULL, 0, '0', 'admin', '2', '0', '2020-11-02 14:06:01', '2020-11-10 11:36:36', '0');

-- ----------------------------
-- Table structure for sys_open_api_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_open_api_log`;
CREATE TABLE `sys_open_api_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `open_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '三方key',
  `api_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口路径',
  `request_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '调用请求参数',
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '调用方ip',
  `is_fail` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '调用是否失败 0-否 1-是',
  `response_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '返回结果',
  `time_day` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '调用日期',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '调用时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-开放接口调用记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色代码',
  `role_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`role_id`) USING BTREE,
  INDEX `role_idx1_role_code`(`role_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', 'admin', '系统管理员', '2020-11-10 11:46:21', 1, NULL, '0');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `role_id` int(20) NULL DEFAULT NULL COMMENT '角色ID',
  `dept_id` int(20) NULL DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_角色与部门对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `menu_id` int(11) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_角色菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1, 1);
INSERT INTO `sys_role_menu` VALUES (2, 1, 2);
INSERT INTO `sys_role_menu` VALUES (3, 1, 3);
INSERT INTO `sys_role_menu` VALUES (4, 1, 4);
INSERT INTO `sys_role_menu` VALUES (5, 1, 5);
INSERT INTO `sys_role_menu` VALUES (6, 1, 6);
INSERT INTO `sys_role_menu` VALUES (7, 1, 7);
INSERT INTO `sys_role_menu` VALUES (8, 1, 8);
INSERT INTO `sys_role_menu` VALUES (9, 1, 9);
INSERT INTO `sys_role_menu` VALUES (10, 1, 10);
INSERT INTO `sys_role_menu` VALUES (11, 1, 11);
INSERT INTO `sys_role_menu` VALUES (12, 1, 12);
INSERT INTO `sys_role_menu` VALUES (13, 1, 13);
INSERT INTO `sys_role_menu` VALUES (14, 1, 14);
INSERT INTO `sys_role_menu` VALUES (15, 1, 15);
INSERT INTO `sys_role_menu` VALUES (16, 1, 16);
INSERT INTO `sys_role_menu` VALUES (17, 1, 17);
INSERT INTO `sys_role_menu` VALUES (18, 1, 18);
INSERT INTO `sys_role_menu` VALUES (19, 1, 19);
INSERT INTO `sys_role_menu` VALUES (20, 1, 20);
INSERT INTO `sys_role_menu` VALUES (21, 1, 21);
INSERT INTO `sys_role_menu` VALUES (22, 1, 22);
INSERT INTO `sys_role_menu` VALUES (23, 1, 23);
INSERT INTO `sys_role_menu` VALUES (24, 1, 24);
INSERT INTO `sys_role_menu` VALUES (25, 1, 25);
INSERT INTO `sys_role_menu` VALUES (26, 1, 26);
INSERT INTO `sys_role_menu` VALUES (27, 1, 27);
INSERT INTO `sys_role_menu` VALUES (28, 1, 28);
INSERT INTO `sys_role_menu` VALUES (29, 1, 29);
INSERT INTO `sys_role_menu` VALUES (30, 1, 30);
INSERT INTO `sys_role_menu` VALUES (31, 1, 31);
INSERT INTO `sys_role_menu` VALUES (32, 1, 32);
INSERT INTO `sys_role_menu` VALUES (33, 1, 33);
INSERT INTO `sys_role_menu` VALUES (34, 1, 34);
INSERT INTO `sys_role_menu` VALUES (35, 1, 35);
INSERT INTO `sys_role_menu` VALUES (36, 1, 36);
INSERT INTO `sys_role_menu` VALUES (37, 1, 37);
INSERT INTO `sys_role_menu` VALUES (38, 1, 38);
INSERT INTO `sys_role_menu` VALUES (39, 1, 39);
INSERT INTO `sys_role_menu` VALUES (40, 1, 40);
INSERT INTO `sys_role_menu` VALUES (41, 1, 41);
INSERT INTO `sys_role_menu` VALUES (42, 1, 42);
INSERT INTO `sys_role_menu` VALUES (43, 1, 43);
INSERT INTO `sys_role_menu` VALUES (44, 1, 44);
INSERT INTO `sys_role_menu` VALUES (45, 1, 45);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '姓名',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '随机盐',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '简介',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '头像',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT '部门ID',
  `lock_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，9-锁定',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  `last_time` bigint(20) NULL DEFAULT NULL COMMENT '最后一次登录时间',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `user_idx1_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '超级管理员', 'admin', '045b1f28fff6b9c1c92db1bc2c0d850976f1eef9678ddcd8878664d21ee903d1', '08561247199389773304', '18888888888', 'http://192.168.0.75:8011/electric/20200731/950b945a80614e7ab9cc305c15d31791.jpg', 1, '0', '0', 1604978917, '2019-11-04 22:51:05', NULL, '2020-11-10 11:28:37');

-- ----------------------------
-- Table structure for sys_user_open
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_open`;
CREATE TABLE `sys_user_open`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `open_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开放账户key',
  `open_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开放账户secret',
  `open_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开放账户id集',
  `company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公司名称',
  `contact` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_number` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `business_man` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商务对接人',
  `is_lock` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否锁定 0-否 1-是',
  `is_del` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_open_key`(`open_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_接口开放用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统_用户角色表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
