/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : crm2008

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 13/10/2022 19:00:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_activity
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity`
(
    `id`          char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `owner`       char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `name`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `start_date`  char(10) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `end_date`    char(10) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `cost`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `create_by`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`   char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
INSERT INTO `tbl_activity`
VALUES ('0bb007d015154c098a1fd90856875bff', '06f5fc056eac41558a964f96daa7f27c', '大萨达所按说的', '2022-1-2', '2023-1-1',
        '3.256', '', '2022-10-12 13:24:08', '06f5fc056eac41558a964f96daa7f27c', NULL, NULL);

-- ----------------------------
-- Table structure for tbl_activity_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark`
(
    `id`           char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time`  char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `create_by`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`    char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_flag`    char(1) CHARACTER SET utf8 COLLATE utf8_general_ci      NULL DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
    `activity_id`  char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_clue
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue`
(
    `id`                char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `fullname`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `appellation`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `owner`             char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `company`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `job`               varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `email`             varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `phone`             varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `website`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `mphone`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `state`             varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `source`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_by`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time`       char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`         char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `description`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `contact_summary`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `next_contact_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `address`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_clue_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation`
(
    `id`          char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `clue_id`     char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `activity_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_clue_activity_relation
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_clue_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark`
(
    `id`           char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_by`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time`  char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`    char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_flag`    char(1) CHARACTER SET utf8 COLLATE utf8_general_ci      NULL DEFAULT NULL,
    `clue_id`      char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_clue_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_contacts
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts`
(
    `id`                char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `owner`             char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `source`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `customer_id`       char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `fullname`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `appellation`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `email`             varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `mphone`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `job`               varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_by`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time`       char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`         char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `description`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `contact_summary`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `next_contact_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `address`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_contacts_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation`
(
    `id`          char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `contacts_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `activity_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_contacts_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark`
(
    `id`           char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_by`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time`  char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`    char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_flag`    char(1) CHARACTER SET utf8 COLLATE utf8_general_ci      NULL DEFAULT NULL,
    `contacts_id`  char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_customer
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer`
(
    `id`                char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `owner`             char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `name`              varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `website`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `phone`             varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_by`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time`       char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`         char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `contact_summary`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `next_contact_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `description`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `address`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_customer_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark`
(
    `id`           char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_by`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time`  char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`    char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_flag`    char(1) CHARACTER SET utf8 COLLATE utf8_general_ci      NULL DEFAULT NULL,
    `customer_id`  char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_dic_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type`
(
    `code`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
    `name`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`code`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
INSERT INTO `tbl_dic_type`
VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type`
VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type`
VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type`
VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type`
VALUES ('source', '来源', '');
INSERT INTO `tbl_dic_type`
VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type`
VALUES ('transactionType', '交易类型', '');

-- ----------------------------
-- Table structure for tbl_dic_value
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value`
(
    `id`        char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL COMMENT '主键，采用UUID',
    `value`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
    `text`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '可以为空',
    `order_no`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
    `type_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外键',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
INSERT INTO `tbl_dic_value`
VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value`
VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value`
VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value`
VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value`
VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value`
VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value`
VALUES ('29805c804dd94974b568cfc9017b2e4c', '成交', '成交', '7', 'stage');
INSERT INTO `tbl_dic_value`
VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value`
VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value`
VALUES ('37ef211719134b009e10b7108194cf46', '资质审查', '资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value`
VALUES ('391807b5324d4f16bd58c882750ee632', '丢失的线索', '丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value`
VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value`
VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value`
VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value`
VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value`
VALUES ('68a1b1e814d5497a999b8f1298ace62b', '因竞争丢失关闭', '因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value`
VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value`
VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value`
VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value`
VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value`
VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value`
VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value`
VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value`
VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value`
VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '需求分析', '需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value`
VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value`
VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value`
VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '提案/报价', '提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value`
VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '价值建议', '价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value`
VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value`
VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('e44be1d99158476e8e44778ed36f4355', '确定决策者', '确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value`
VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value`
VALUES ('e81577d9458f4e4192a44650a3a3692b', '谈判/复审', '谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value`
VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value`
VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');

-- ----------------------------
-- Table structure for tbl_tran
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran`
(
    `id`                char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `owner`             char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `money`             varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `name`              varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `expected_date`     char(10) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `customer_id`       char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `stage`             varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `type`              varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `source`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `activity_id`       char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `contacts_id`       char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `create_by`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time`       char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`           varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`         char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `description`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `contact_summary`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `next_contact_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_tran_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history`
(
    `id`            char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `stage`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `money`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `expected_date` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `create_time`   char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `create_by`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `tran_id`       char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_tran_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark`
(
    `id`           char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL,
    `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_by`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `create_time`  char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`    char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_flag`    char(1) CHARACTER SET utf8 COLLATE utf8_general_ci      NULL DEFAULT NULL,
    `tran_id`      char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_tran_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user`
(
    `id`          char(32) CHARACTER SET utf8 COLLATE utf8_general_ci     NOT NULL COMMENT 'uuid\r\n            ',
    `login_act`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `name`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `login_pwd`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
    `email`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `expire_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
    `lock_state`  char(1) CHARACTER SET utf8 COLLATE utf8_general_ci      NULL DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
    `deptno`      char(4) CHARACTER SET utf8 COLLATE utf8_general_ci      NULL DEFAULT NULL,
    `allow_ips`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
    `createTime`  char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `create_by`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `edit_time`   char(19) CHARACTER SET utf8 COLLATE utf8_general_ci     NULL DEFAULT NULL,
    `edit_by`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user`
VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '123', 'ls@163.com', '2023-11-27 21:50:05', '1', 'A001',
        '192.168.1.1,0:0:0:0:0:0:0:1', '2018-11-22 12:11:40', '李四', NULL, NULL);
INSERT INTO `tbl_user`
VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', 'yf123', 'zs@qq.com', '2018-11-30 23:50:55', '1', 'A001',
        '192.168.1.1,192.168.1.2,127.0.0.1,0:0:0:0:0:0:0:1', '2018-11-22 11:37:34', '张三', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
