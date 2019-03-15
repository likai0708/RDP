/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.5.29 : Database - rdp_server
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`rdp_server` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `rdp_server`;

/*Table structure for table `chart_test` */

DROP TABLE IF EXISTS `chart_test`;

CREATE TABLE `chart_test` (
  `id` int(11) NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `val` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `chart_test` */

insert  into `chart_test`(`id`,`model`,`val`,`type`) values (1,'1','100','1');
insert  into `chart_test`(`id`,`model`,`val`,`type`) values (2,'2','200','2');
insert  into `chart_test`(`id`,`model`,`val`,`type`) values (3,'3','300','1');
insert  into `chart_test`(`id`,`model`,`val`,`type`) values (4,'4','400','2');
insert  into `chart_test`(`id`,`model`,`val`,`type`) values (5,'1','500','1');
insert  into `chart_test`(`id`,`model`,`val`,`type`) values (6,'2','600','2');
insert  into `chart_test`(`id`,`model`,`val`,`type`) values (7,'3','700','1');
insert  into `chart_test`(`id`,`model`,`val`,`type`) values (8,'4','800','2');

/*Table structure for table `data_set` */

DROP TABLE IF EXISTS `data_set`;

CREATE TABLE `data_set` (
  `dt_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '数据集编号',
  `dt_name` varchar(80) DEFAULT NULL COMMENT '数据集名称',
  `ds_id` int(11) DEFAULT NULL COMMENT '数据源编号',
  `type` varchar(10) DEFAULT NULL COMMENT '数据集分类',
  `sql` varchar(5000) DEFAULT NULL COMMENT '数据集SQL',
  `data_type` varchar(10) DEFAULT NULL COMMENT '数据来源类型',
  `sts` varchar(1) DEFAULT NULL COMMENT '数据集状态',
  `tx_date` datetime DEFAULT NULL COMMENT '登记日期',
  `up_date` datetime DEFAULT NULL COMMENT '更新日期',
  `tx_op` varchar(30) DEFAULT NULL COMMENT '登记人',
  `up_op` varchar(30) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`dt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='数据集表';

/*Data for the table `data_set` */

insert  into `data_set`(`dt_id`,`dt_name`,`ds_id`,`type`,`sql`,`data_type`,`sts`,`tx_date`,`up_date`,`tx_op`,`up_op`) values (4,'测试SQL',107,'1','select * from db_type','sql','1','2018-09-03 10:24:32','2018-09-04 11:31:01','admin','admin');
insert  into `data_set`(`dt_id`,`dt_name`,`ds_id`,`type`,`sql`,`data_type`,`sts`,`tx_date`,`up_date`,`tx_op`,`up_op`) values (7,'系统日志',107,'rsdb','select * from sys_log','sql','1',NULL,'2018-09-05 14:52:51',NULL,NULL);
insert  into `data_set`(`dt_id`,`dt_name`,`ds_id`,`type`,`sql`,`data_type`,`sts`,`tx_date`,`up_date`,`tx_op`,`up_op`) values (11,'测试数据',107,'rsdb','select * from chart_test','sql','1','2018-09-17 15:15:48','2018-09-17 15:15:48',NULL,NULL);

/*Table structure for table `data_source` */

DROP TABLE IF EXISTS `data_source`;

CREATE TABLE `data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '数据源编号',
  `name` varchar(80) DEFAULT NULL COMMENT '数据源名称',
  `model` varchar(10) DEFAULT NULL COMMENT '数据源种类  json   db',
  `type` varchar(20) DEFAULT NULL COMMENT '数据源类型',
  `version` varchar(10) DEFAULT NULL COMMENT '数据源版本',
  `driver` varchar(100) DEFAULT NULL COMMENT '驱动',
  `addr` varchar(300) DEFAULT NULL COMMENT '地址',
  `user` varchar(100) DEFAULT NULL COMMENT '用户',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `icon` varchar(20) DEFAULT NULL COMMENT '图标',
  `readonly` varchar(1) DEFAULT NULL COMMENT '只读',
  `sts` varchar(1) DEFAULT NULL COMMENT '状态',
  `tx_date` datetime DEFAULT NULL COMMENT '登记日期',
  `up_date` datetime DEFAULT NULL COMMENT '更新日期',
  `tx_op` varchar(30) DEFAULT NULL COMMENT '登记人',
  `up_op` varchar(30) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 COMMENT='数据源表';

/*Data for the table `data_source` */

insert  into `data_source`(`id`,`name`,`model`,`type`,`version`,`driver`,`addr`,`user`,`password`,`icon`,`readonly`,`sts`,`tx_date`,`up_date`,`tx_op`,`up_op`) values (121,'report_demo','rsdb','mysql',NULL,'com.mysql.jdbc.Driver','jdbc:mysql://127.0.0.1:3378/report_demo','root','root','MySql','0','1',NULL,'2018-11-28 11:20:33',NULL,'admin');
insert  into `data_source`(`id`,`name`,`model`,`type`,`version`,`driver`,`addr`,`user`,`password`,`icon`,`readonly`,`sts`,`tx_date`,`up_date`,`tx_op`,`up_op`) values (148,'天气','json','json',NULL,NULL,'http://t.weather.sojson.com/api/weather/city/101030100',NULL,NULL,'Json',NULL,'1',NULL,'2018-11-16 14:49:14',NULL,'admin');
insert  into `data_source`(`id`,`name`,`model`,`type`,`version`,`driver`,`addr`,`user`,`password`,`icon`,`readonly`,`sts`,`tx_date`,`up_date`,`tx_op`,`up_op`) values (161,'jnreport_demo','jndi','mysql',NULL,NULL,'java:comp/env/jdbc/report_demo',NULL,NULL,'Jndi','1','1',NULL,'2018-11-30 10:44:48',NULL,'admin');

/*Table structure for table `db_type` */

DROP TABLE IF EXISTS `db_type`;

CREATE TABLE `db_type` (
  `id` int(11) NOT NULL COMMENT '类型编号',
  `name` varchar(80) DEFAULT NULL COMMENT '类型名称',
  `model` varchar(20) DEFAULT NULL COMMENT '数据类型大类',
  `type` varchar(20) DEFAULT NULL COMMENT '支持类型',
  `driver` varchar(100) DEFAULT NULL COMMENT '数据库驱动',
  `addr_demo` varchar(120) DEFAULT NULL COMMENT '数据库地址例子',
  `sts` varchar(1) DEFAULT NULL COMMENT '状态',
  `icon` varchar(80) DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据库支持类型';

/*Data for the table `db_type` */

insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (101,'MySql','rsdb','mysql','com.mysql.jdbc.Driver','jdbc:mysql://<host>:<port>/<database_name>','1','MySql');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (201,'Oracle','rsdb','oracle','oracle.jdbc.driver.OracleDriver','jdbc:oracle:thin:@//<host>:<port>:<ServiceName>','1','Oracle');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (301,'Db2 type2','rsdb','db2','com.ibm.db2.jcc.DB2Driver','jdbc:db2:<database_name>','1','Db2 type2');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (302,'Db2 type4','rsdb','db2','com.ibm.db2.jcc.DB2Driver','jdbc:db2://<host>[:<port>]/<database_name>','1','Db2 type4');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (401,'SQL Server 2000','rsdb','sqlserver','com.microsoft.jdbc.sqlserver.SQLServerDriver','jdbc:microsoft:sqlserver://:','0','SqlServer');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (402,'SQL Server 2005','rsdb','sqlserver','com.microsoft.sqlserver.jdbc.SQLServerDriver','jdbc:sqlserver://<server_name>:<port>;DatabaseName=<DatabaseName>','1','SqlServer');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (501,'Sybase','rsdb','sysbase','com.sybase.jdbc3.jdbc.SybDriver','jdbc:sybase:Tds::','0','Sybase');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (601,'PostgreSQL','rsdb','postgresql','org.postgresql.Driver','jdbc:postgresql://:/','1','PostgreSQL');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (701,'SQLite','rsdb','sqlite','org.sqlite.JDBC','jdbc:sqlite:D:\\\\xxxdatabase.db','0','SQLite');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (801,'MongoDB','nosqldb','mongodb',NULL,'mongodb://userName:password@host/?authSource=databaseName&amp;ssh=false','0','MongoDB');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (901,'Xml','file','xml',NULL,NULL,'0','Xml');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (902,'API请求','file','json',NULL,NULL,'1','Json');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (903,'Csv','file','csv',NULL,NULL,'0','Csv');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (904,'Excel','file','excel',NULL,NULL,'0','Excel');
insert  into `db_type`(`id`,`name`,`model`,`type`,`driver`,`addr_demo`,`sts`,`icon`) values (1001,'JNDI','jndi','jndi','','','1','Jndi');

/*Table structure for table `demo_user` */

DROP TABLE IF EXISTS `demo_user`;

CREATE TABLE `demo_user` (
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `user_name` varchar(80) DEFAULT NULL COMMENT '用户名称',
  `user_org` varchar(20) DEFAULT NULL COMMENT '用户机构',
  `user_org_name` varchar(80) DEFAULT NULL COMMENT '机构名称',
  `wages` double DEFAULT NULL COMMENT '薪资',
  `position` varchar(30) DEFAULT NULL COMMENT '职位',
  `reg_date` varchar(8) DEFAULT NULL COMMENT '登记日期',
  `user_tel` varchar(30) DEFAULT NULL COMMENT '电话',
  `user_addr` varchar(80) DEFAULT NULL COMMENT '地址',
  `user_post` varchar(6) DEFAULT NULL COMMENT '邮编',
  `user_sts` varchar(1) DEFAULT NULL COMMENT '用户状态',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='演示用户表';

/*Data for the table `demo_user` */

insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (1,'申志强','100101','综合部',15000,'人力资源','20141024','13403555190','辽宁','047300','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (111,'王建国','100101','综合部',16000,'人力资源','20141113','15364758000','北京','046000','0');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (112,'张义芳','100101','综合部',20000,'人力资源','20141117','15935538888','河南','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (113,'原琼','100101','综合部',20000.5,'人力资源','20141208','13333550900','北京','046000','0');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (114,'马惠军','100102','财务部',12000,'财务经理','20141015','13383458811','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (115,'武继宏','100102','财务部',13500,'财务经理','20140707','13834776068','山西','046000','2');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (116,'宋利敏','100103','风险部',8000,'风控经理','20140707','15234556806','北京','046000','0');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (117,'王冀玲','100103','风险部',10000,'风控经理','20140707','13333554333','山东','047300','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (118,'李燕红','100104','资金部',50000,'资金经理','20140707','13333550900','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (119,'郑  强','100104','资金部',16000,'资金经理','20140707','13383458811','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (121,'冯  莅','100105','业务部',20000,'客户经理','20140707','13834776068','天津','046000','0');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (122,'李静','100105','业务部',20000.5,'客户经理','20140707','15234556806','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (123,'卫晓勤','100108','总裁办',12000,'总助','20140707','13333554333','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (124,'张源','100103','风险部',13500,'风控经理','20140707','13333550900','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (125,'冯浩','100103','风险部',8000,'风控经理','20140707','13383458811','河北','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (126,'张亚强','100104','资金部',10000,'资金经理','20140707','15392555666','石家庄','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (127,'靳伟','100104','资金部',50000,'资金经理','20140707','13994675055','河北','047300','0');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (128,'倪刚','100105','业务部',10000,'客户经理','20140707','13720964398','石家庄','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (129,'王泓杰','100105','业务部',16000,'客户经理','20140707','18625504986','石家庄','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (130,'李晓波','100105','业务部',20000,'客户经理','20140707','13935513232','河北','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (131,'张洋铭','100105','业务部',20000.5,'客户经理','20111219','15234699068','石家庄','046100','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (132,'宋东','100105','业务部',12000,'客户经理','20111219','13453515589','辽宁','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (133,'李淑荣','100105','业务部',13500,'客户经理','20111222','13283557468','北京','046000','3');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (134,'马垒布','100105','业务部',8000,'客户经理','20111223','18003456655','河南','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (135,'陈和平','100105','业务部',10000,'客户经理','20111228','18635531186','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (136,'叶昌银','100105','业务部',16000,'客户经理','20111229','13203558555','北京','047300','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (137,'王增','100105','业务部',20000,'客户经理','20120116','15835557732','山西','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (138,'梁姝丽','100105','业务部',20000.5,'客户经理','20120118','13453535388','北京','046000','4');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (139,'申亚丽','100105','业务部',12000,'客户经理','20120118','18635559721','山东','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (141,'牛彩红','100105','业务部',13500,'客户经理','20120119','13835567286','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (142,'陈玉芬','100105','业务部',8000,'客户经理','20120208','18636510130','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (143,'秦虎明','100105','业务部',10000,'客户经理','20120221','15935502225','天津','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (144,'卢风莲','100105','业务部',50000,'客户经理','20120301','13509753890','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (145,'李静','100103','风险部',10000,'风控经理','20120302','18636518169','北京','047300','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (146,'申建文','100103','风险部',10000,'风控经理','20120328','13467048348','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (147,'王慧芳','100104','资金部',10000,'资金经理','20120328','13233363689','河北','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (148,'马建刚','100104','资金部',10000,'资金经理','20131017','18235562999','石家庄','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (149,'孛森润','100101','综合部',10000,'人力资源','20131018','13096666703','河北','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (151,'宋拴琴','100101','综合部',10000,'人力资源','20131028','13994659670','石家庄','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (152,'姜旭军','100101','综合部',10001.5,'综合部总监','20131030','18636518186','石家庄','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (153,'丁路广','100102','财务部',15000,'财务部出纳','20130805','15534555586','辽宁','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (154,'陈连胜','100102','财务部',16000,'财务部总监','20130805','18903452550','北京','047300','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (155,'苗艳芳','100103','风险部',20000,'风控经理','20130829','13994633133','河南','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (156,'张俊莲','100103','风险部',20000.5,'风控总监','20130829','13994631297','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (157,'陈永庆','100104','资金部',12000,'资金经理','20130917','15534578988','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (158,'李晓飞','100104','资金部',13500,'资金总监','20130917','15935533271','山西','046100','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (159,'葛明伟','100105','业务部',8000,'客户经理','20130927','18635550586','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (160,'王金才','100105','业务部',10000,'业务总监','20131010','15035554586','山东','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (161,'王炜','100108','总裁办',50000,'总裁CEO','20140409','13333550900','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (162,'张亚楠','100108','总裁办',50000,'总助','20140409','13383458811','北京','046000','1');
insert  into `demo_user`(`user_id`,`user_name`,`user_org`,`user_org_name`,`wages`,`position`,`reg_date`,`user_tel`,`user_addr`,`user_post`,`user_sts`) values (163,'段卫军','100105','业务部',8000,'客户经理','20140409','13513553121','天津','047300','1');

/*Table structure for table `ds_showcol` */

DROP TABLE IF EXISTS `ds_showcol`;

CREATE TABLE `ds_showcol` (
  `show_id` int(11) NOT NULL COMMENT '显示编号',
  `dt_id` int(11) DEFAULT NULL COMMENT '数据集编号',
  `use_id` int(11) DEFAULT NULL COMMENT '引用表编号',
  `is_show` varchar(1) DEFAULT NULL COMMENT '是否显示',
  `data_type` varchar(10) DEFAULT NULL COMMENT '数据类型',
  `alias` varchar(80) DEFAULT NULL COMMENT '别名',
  `describe` varchar(200) DEFAULT NULL COMMENT '描述',
  `tx_date` datetime DEFAULT NULL COMMENT '创建时间',
  `tx_op` varchar(255) DEFAULT NULL COMMENT '登记人',
  PRIMARY KEY (`show_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据集表显示字段表';

/*Data for the table `ds_showcol` */

/*Table structure for table `dt_filter` */

DROP TABLE IF EXISTS `dt_filter`;

CREATE TABLE `dt_filter` (
  `filter_id` int(11) NOT NULL COMMENT '过滤编号',
  `dt_id` int(11) DEFAULT NULL COMMENT '数据集编号',
  `table_name` varchar(80) DEFAULT NULL COMMENT '过滤表名',
  `column` varchar(30) DEFAULT NULL COMMENT '过滤字段',
  `col_type` varchar(1) DEFAULT NULL COMMENT '操作符',
  `operator` varchar(10) DEFAULT NULL,
  `param_type` varchar(1) DEFAULT NULL COMMENT '参数数据类型',
  `param` varchar(30) DEFAULT NULL COMMENT '参数',
  `tx_date` datetime DEFAULT NULL COMMENT '登记日期',
  `up_date` datetime DEFAULT NULL COMMENT '更新日期',
  `tx_op` varchar(30) DEFAULT NULL COMMENT '登记人',
  `up_op` varchar(30) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据集过滤';

/*Data for the table `dt_filter` */

/*Table structure for table `dt_param` */

DROP TABLE IF EXISTS `dt_param`;

CREATE TABLE `dt_param` (
  `param_id` int(11) NOT NULL COMMENT '参数编号',
  `param_name` varchar(80) DEFAULT NULL COMMENT '参数名称',
  `dt_id` int(11) DEFAULT NULL COMMENT '数据集编号',
  `param_type` varchar(255) DEFAULT NULL COMMENT '参数类型',
  `data_type` varchar(255) DEFAULT NULL COMMENT '数据类型',
  `if_values` varchar(1) DEFAULT NULL COMMENT '是否多值',
  `tx_date` datetime DEFAULT NULL COMMENT '登记日期',
  `up_date` datetime DEFAULT NULL COMMENT '更新日期',
  `tx_op` varchar(30) DEFAULT NULL COMMENT '登记人',
  `up_op` varchar(30) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`param_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据集参数表';

/*Data for the table `dt_param` */

/*Table structure for table `dt_table` */

DROP TABLE IF EXISTS `dt_table`;

CREATE TABLE `dt_table` (
  `use_id` int(11) NOT NULL COMMENT '编号',
  `dt_id` int(11) NOT NULL COMMENT '数据集编号',
  `table_name` varchar(80) DEFAULT NULL COMMENT '表名',
  `table_comments` varchar(120) DEFAULT NULL COMMENT '表说明',
  `level` varchar(1) DEFAULT NULL COMMENT '层级',
  `show_name` varchar(80) DEFAULT NULL COMMENT '显示名称',
  `px` int(11) DEFAULT NULL COMMENT '横向位置',
  `py` int(11) DEFAULT NULL COMMENT '纵向位置',
  `tx_date` datetime DEFAULT NULL COMMENT '登记日期',
  `up_date` datetime DEFAULT NULL COMMENT '更新日期',
  `tx_op` varchar(30) DEFAULT NULL COMMENT '登记人',
  `up_op` varchar(30) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`use_id`,`dt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='据集使用表';

/*Data for the table `dt_table` */

/*Table structure for table `dt_table_rs` */

DROP TABLE IF EXISTS `dt_table_rs`;

CREATE TABLE `dt_table_rs` (
  `rs_id` int(11) NOT NULL COMMENT '关系编号',
  `use_id` int(11) NOT NULL COMMENT '引用编号',
  `rs_type` varchar(10) DEFAULT NULL COMMENT '关系类型(union/join)',
  `rs_model` varchar(1) DEFAULT NULL COMMENT '关系模式',
  `tx_date` datetime DEFAULT NULL COMMENT '登记日期',
  `up_date` datetime DEFAULT NULL COMMENT '更新日期',
  `tx_op` varchar(30) DEFAULT NULL COMMENT '登记人',
  `up_op` varchar(30) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`rs_id`,`use_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据集引用表关系表';

/*Data for the table `dt_table_rs` */

/*Table structure for table `dt_table_rs_condition` */

DROP TABLE IF EXISTS `dt_table_rs_condition`;

CREATE TABLE `dt_table_rs_condition` (
  `cd_id` int(11) NOT NULL COMMENT '关系编号',
  `cd_type` varchar(10) DEFAULT NULL COMMENT '关系类型',
  `rename` varchar(255) DEFAULT NULL COMMENT '输出名称',
  `left_table` varchar(255) DEFAULT NULL COMMENT '左侧表',
  `left_col` varchar(255) DEFAULT NULL COMMENT '左侧字段',
  `operator` varchar(255) DEFAULT NULL COMMENT '操作符',
  `right_table` varchar(255) DEFAULT NULL COMMENT '右侧表',
  `right_col` varchar(255) DEFAULT NULL COMMENT '右侧字段',
  `tx_date` datetime DEFAULT NULL COMMENT '创建时间',
  `tx_op` varchar(255) DEFAULT NULL COMMENT '登记人',
  PRIMARY KEY (`cd_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据集表关系表';

/*Data for the table `dt_table_rs_condition` */

/*Table structure for table `dtl` */

DROP TABLE IF EXISTS `dtl`;

CREATE TABLE `dtl` (
  `nian` varchar(11) DEFAULT NULL,
  `yue` varchar(2) DEFAULT NULL,
  `dian` varchar(10) DEFAULT NULL,
  `shui` varchar(10) DEFAULT NULL,
  `yuefei` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dtl` */

insert  into `dtl`(`nian`,`yue`,`dian`,`shui`,`yuefei`) values ('2015','1','128.50','68','11');
insert  into `dtl`(`nian`,`yue`,`dian`,`shui`,`yuefei`) values ('2015','2','99.00','60','12');
insert  into `dtl`(`nian`,`yue`,`dian`,`shui`,`yuefei`) values ('2015','3','238.50','90','13');
insert  into `dtl`(`nian`,`yue`,`dian`,`shui`,`yuefei`) values ('2015','4','430.00','120','14');
insert  into `dtl`(`nian`,`yue`,`dian`,`shui`,`yuefei`) values ('2016','1','328.00','150','15');
insert  into `dtl`(`nian`,`yue`,`dian`,`shui`,`yuefei`) values ('2016','2','266.50','72','16');
insert  into `dtl`(`nian`,`yue`,`dian`,`shui`,`yuefei`) values ('2014','1','180.50','76','17');
insert  into `dtl`(`nian`,`yue`,`dian`,`shui`,`yuefei`) values ('2014','2','200.50','89','18');
insert  into `dtl`(`nian`,`yue`,`dian`,`shui`,`yuefei`) values ('2014','3','219.00','28','19');

/*Table structure for table `dtlc` */

DROP TABLE IF EXISTS `dtlc`;

CREATE TABLE `dtlc` (
  `nianc` varchar(11) DEFAULT NULL,
  `yuec` varchar(2) DEFAULT NULL,
  `dianc` varchar(10) DEFAULT NULL,
  `shuic` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dtlc` */

insert  into `dtlc`(`nianc`,`yuec`,`dianc`,`shuic`) values ('2015','1','11.50','36');
insert  into `dtlc`(`nianc`,`yuec`,`dianc`,`shuic`) values ('2015','2','87.50','28');
insert  into `dtlc`(`nianc`,`yuec`,`dianc`,`shuic`) values ('2015','3','90.00','60');
insert  into `dtlc`(`nianc`,`yuec`,`dianc`,`shuic`) values ('2015','4','78.50','30');
insert  into `dtlc`(`nianc`,`yuec`,`dianc`,`shuic`) values ('2016','1','120.50','80');
insert  into `dtlc`(`nianc`,`yuec`,`dianc`,`shuic`) values ('2016','2','216.00','110');
insert  into `dtlc`(`nianc`,`yuec`,`dianc`,`shuic`) values ('2014','1','29.00','85');
insert  into `dtlc`(`nianc`,`yuec`,`dianc`,`shuic`) values ('2014','2','59.50','98');
insert  into `dtlc`(`nianc`,`yuec`,`dianc`,`shuic`) values ('2014','3','108.50','120');

/*Table structure for table `sys_config` */

DROP TABLE IF EXISTS `sys_config`;

CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `param_key` (`param_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统配置信息表';

/*Data for the table `sys_config` */

insert  into `sys_config`(`id`,`param_key`,`param_value`,`status`,`remark`) values (1,'CLOUD_STORAGE_CONFIG_KEY','{\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunEndPoint\":\"\",\"aliyunPrefix\":\"\",\"qcloudBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"type\":1}',0,'云存储配置信息');

/*Table structure for table `sys_dept` */

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='部门管理';

/*Data for the table `sys_dept` */

insert  into `sys_dept`(`dept_id`,`parent_id`,`name`,`order_num`,`del_flag`) values (1,0,'总部',0,0);
insert  into `sys_dept`(`dept_id`,`parent_id`,`name`,`order_num`,`del_flag`) values (2,1,'大连分公司',1,0);
insert  into `sys_dept`(`dept_id`,`parent_id`,`name`,`order_num`,`del_flag`) values (3,2,'研发部',3,0);

/*Table structure for table `sys_dict` */

DROP TABLE IF EXISTS `sys_dict`;

CREATE TABLE `sys_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '字典名称',
  `type` varchar(100) NOT NULL COMMENT '字典类型',
  `code` varchar(100) NOT NULL COMMENT '字典码',
  `value` varchar(1000) NOT NULL COMMENT '字典值',
  `order_num` int(11) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '删除标记  -1：已删除  0：正常',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='数据字典表';

/*Data for the table `sys_dict` */

insert  into `sys_dict`(`id`,`name`,`type`,`code`,`value`,`order_num`,`remark`,`del_flag`) values (1,'性别','sex','0','女',0,NULL,0);
insert  into `sys_dict`(`id`,`name`,`type`,`code`,`value`,`order_num`,`remark`,`del_flag`) values (2,'性别','sex','1','男',1,NULL,0);
insert  into `sys_dict`(`id`,`name`,`type`,`code`,`value`,`order_num`,`remark`,`del_flag`) values (3,'性别','sex','2','未知',3,NULL,0);

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8 COMMENT='系统日志';

/*Data for the table `sys_log` */

insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (1,'1','1','1','1',1,'1','2018-09-06 14:54:06');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (2,'2','2','2','2',2,'2','2018-09-06 14:54:23');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (32,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":41,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据源表\",\"url\":\"modules/ser/datasource.html\",\"type\":1,\"icon\":\"fa fa-table\",\"orderNum\":6}',52,'0:0:0:0:0:0:0:1','2018-09-27 09:23:27');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (33,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":41,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据源表\",\"url\":\"modules/ser/datasource.html\",\"type\":1,\"icon\":\"fa fa-database\",\"orderNum\":6}',24,'0:0:0:0:0:0:0:1','2018-09-27 09:25:38');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (34,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":47,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集表\",\"url\":\"modules/ser/dataset.html\",\"type\":1,\"icon\":\"fa fa-cubes\",\"orderNum\":6}',35,'0:0:0:0:0:0:0:1','2018-09-27 09:26:48');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (35,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":41,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据源\",\"url\":\"modules/ser/datasource.html\",\"type\":1,\"icon\":\"fa fa-database\",\"orderNum\":6}',25,'0:0:0:0:0:0:0:1','2018-09-27 09:26:58');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (36,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":47,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集\",\"url\":\"modules/ser/dataset.html\",\"type\":1,\"icon\":\"fa fa-cubes\",\"orderNum\":6}',25,'0:0:0:0:0:0:0:1','2018-09-27 09:27:08');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (37,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":57,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集表显示字段\",\"url\":\"modules/ser/dsshowcol.html\",\"type\":1,\"icon\":\"fa fa-file-code-o\",\"orderNum\":6}',28,'0:0:0:0:0:0:0:1','2018-09-27 09:28:05');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (38,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":72,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集参数\",\"url\":\"modules/ser/dtparam.html\",\"type\":1,\"icon\":\"fa fa-file-code-o\",\"orderNum\":6}',42,'0:0:0:0:0:0:0:1','2018-09-27 09:28:12');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (39,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":82,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集引用表关系\",\"url\":\"modules/ser/dttablers.html\",\"type\":1,\"icon\":\"fa fa-file-code-o\",\"orderNum\":6}',32,'0:0:0:0:0:0:0:1','2018-09-27 09:28:21');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (40,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":87,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集表关系\",\"url\":\"modules/ser/dttablerscondition.html\",\"type\":1,\"icon\":\"fa fa-file-code-o\",\"orderNum\":6}',33,'0:0:0:0:0:0:0:1','2018-09-27 09:28:29');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (41,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":77,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"据集使用\",\"url\":\"modules/ser/dttable.html\",\"type\":1,\"icon\":\"fa fa-file-code-o\",\"orderNum\":6}',28,'0:0:0:0:0:0:0:1','2018-09-27 09:28:38');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (42,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":92,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"设计器\",\"type\":0,\"icon\":\"fa fa-paper-plane\",\"orderNum\":0}',58,'0:0:0:0:0:0:0:1','2018-09-30 08:59:29');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (43,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":93,\"parentId\":92,\"parentName\":\"设计器\",\"name\":\"大屏设计器\",\"url\":\"/modules/bddp/design.html\",\"type\":1,\"icon\":\"fa fa-pencil-square-o\",\"orderNum\":0}',21,'0:0:0:0:0:0:0:1','2018-09-30 09:00:41');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (44,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":92,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"设计器\",\"type\":0,\"icon\":\"fa fa-paper-plane\",\"orderNum\":100}',28,'0:0:0:0:0:0:0:1','2018-09-30 09:00:58');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (45,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":93,\"parentId\":92,\"parentName\":\"设计器\",\"name\":\"大屏设计器\",\"url\":\"./modules/bddp/design.html\",\"type\":1,\"icon\":\"fa fa-pencil-square-o\",\"orderNum\":0}',39,'0:0:0:0:0:0:0:1','2018-09-30 09:01:37');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (46,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":93,\"parentId\":92,\"parentName\":\"设计器\",\"name\":\"大屏设计器\",\"url\":\"./modules/bddp/design.html\",\"type\":1,\"icon\":\"fa fa-pencil-square-o\",\"orderNum\":0,\"openMode\":\"_blank\"}',49,'0:0:0:0:0:0:0:1','2018-09-30 09:26:31');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (47,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":2,\"parentId\":1,\"parentName\":\"系统管理\",\"name\":\"管理员管理\",\"url\":\"modules/sys/user.html\",\"type\":1,\"icon\":\"fa fa-user\",\"orderNum\":1,\"openMode\":\"_parent\"}',18,'0:0:0:0:0:0:0:1','2018-09-30 10:26:27');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (48,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":2,\"parentId\":1,\"parentName\":\"系统管理\",\"name\":\"管理员管理\",\"url\":\"modules/sys/user.html\",\"type\":1,\"icon\":\"fa fa-user\",\"orderNum\":1,\"openMode\":\"_self\"}',681,'0:0:0:0:0:0:0:1','2018-09-30 10:33:27');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (49,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":87,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集表关系\",\"url\":\"modules/ser/dttablerscondition.html\",\"type\":1,\"icon\":\"iconfont icon-ht_expand\",\"orderNum\":6,\"openMode\":\"_self\"}',63,'0:0:0:0:0:0:0:1','2018-10-08 09:18:30');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (50,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":87,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集表关系\",\"url\":\"modules/ser/dttablerscondition.html\",\"type\":1,\"icon\":\"iconfonticon-ht_expand\",\"orderNum\":6,\"openMode\":\"_self\"}',23,'0:0:0:0:0:0:0:1','2018-10-08 09:19:58');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (51,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":87,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集表关系\",\"url\":\"modules/ser/dttablerscondition.html\",\"type\":1,\"icon\":\"\",\"orderNum\":6,\"openMode\":\"_self\"}',18,'0:0:0:0:0:0:0:1','2018-10-08 09:20:07');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (52,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":87,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集表关系\",\"url\":\"modules/ser/dttablerscondition.html\",\"type\":1,\"icon\":\"rdpicon-jiqixuexi-\",\"orderNum\":6,\"openMode\":\"_self\"}',36,'0:0:0:0:0:0:0:1','2018-10-08 09:33:30');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (53,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":87,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集表关系\",\"url\":\"modules/ser/dttablerscondition.html\",\"type\":1,\"icon\":\"rdp rdpicon-jiqixuexi-\",\"orderNum\":6,\"openMode\":\"_self\"}',26,'0:0:0:0:0:0:0:1','2018-10-08 09:34:02');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (54,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":82,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集引用表关系\",\"url\":\"modules/ser/dttablers.html\",\"type\":1,\"icon\":\"rdp rdpicon-guanxi1\",\"orderNum\":6,\"openMode\":\"_self\"}',1073,'0:0:0:0:0:0:0:1','2018-10-08 09:37:48');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (55,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":52,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据库支持类型\",\"url\":\"modules/ser/dbtype.html\",\"type\":1,\"icon\":\"rdp rdpicon-leixing1\",\"orderNum\":6,\"openMode\":\"_self\"}',45,'0:0:0:0:0:0:0:1','2018-10-08 09:42:12');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (56,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":62,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集过滤\",\"url\":\"modules/ser/dtfilter.html\",\"type\":1,\"icon\":\"rdp rdpicon-guolvtiaojianxuanze\",\"orderNum\":6,\"openMode\":\"_self\"}',57,'0:0:0:0:0:0:0:1','2018-10-08 09:45:20');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (57,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":57,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集表显示字段\",\"url\":\"modules/ser/dsshowcol.html\",\"type\":1,\"icon\":\"rdp rdpicon-ziduan1\",\"orderNum\":6,\"openMode\":\"_self\"}',61,'0:0:0:0:0:0:0:1','2018-10-08 09:45:41');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (58,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":72,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集参数\",\"url\":\"modules/ser/dtparam.html\",\"type\":1,\"icon\":\"rdp rdpicon-canshu\",\"orderNum\":6,\"openMode\":\"_self\"}',22,'0:0:0:0:0:0:0:1','2018-10-08 09:46:10');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (59,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":77,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"据集使用\",\"url\":\"modules/ser/dttable.html\",\"type\":1,\"icon\":\"rdp rdpicon-shubiao\",\"orderNum\":6,\"openMode\":\"_self\"}',25,'0:0:0:0:0:0:0:1','2018-10-08 09:49:15');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (60,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":95,\"parentId\":1,\"parentName\":\"系统管理\",\"name\":\"授权信息\",\"url\":\"grant/info\",\"perms\":\"grant:info\",\"type\":1,\"icon\":\"\",\"orderNum\":0,\"openMode\":\"_self\"}',112,'0:0:0:0:0:0:0:1','2018-10-09 14:25:38');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (61,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":95,\"parentId\":1,\"parentName\":\"系统管理\",\"name\":\"授权信息\",\"url\":\"modules/grant/info\",\"perms\":\"grant:info\",\"type\":1,\"icon\":\"fa fa-shield\",\"orderNum\":0,\"openMode\":\"_self\"}',38,'0:0:0:0:0:0:0:1','2018-10-09 14:31:52');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (62,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":95,\"parentId\":1,\"parentName\":\"系统管理\",\"name\":\"授权信息\",\"url\":\"modules/grant/info\",\"perms\":\"grant:info\",\"type\":1,\"icon\":\"fa fa-shield\",\"orderNum\":99,\"openMode\":\"_self\"}',20,'0:0:0:0:0:0:0:1','2018-10-09 14:32:06');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (63,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":95,\"parentId\":1,\"parentName\":\"系统管理\",\"name\":\"授权信息\",\"url\":\"ActivationServletReport\",\"perms\":\"grant:info\",\"type\":1,\"icon\":\"fa fa-shield\",\"orderNum\":99,\"openMode\":\"_self\"}',56,'0:0:0:0:0:0:0:1','2018-10-09 18:14:44');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (64,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":95,\"parentId\":1,\"parentName\":\"系统管理\",\"name\":\"授权信息\",\"url\":\"ActivationServletReport?authMessage\\u003d1\",\"perms\":\"grant:info\",\"type\":1,\"icon\":\"fa fa-shield\",\"orderNum\":99,\"openMode\":\"_self\"}',121,'0:0:0:0:0:0:0:1','2018-10-10 11:56:53');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (65,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":96,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"大屏DEMO\",\"type\":0,\"orderNum\":0,\"openMode\":\"_self\"}',86,'0:0:0:0:0:0:0:1','2018-10-12 19:43:59');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (66,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":94,\"parentId\":96,\"parentName\":\"大屏DEMO\",\"name\":\"大屏展示链接\",\"url\":\"bddpshow/show/c99268a7bdf0a8c8dec37f4e5927910d\",\"type\":1,\"orderNum\":0,\"openMode\":\"_blank\"}',161,'0:0:0:0:0:0:0:1','2018-10-12 19:44:20');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (67,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":96,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"大屏DEMO\",\"type\":0,\"orderNum\":100,\"openMode\":\"_self\"}',126,'0:0:0:0:0:0:0:1','2018-10-12 19:44:28');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (68,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":96,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"大屏DEMO\",\"type\":0,\"icon\":\"fa fa-tv\",\"orderNum\":100,\"openMode\":\"_self\"}',57,'0:0:0:0:0:0:0:1','2018-10-12 19:45:23');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (69,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":94,\"parentId\":96,\"parentName\":\"大屏DEMO\",\"name\":\"三农大数据指挥舱\",\"url\":\"bddpshow/show/c99268a7bdf0a8c8dec37f4e5927910d\",\"type\":1,\"orderNum\":0,\"openMode\":\"_blank\"}',854,'0:0:0:0:0:0:0:1','2018-10-12 19:45:57');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (70,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":97,\"parentId\":96,\"parentName\":\"大屏DEMO\",\"name\":\"信贷综合业务驾驶舱\",\"url\":\"bddpshow/show/044a1af39843779cde39678289c42240\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',382,'0:0:0:0:0:0:0:1','2018-10-12 19:47:06');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (71,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":97,\"parentId\":96,\"parentName\":\"大屏DEMO\",\"name\":\"信贷综合业务驾驶舱\",\"url\":\"bddpshow/show/044a1af39843779cde39678289c42240\",\"type\":1,\"orderNum\":0,\"openMode\":\"_blank\"}',128,'0:0:0:0:0:0:0:1','2018-10-12 19:47:15');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (72,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":98,\"parentId\":96,\"parentName\":\"大屏DEMO\",\"name\":\"综合业务_模板1_首页\",\"url\":\"41284e70ef854b0bc215fe95ec9f6aae\",\"type\":1,\"orderNum\":3,\"openMode\":\"_blank\"}',125,'0:0:0:0:0:0:0:1','2018-10-12 19:47:50');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (73,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":99,\"parentId\":96,\"parentName\":\"大屏DEMO\",\"name\":\"综合业务_模板3_三列样式\",\"url\":\"51284e70ef854b0bc215fe95ec9f6aae\",\"type\":1,\"orderNum\":4,\"openMode\":\"_blank\"}',156,'0:0:0:0:0:0:0:1','2018-10-12 19:48:16');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (74,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":100,\"parentId\":96,\"parentName\":\"大屏DEMO\",\"name\":\"综合业务_模板4_七块\",\"url\":\"61284e70ef854b0bc215fe95ec9f6aae\",\"type\":1,\"orderNum\":5,\"openMode\":\"_blank\"}',119,'0:0:0:0:0:0:0:1','2018-10-12 19:48:33');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (75,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":102,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"BI配置\",\"type\":0,\"orderNum\":98,\"openMode\":\"_self\"}',76,'0:0:0:0:0:0:0:1','2018-10-15 14:58:06');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (76,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":103,\"parentId\":102,\"parentName\":\"BI配置\",\"name\":\"数据集\",\"url\":\"1\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',123,'0:0:0:0:0:0:0:1','2018-10-15 14:58:28');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (77,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":104,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"数据挖掘\",\"url\":\"2\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',123,'0:0:0:0:0:0:0:1','2018-10-15 15:05:29');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (78,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":104,\"parentId\":102,\"parentName\":\"BI配置\",\"name\":\"数据挖掘\",\"url\":\"2\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',130,'0:0:0:0:0:0:0:1','2018-10-15 15:05:42');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (79,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":102,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"BI配置\",\"type\":0,\"icon\":\"fa fa-bars\",\"orderNum\":98,\"openMode\":\"_self\"}',395,'0:0:0:0:0:0:0:1','2018-10-15 17:56:45');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (80,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":105,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\" 业务风险_模板1\",\"url\":\"4286e3f913e364025ddc91d74ab7a5ad\",\"type\":1,\"orderNum\":7,\"openMode\":\"_self\"}',89,'0:0:0:0:0:0:0:1','2018-10-16 15:25:42');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (81,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":105,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\" 业务风险_模板1\",\"url\":\"4286e3f913e364025ddc91d74ab7a5ad\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":7,\"openMode\":\"_self\"}',143,'0:0:0:0:0:0:0:1','2018-10-16 15:25:58');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (82,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":105,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\" 业务风险_模板1\",\"url\":\"bddpshow/show/4286e3f913e364025ddc91d74ab7a5ad\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":7,\"openMode\":\"_self\"}',131,'0:0:0:0:0:0:0:1','2018-10-16 15:26:14');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (83,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":105,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\" 业务风险_模板1\",\"url\":\"bddpshow/show/4286e3f913e364025ddc91d74ab7a5ad\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":7,\"openMode\":\"_blank\"}',124,'0:0:0:0:0:0:0:1','2018-10-16 15:31:51');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (84,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":106,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"轮播\",\"url\":\"modules/bddp/swiper/swiper.html\",\"type\":1,\"orderNum\":0,\"openMode\":\"_blank\"}',171,'0:0:0:0:0:0:0:1','2018-10-16 16:47:47');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (85,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":106,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"轮播\",\"url\":\"modules/bddp/swiper/swiper.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',161,'0:0:0:0:0:0:0:1','2018-10-16 16:52:16');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (86,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":106,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"轮播\",\"url\":\"modules/bddp/swiper/swiper.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":99,\"openMode\":\"_blank\"}',382,'0:0:0:0:0:0:0:1','2018-10-16 16:54:17');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (87,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":106,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"综合轮播\",\"url\":\"modules/bddp/swiper/swiper.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":99,\"openMode\":\"_blank\"}',123,'0:0:0:0:0:0:0:1','2018-10-16 16:54:31');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (88,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":107,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"整套报表轮播效果\",\"type\":0,\"orderNum\":0,\"openMode\":\"_self\"}',669,'0:0:0:0:0:0:0:1','2018-10-16 17:17:55');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (89,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":106,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"综合轮播\",\"url\":\"modules/bddp/swiper/swiper.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":99,\"openMode\":\"_blank\"}',41,'0:0:0:0:0:0:0:1','2018-10-16 17:18:12');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (90,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":107,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"整套报表轮播效果\",\"type\":0,\"orderNum\":101,\"openMode\":\"_self\"}',123,'0:0:0:0:0:0:0:1','2018-10-16 17:18:21');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (91,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":107,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"整套报表轮播效果\",\"type\":0,\"icon\":\"col-xs-11\",\"orderNum\":101,\"openMode\":\"_self\"}',391,'0:0:0:0:0:0:0:1','2018-10-16 17:19:41');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (92,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":106,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"左右轮播1\",\"url\":\"modules/bddp/swiper/swiper.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":99,\"openMode\":\"_blank\"}',121,'0:0:0:0:0:0:0:1','2018-10-16 17:19:59');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (93,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":108,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"左右轮播-淡入式\",\"url\":\"1\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',378,'0:0:0:0:0:0:0:1','2018-10-16 17:20:50');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (94,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":109,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"左右轮播-自动切换\",\"url\":\"1\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',391,'0:0:0:0:0:0:0:1','2018-10-16 17:21:30');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (95,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":107,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"整套报表轮播效果\",\"type\":0,\"icon\":\"fa fa-refresh\",\"orderNum\":101,\"openMode\":\"_self\"}',126,'0:0:0:0:0:0:0:1','2018-10-16 17:21:46');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (96,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":110,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"不规则切换式1\",\"url\":\"1\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',134,'0:0:0:0:0:0:0:1','2018-10-16 17:22:19');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (97,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":110,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"不规则切换式1\",\"url\":\"1\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',41,'0:0:0:0:0:0:0:1','2018-10-16 17:22:26');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (98,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":111,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"综合业务3\",\"url\":\"d820f275df7d12d5bffae5e7705b110b\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":8,\"openMode\":\"_blank\"}',128,'0:0:0:0:0:0:0:1','2018-10-16 17:39:08');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (99,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":111,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"综合业务3\",\"url\":\"bddpshow/show/d820f275df7d12d5bffae5e7705b110b\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":8,\"openMode\":\"_blank\"}',129,'0:0:0:0:0:0:0:1','2018-10-16 17:39:35');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (100,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":108,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"左右轮播-淡入式\",\"url\":\"modules/bddp/swiper/swiper.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',132,'0:0:0:0:0:0:0:1','2018-10-16 17:44:45');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (101,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":109,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"左右轮播-自动切换\",\"url\":\"modules/bddp/swiper/swiper.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',117,'0:0:0:0:0:0:0:1','2018-10-16 17:44:53');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (102,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":110,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"不规则切换式1\",\"url\":\"modules/bddp/swiper/swiper.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',123,'0:0:0:0:0:0:0:1','2018-10-16 17:45:00');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (103,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":109,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"左右轮播-自动切换\",\"url\":\"modules/bddp/swiper/swiperauto.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',132,'0:0:0:0:0:0:0:1','2018-10-16 19:50:52');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (104,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":108,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"左右轮播-淡入式\",\"url\":\"modules/bddp/swiper/swiperfade.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',131,'0:0:0:0:0:0:0:1','2018-10-16 20:04:27');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (105,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":105,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"业务风险_模板1\",\"url\":\"bddpshow/show/4286e3f913e364025ddc91d74ab7a5ad\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":7,\"openMode\":\"_blank\"}',41,'0:0:0:0:0:0:0:1','2018-10-16 20:20:52');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (106,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":111,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"综合业务3\",\"url\":\"bddpshow/show/e22d6f7344ea0645b84c60a0a5a57cda\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":8,\"openMode\":\"_blank\"}',72,'0:0:0:0:0:0:0:1','2018-10-18 16:23:15');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (107,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":111,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"公司预览图\",\"url\":\"bddpshow/show/e22d6f7344ea0645b84c60a0a5a57cda\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":8,\"openMode\":\"_blank\"}',149,'0:0:0:0:0:0:0:1','2018-10-18 16:30:11');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (108,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":112,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"人力资源\",\"url\":\"45eef4da7a8f4b56235e24190acd800f\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":9,\"openMode\":\"_blank\"}',130,'0:0:0:0:0:0:0:1','2018-10-18 16:31:46');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (109,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":112,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"人力资源\",\"url\":\"bddpshow/show/45eef4da7a8f4b56235e24190acd800f\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":9,\"openMode\":\"_blank\"}',49,'0:0:0:0:0:0:0:1','2018-10-18 16:32:22');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (110,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":113,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"RDP报表\",\"type\":0,\"icon\":\"fa fa-bar-chart\",\"orderNum\":100,\"openMode\":\"_self\"}',54,'127.0.0.1','2018-10-23 13:54:34');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (111,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":114,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"设计器\",\"url\":\"modules/rdp/rdpDesign.html\",\"type\":1,\"icon\":\"fa fa-bar-chart\",\"orderNum\":0,\"openMode\":\"_blank\"}',103,'127.0.0.1','2018-10-23 13:55:22');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (112,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":114,\"parentId\":113,\"parentName\":\"RDP报表\",\"name\":\"设计器\",\"url\":\"./modules/rdp/rdpDesign.html\",\"type\":1,\"icon\":\"fa fa-bar-chart\",\"orderNum\":0,\"openMode\":\"_blank\"}',58,'127.0.0.1','2018-10-23 13:55:47');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (113,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":113,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"RDP报表\",\"type\":0,\"icon\":\"fa fa-table\",\"orderNum\":100,\"openMode\":\"_self\"}',49,'127.0.0.1','2018-10-23 14:10:02');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (114,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":114,\"parentId\":113,\"parentName\":\"RDP报表\",\"name\":\"设计器\",\"url\":\"./modules/rdp/rdpDesign.html\",\"type\":1,\"icon\":\"fa fa-braille\",\"orderNum\":0,\"openMode\":\"_blank\"}',33,'127.0.0.1','2018-10-23 14:12:09');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (115,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":115,\"parentId\":113,\"parentName\":\"RDP报表\",\"name\":\"报表列表\",\"url\":\".modules/rdp/list.html\",\"type\":1,\"icon\":\"fa fa-user\",\"orderNum\":0,\"openMode\":\"_parent\"}',41,'127.0.0.1','2018-10-24 14:50:50');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (116,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":115,\"parentId\":113,\"parentName\":\"RDP报表\",\"name\":\"报表列表\",\"url\":\"modules/rdp/list.html\",\"type\":1,\"icon\":\"fa fa-user\",\"orderNum\":0,\"openMode\":\"_self\"}',54,'127.0.0.1','2018-10-24 14:51:37');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (117,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":102,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"BI配置\",\"type\":0,\"icon\":\"fa fa-bars\",\"orderNum\":2,\"openMode\":\"_self\"}',54,'127.0.0.1','2018-10-25 09:30:37');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (118,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":92,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"设计器\",\"type\":0,\"icon\":\"fa fa-paper-plane\",\"orderNum\":3,\"openMode\":\"_self\"}',73,'127.0.0.1','2018-10-25 09:34:05');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (119,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":113,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"RDP报表\",\"type\":0,\"icon\":\"fa fa-table\",\"orderNum\":4,\"openMode\":\"_self\"}',45,'127.0.0.1','2018-10-25 09:34:33');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (120,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":114,\"parentId\":92,\"parentName\":\"设计器\",\"name\":\"RDP设计器\",\"url\":\"./modules/rdp/rdpDesign.html\",\"type\":1,\"icon\":\"fa fa-braille\",\"orderNum\":0,\"openMode\":\"_blank\"}',96,'127.0.0.1','2018-10-25 09:42:56');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (121,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":102,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"BI配置\",\"type\":0,\"icon\":\"fa fa-bars\",\"orderNum\":98,\"openMode\":\"_self\"}',255,'127.0.0.1','2018-10-25 13:44:35');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (122,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":103,\"parentId\":102,\"parentName\":\"BI配置\",\"name\":\"数据集\",\"url\":\"developing.html\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',70,'127.0.0.1','2018-10-25 13:45:08');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (123,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":104,\"parentId\":102,\"parentName\":\"BI配置\",\"name\":\"数据挖掘\",\"url\":\"developing.html\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',32,'127.0.0.1','2018-10-25 13:45:19');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (124,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":103,\"parentId\":102,\"parentName\":\"BI配置\",\"name\":\"数据集\",\"url\":\"developing.html?num\\u003d1\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',43,'127.0.0.1','2018-10-25 13:50:03');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (125,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":104,\"parentId\":102,\"parentName\":\"BI配置\",\"name\":\"数据挖掘\",\"url\":\"developing.html?num\\u003d2\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',32,'127.0.0.1','2018-10-25 13:50:23');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (126,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":116,\"parentId\":113,\"parentName\":\"RDP报表\",\"name\":\"数据源配置\",\"url\":\"modules/ser/config/dataConfig.html\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',37,'127.0.0.1','2018-10-25 15:25:54');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (127,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":77,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集使用\",\"url\":\"modules/ser/dttable.html\",\"type\":1,\"icon\":\"\",\"orderNum\":6,\"openMode\":\"_self\"}',58,'127.0.0.1','2018-10-26 10:45:51');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (128,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":116,\"parentId\":113,\"parentName\":\"RDP报表\",\"name\":\"数据源配置\",\"url\":\"modules/ser/config/rdpDataConfig.html\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',60,'127.0.0.1','2018-10-29 09:20:07');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (129,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":77,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集使用\",\"url\":\"modules/ser/dttable.html\",\"type\":1,\"icon\":\"\",\"orderNum\":6,\"openMode\":\"_self\"}',59,'127.0.0.1','2018-10-29 16:28:06');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (130,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":77,\"parentId\":46,\"parentName\":\"服务\",\"name\":\"数据集使用\",\"url\":\"modules/ser/dttable.html\",\"type\":1,\"icon\":\"fa fa-bars\",\"orderNum\":6,\"openMode\":\"_self\"}',27,'127.0.0.1','2018-10-29 16:29:51');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (131,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":116,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"公共数据源配置\",\"url\":\"modules/ser/config/rdpDataConfig.html\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',36,'127.0.0.1','2018-10-30 15:02:12');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (132,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":94,\"parentId\":1,\"parentName\":\"系统管理\",\"name\":\"授权信息\",\"url\":\"AsReport?authMessage\\u003d1\",\"perms\":\"grant:info\",\"type\":1,\"icon\":\"fa fa-shield\",\"orderNum\":99,\"openMode\":\"_self\"}',46,'127.0.0.1','2018-10-30 15:02:14');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (133,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":116,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"公共数据源配置\",\"url\":\"modules/ser/config/rdpDataConfig.html\",\"type\":1,\"icon\":\"fa fa-database\",\"orderNum\":0,\"openMode\":\"_self\"}',23,'127.0.0.1','2018-10-30 15:03:09');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (134,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":115,\"parentId\":113,\"parentName\":\"RDP报表\",\"name\":\"报表管理\",\"url\":\"modules/rdp/list.html\",\"type\":1,\"icon\":\"fa fa-user\",\"orderNum\":0,\"openMode\":\"_self\"}',38,'127.0.0.1','2018-10-30 15:04:09');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (135,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":117,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"RDP报表DEMO\",\"type\":0,\"icon\":\"fa fa-table\",\"orderNum\":98,\"openMode\":\"_self\"}',36,'127.0.0.1','2018-10-30 15:40:09');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (136,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":117,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"RDP报表DEMO\",\"type\":0,\"icon\":\"fa fa-table\",\"orderNum\":99,\"openMode\":\"_self\"}',28,'127.0.0.1','2018-10-30 15:40:30');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (137,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":118,\"parentId\":117,\"parentName\":\"RDP报表DEMO\",\"name\":\"客户与产品交叉报表\",\"url\":\"rdppage/show/1ea3e7ef2e8d9bd9a44ba3f24a1417de\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',32,'127.0.0.1','2018-10-30 15:43:55');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (138,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":117,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"网格报表DEMO\",\"type\":0,\"icon\":\"fa fa-table\",\"orderNum\":99,\"openMode\":\"_self\"}',55,'127.0.0.1','2018-10-30 16:09:28');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (139,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":118,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"客户与产品交叉报表\",\"url\":\"rdppage/show/1ea3e7ef2e8d9bd9a44ba3f24a1417de\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',25,'127.0.0.1','2018-10-30 16:09:37');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (140,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":119,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"分组-地域客户信息报表\",\"url\":\"rdppage/show/04c65e333d6c8cf1e006c054f8d6158b\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',38,'127.0.0.1','2018-10-30 16:12:53');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (141,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":118,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"交叉-客户与产品交叉报表\",\"url\":\"rdppage/show/1ea3e7ef2e8d9bd9a44ba3f24a1417de\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',70,'127.0.0.1','2018-10-30 16:15:40');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (142,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":120,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"分块-用户信息\",\"url\":\"rdppage/show/b0f44689bd804c43d59d85871a99711c\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',38,'127.0.0.1','2018-10-30 16:20:25');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (143,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":120,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"分块-用户信息\",\"url\":\"rdppage/show/b0f44689bd804c43d59d85871a99711c\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',32,'127.0.0.1','2018-10-30 16:20:43');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (144,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":121,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"详情-入库通知书\",\"url\":\"rdppage/show/f001db5305e400fe28bb5f3ebac7e451\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',97,'127.0.0.1','2018-10-30 16:22:45');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (145,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":122,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"动态-水电费统计\",\"url\":\"rdppage/show/f004ff76e9e10b6b7d4ecb396608ee0a\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',38,'127.0.0.1','2018-10-30 16:25:57');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (146,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":123,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"对比-季度对比分析报表\",\"url\":\"rdppage/show/23a58db31668eef064370d9706a3896c\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',31,'127.0.0.1','2018-10-30 16:28:40');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (147,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":124,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"预警-客户风险预警报表\",\"url\":\"rdppage/show/8b9873d6fb7e14e93794ee7fc11cc3a0\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',27,'127.0.0.1','2018-10-30 16:30:21');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (148,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":124,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"预警-客户风险预警报表\",\"url\":\"rdppage/show/8b9873d6fb7e14e93794ee7fc11cc3a0\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',25,'127.0.0.1','2018-10-30 16:53:10');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (149,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":121,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"详情-入库通知书\",\"url\":\"rdppage/main/f001db5305e400fe28bb5f3ebac7e451\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',23,'127.0.0.1','2018-10-30 16:53:27');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (150,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":125,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"传参-查询列表\",\"url\":\"rdppage/main/c5913481563309808c929e53b9a7b9e0\",\"type\":1,\"icon\":\"fa fa-sys\",\"orderNum\":0,\"openMode\":\"_self\"}',55,'127.0.0.1','2018-10-30 16:55:23');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (151,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":125,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"传参-查询列表\",\"url\":\"rdppage/main/c5913481563309808c929e53b9a7b9e0\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',56,'127.0.0.1','2018-10-30 16:56:04');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (152,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":126,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"项目结合-查询列表\",\"url\":\"modules/rdp/demo/demo1.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',59,'127.0.0.1','2018-10-30 17:57:20');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (153,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":127,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"普通JAVABEAN\",\"url\":\"modules/rdp/javabean/a.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',664,'127.0.0.1','2018-10-31 09:06:57');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (154,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":128,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"自定义分页JAVABEAN\",\"url\":\"modules/rdp/javabean/b.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',38,'127.0.0.1','2018-10-31 09:07:49');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (155,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":129,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"动态列JAVABEAN\",\"url\":\"modules/rdp/javabean/c.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',77,'127.0.0.1','2018-10-31 09:09:04');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (156,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":129,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"动态列JAVABEAN\",\"url\":\"modules/rdp/javabean/c.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',40,'127.0.0.1','2018-10-31 09:09:15');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (157,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":114,\"parentId\":92,\"parentName\":\"设计器\",\"name\":\"网格式报表设计器\",\"url\":\"./modules/rdp/rdpDesign.html\",\"type\":1,\"icon\":\"fa fa-braille\",\"orderNum\":0,\"openMode\":\"_blank\"}',24,'127.0.0.1','2018-10-31 10:45:21');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (158,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":113,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"网格式报表\",\"type\":0,\"icon\":\"fa fa-table\",\"orderNum\":4,\"openMode\":\"_self\"}',23,'127.0.0.1','2018-10-31 10:45:34');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (159,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":113,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"网格式报表管理\",\"type\":0,\"icon\":\"fa fa-table\",\"orderNum\":4,\"openMode\":\"_self\"}',18,'127.0.0.1','2018-10-31 10:45:54');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (160,'admin','删除菜单','io.report.modules.sys.controller.SysMenuController.delete()','127',56,'127.0.0.1','2018-10-31 10:50:20');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (161,'admin','删除菜单','io.report.modules.sys.controller.SysMenuController.delete()','128',30,'127.0.0.1','2018-10-31 10:50:29');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (162,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":129,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"动态列JAVABEAN\",\"url\":\"modules/rdp/javabean/c.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":2,\"openMode\":\"_self\"}',23,'127.0.0.1','2018-10-31 10:50:39');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (163,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":125,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"生成参数-查询列表\",\"url\":\"rdppage/main/c5913481563309808c929e53b9a7b9e0\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',28,'127.0.0.1','2018-10-31 10:56:18');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (164,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":126,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"自定义查询条件-查询列表\",\"url\":\"modules/rdp/demo/demo1.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',28,'127.0.0.1','2018-10-31 10:56:41');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (165,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":125,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"一体化生成-查询列表\",\"url\":\"rdppage/main/c5913481563309808c929e53b9a7b9e0\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',22,'127.0.0.1','2018-10-31 10:58:34');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (166,'admin','保存用户','io.report.modules.sys.controller.SysUserController.save()','{\"userId\":2,\"username\":\"user\",\"password\":\"7e9591ff11ba1fa4ef8f9c56483b79aed081f0beb46672820b6f9b1bb3aeed2a\",\"salt\":\"rJOkHEBBEkdL1nt7ifW1\",\"email\":\"user@qq.com\",\"mobile\":\"13112345678\",\"status\":1,\"roleIdList\":[],\"createTime\":\"Oct 31, 2018 5:25:39 PM\",\"deptId\":3,\"deptName\":\"研发部\"}',86,'127.0.0.1','2018-10-31 17:25:39');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (167,'admin','保存用户','io.report.modules.sys.controller.SysUserController.save()','{\"userId\":3,\"username\":\"guest\",\"password\":\"93ee72a556fd66126ac88633516c6ebe76c1490e99f92c3aa4a8e3cf2677080b\",\"salt\":\"i8surV6S6L64zP5SO6yY\",\"email\":\"guest@qq.com\",\"mobile\":\"13212345678\",\"status\":1,\"roleIdList\":[],\"createTime\":\"Oct 31, 2018 5:26:20 PM\",\"deptId\":1,\"deptName\":\"总部\"}',53,'127.0.0.1','2018-10-31 17:26:20');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (168,'admin','保存角色','io.report.modules.sys.controller.SysRoleController.save()','{\"roleId\":1,\"roleName\":\"开发人员\",\"deptId\":1,\"deptName\":\"总部\",\"menuIdList\":[92,93,114,95,96,97,98,99,100,101,105,111,112,102,103,104,107,106,108,109,110,113,115,116,117,118,119,120,121,122,123,124,125,126,129],\"deptIdList\":[1,2,3],\"createTime\":\"Oct 31, 2018 5:27:10 PM\"}',267,'127.0.0.1','2018-10-31 17:27:10');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (169,'admin','修改用户','io.report.modules.sys.controller.SysUserController.update()','{\"userId\":2,\"username\":\"user\",\"password\":\"7e9591ff11ba1fa4ef8f9c56483b79aed081f0beb46672820b6f9b1bb3aeed2a\",\"salt\":\"rJOkHEBBEkdL1nt7ifW1\",\"email\":\"user@qq.com\",\"mobile\":\"13112345678\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Oct 31, 2018 5:25:39 PM\",\"deptId\":1,\"deptName\":\"总部\"}',51,'127.0.0.1','2018-10-31 17:27:28');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (170,'admin','保存角色','io.report.modules.sys.controller.SysRoleController.save()','{\"roleId\":2,\"roleName\":\"业务人员\",\"deptId\":1,\"deptName\":\"总部\",\"menuIdList\":[95,96,97,98,99,100,101,105,111,112,107,106,108,109,110,117,118,119,120,121,122,123,124,125,126,129],\"deptIdList\":[1,2,3],\"createTime\":\"Oct 31, 2018 5:28:01 PM\"}',204,'127.0.0.1','2018-10-31 17:28:01');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (171,'admin','修改用户','io.report.modules.sys.controller.SysUserController.update()','{\"userId\":3,\"username\":\"guest\",\"salt\":\"i8surV6S6L64zP5SO6yY\",\"email\":\"guest@qq.com\",\"mobile\":\"13212345678\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Oct 31, 2018 5:26:20 PM\",\"deptId\":1,\"deptName\":\"总部\"}',43,'127.0.0.1','2018-10-31 17:28:10');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (172,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":130,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"测试引导\",\"url\":\"modules/rdp/demo/demo2.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',40,'127.0.0.1','2018-11-01 10:50:18');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (173,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":130,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"测试引导\",\"url\":\"modules/rdp/demo/demo2.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',120,'127.0.0.1','2018-11-01 10:53:22');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (174,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":131,\"parentId\":95,\"parentName\":\"大屏DEMO\",\"name\":\"盒模型切换\",\"url\":\"modules/bddp/swiper/swipercube.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',29,'127.0.0.1','2018-11-01 13:31:45');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (175,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":131,\"parentId\":107,\"parentName\":\"整套报表轮播效果\",\"name\":\"盒模型切换\",\"url\":\"modules/bddp/swiper/swipercube.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_blank\"}',48,'127.0.0.1','2018-11-01 13:32:28');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (176,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":125,\"parentId\":117,\"parentName\":\"网格报表DEMO\",\"name\":\"一体化生成-查询列表\",\"url\":\"modules/rdp/demo/demo2.html\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":0,\"openMode\":\"_self\"}',26,'127.0.0.1','2018-11-01 14:40:47');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (177,'admin','删除菜单','io.report.modules.sys.controller.SysMenuController.delete()','130',71,'127.0.0.1','2018-11-01 14:40:56');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (178,'admin','保存用户','io.report.modules.sys.controller.SysUserController.save()','{\"userId\":4,\"username\":\"wangli\",\"password\":\"62eb29365851ecb8b71dde6f1eb06b27bcdc5dd214cfcc8f92120125591453e3\",\"salt\":\"B1McpZZIbPEyZRkgMTAZ\",\"email\":\"wangli@qq.com\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Nov 15, 2018 4:22:46 PM\",\"deptId\":3,\"deptName\":\"研发部\"}',250,'128.1.120.52','2018-11-15 16:22:46');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (179,'admin','保存用户','io.report.modules.sys.controller.SysUserController.save()','{\"userId\":5,\"username\":\"zhengtao\",\"password\":\"3fda65d06831ae56ef17dd00bc51663722ce4dd47a50b32ac8cbe69f2d57808e\",\"salt\":\"jS8QZrcVIDwKU46r9Hia\",\"email\":\"zhengtao@qq.com\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Nov 15, 2018 4:23:12 PM\",\"deptId\":3,\"deptName\":\"研发部\"}',31,'128.1.120.52','2018-11-15 16:23:12');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (180,'admin','保存用户','io.report.modules.sys.controller.SysUserController.save()','{\"userId\":6,\"username\":\"lixing\",\"password\":\"f7559b24a2e4b26fa0d6062e19b938c16d1ca24f8eb1f0be30262e3687d37a6b\",\"salt\":\"3WY4u56aMUmE84T5lLYN\",\"email\":\"lixing@qq.com\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Nov 16, 2018 9:13:02 AM\",\"deptId\":3,\"deptName\":\"研发部\"}',63,'128.1.120.52','2018-11-16 09:13:02');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (181,'admin','保存用户','io.report.modules.sys.controller.SysUserController.save()','{\"userId\":7,\"username\":\"zhangjianing\",\"password\":\"b4c44d29c06009f953762e449087f534e07c98950b7a34703e96862f82075a1f\",\"salt\":\"esQGA84bXZdfob7qPyfK\",\"email\":\"zhangjianing@qq.com\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Nov 16, 2018 9:13:32 AM\",\"deptId\":3,\"deptName\":\"研发部\"}',47,'128.1.120.52','2018-11-16 09:13:32');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (182,'admin','删除菜单','io.report.modules.sys.controller.SysMenuController.delete()','7',0,'127.0.0.1','2018-11-23 10:21:18');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (183,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":113,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"报表管理\",\"type\":0,\"icon\":\"fa fa-table\",\"orderNum\":4,\"openMode\":\"_self\"}',171,'127.0.0.1','2018-11-23 14:34:12');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (184,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":115,\"parentId\":113,\"parentName\":\"报表管理\",\"name\":\"网格报表管理\",\"url\":\"modules/rdp/list.html\",\"type\":1,\"icon\":\"fa fa-user\",\"orderNum\":0,\"openMode\":\"_self\"}',34,'127.0.0.1','2018-11-23 14:34:50');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (185,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":132,\"parentId\":113,\"parentName\":\"报表管理\",\"name\":\"大屏幕报表管理\",\"url\":\"modules/bddp/design.html\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',38,'127.0.0.1','2018-11-23 14:35:23');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (186,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":132,\"parentId\":113,\"parentName\":\"报表管理\",\"name\":\"大屏幕报表管理\",\"url\":\"modules/bddp/home.html\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',51,'127.0.0.1','2018-11-23 14:35:53');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (187,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":132,\"parentId\":113,\"parentName\":\"报表管理\",\"name\":\"大屏幕报表管理\",\"url\":\"modules/bddp/home.html\",\"type\":1,\"orderNum\":0,\"openMode\":\"_blank\"}',31,'127.0.0.1','2018-11-23 14:47:31');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (188,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":93,\"parentId\":92,\"parentName\":\"设计器\",\"name\":\"大屏设计器\",\"url\":\"./modules/bddp/home.html\",\"type\":1,\"icon\":\"fa fa-pencil-square-o\",\"orderNum\":0,\"openMode\":\"_blank\"}',51,'127.0.0.1','2018-11-23 15:32:06');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (189,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":133,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"填报报表DEMO\",\"url\":\"#\",\"type\":1,\"orderNum\":0,\"openMode\":\"_self\"}',85,'0:0:0:0:0:0:0:1','2018-11-29 14:08:14');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (190,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":133,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"填报报表DEMO\",\"url\":\"#\",\"type\":0,\"icon\":\"fa fa-table\",\"orderNum\":100,\"openMode\":\"_self\"}',19,'0:0:0:0:0:0:0:1','2018-11-29 14:08:42');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (191,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":133,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"填报报表DEMO\",\"url\":\"#\",\"type\":0,\"icon\":\"fa fa-wpforms\",\"orderNum\":100,\"openMode\":\"_self\"}',15,'0:0:0:0:0:0:0:1','2018-11-29 14:10:16');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (192,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":134,\"parentId\":133,\"parentName\":\"填报报表DEMO\",\"name\":\"人员基本情况表\",\"url\":\"rdppage/main/e93657d429ea44bfe6f5b7872676b35f\",\"type\":1,\"orderNum\":1,\"openMode\":\"_self\"}',35,'0:0:0:0:0:0:0:1','2018-11-29 14:11:15');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (193,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":134,\"parentId\":133,\"parentName\":\"填报报表DEMO\",\"name\":\"人员基本情况表\",\"url\":\"rdppage/main/e93657d429ea44bfe6f5b7872676b35f\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":1,\"openMode\":\"_self\"}',20,'0:0:0:0:0:0:0:1','2018-11-29 14:11:42');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (194,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":135,\"parentId\":133,\"parentName\":\"填报报表DEMO\",\"name\":\"申报事项审批单\",\"url\":\"rdppage/main/6fbd2deabc701284edeb14003b26baea\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":2,\"openMode\":\"_self\"}',20,'0:0:0:0:0:0:0:1','2018-11-29 14:12:24');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (195,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":133,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"填报报表DEMO\",\"url\":\"\",\"type\":0,\"icon\":\"fa fa-wpforms\",\"orderNum\":100,\"openMode\":\"_self\"}',15,'0:0:0:0:0:0:0:1','2018-11-29 14:12:48');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (196,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":133,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"填报报表DEMO\",\"url\":\"\",\"type\":0,\"icon\":\"fa fa-wpforms\",\"orderNum\":100,\"openMode\":\"_self\"}',19,'0:0:0:0:0:0:0:1','2018-11-29 14:13:03');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (197,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":136,\"parentId\":133,\"parentName\":\"填报报表DEMO\",\"name\":\"申报事项审批单编辑\",\"url\":\"rdppage/main/5bd730f8f1b65b0908e383ad76d15642\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":3,\"openMode\":\"_self\"}',24,'0:0:0:0:0:0:0:1','2018-11-29 14:15:00');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (198,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":137,\"parentId\":133,\"parentName\":\"填报报表DEMO\",\"name\":\"填报添加验证DEMO\",\"url\":\"rdppage/main/b00eaf643bd2034ebc2a2e402a785667\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":4,\"openMode\":\"_self\"}',31,'0:0:0:0:0:0:0:1','2018-11-29 14:15:46');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (199,'admin','保存菜单','io.report.modules.sys.controller.SysMenuController.save()','{\"menuId\":138,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"填报详情明细\",\"url\":\"rdppage/main/3132737d6c808d35f2fbc60f6ec6e2a5\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":5,\"openMode\":\"_self\"}',21,'0:0:0:0:0:0:0:1','2018-11-29 14:16:28');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (200,'admin','修改菜单','io.report.modules.sys.controller.SysMenuController.update()','{\"menuId\":138,\"parentId\":133,\"parentName\":\"填报报表DEMO\",\"name\":\"填报详情明细\",\"url\":\"rdppage/main/3132737d6c808d35f2fbc60f6ec6e2a5\",\"type\":1,\"icon\":\"fa fa-eye\",\"orderNum\":5,\"openMode\":\"_self\"}',26,'0:0:0:0:0:0:0:1','2018-11-29 14:16:46');

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `open_mode` varchar(10) DEFAULT NULL COMMENT '打开方式',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='菜单管理';

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (1,0,'系统管理',NULL,NULL,0,'fa fa-cog',99,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (2,1,'管理员管理','modules/sys/user.html',NULL,1,'fa fa-user',1,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (3,1,'角色管理','modules/sys/role.html',NULL,1,'fa fa-user-secret',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (4,1,'菜单管理','modules/sys/menu.html',NULL,1,'fa fa-th-list',3,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (5,1,'SQL监控','druid/sql.html',NULL,1,'fa fa-bug',4,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (15,2,'查看',NULL,'sys:user:list,sys:user:info',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (16,2,'新增',NULL,'sys:user:save,sys:role:select',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (17,2,'修改',NULL,'sys:user:update,sys:role:select',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (18,2,'删除',NULL,'sys:user:delete',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (19,3,'查看',NULL,'sys:role:list,sys:role:info',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (20,3,'新增',NULL,'sys:role:save,sys:menu:perms',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (21,3,'修改',NULL,'sys:role:update,sys:menu:perms',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (22,3,'删除',NULL,'sys:role:delete',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (23,4,'查看',NULL,'sys:menu:list,sys:menu:info',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (24,4,'新增',NULL,'sys:menu:save,sys:menu:select',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (25,4,'修改',NULL,'sys:menu:update,sys:menu:select',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (26,4,'删除',NULL,'sys:menu:delete',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (27,1,'参数管理','modules/sys/config.html','sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete',1,'fa fa-sun-o',6,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (29,1,'系统日志','modules/sys/log.html','sys:log:list',1,'fa fa-file-text-o',7,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (31,1,'部门管理','modules/sys/dept.html',NULL,1,'fa fa-file-code-o',1,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (32,31,'查看',NULL,'sys:dept:list,sys:dept:info',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (33,31,'新增',NULL,'sys:dept:save,sys:dept:select',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (34,31,'修改',NULL,'sys:dept:update,sys:dept:select',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (35,31,'删除',NULL,'sys:dept:delete',2,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (36,1,'字典管理','modules/sys/dict.html',NULL,1,'fa fa-bookmark-o',6,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (37,36,'查看',NULL,'sys:dict:list,sys:dict:info',2,NULL,6,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (38,36,'新增',NULL,'sys:dict:save',2,NULL,6,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (39,36,'修改',NULL,'sys:dict:update',2,NULL,6,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (40,36,'删除',NULL,'sys:dict:delete',2,NULL,6,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (92,0,'设计器',NULL,NULL,0,'fa fa-paper-plane',3,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (93,92,'大屏设计器','./modules/bddp/home.html',NULL,1,'fa fa-pencil-square-o',0,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (94,1,'授权信息','AsReport?authMessage=1','grant:info',1,'fa fa-shield',99,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (95,0,'大屏DEMO',NULL,NULL,0,'fa fa-tv',100,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (96,95,'三农大数据指挥舱','bddpshow/show/c99268a7bdf0a8c8dec37f4e5927910d',NULL,1,'fa fa-eye',10,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (97,95,'信贷综合业务驾驶舱','bddpshow/show/044a1af39843779cde39678289c42240',NULL,1,'fa fa-eye',10,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (98,95,'综合业务_模板1_首页','bddpshow/show/41284e70ef854b0bc215fe95ec9f6aae',NULL,1,'fa fa-eye',1,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (99,95,'综合业务_模板3_三列样式','bddpshow/show/51284e70ef854b0bc215fe95ec9f6aae',NULL,1,'fa fa-eye',4,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (100,95,'综合业务_模板2_三行模块','bddpshow/show/d76cbda028bebf896552816e981c3cc2',NULL,1,'fa fa-eye',5,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (101,95,'综合业务_模板4_七块','bddpshow/show/61284e70ef854b0bc215fe95ec9f6aae','',1,'fa fa-eye',5,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (102,0,'BI配置',NULL,NULL,0,'fa fa-bars',98,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (103,102,'数据集','developing.html?num=1',NULL,1,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (104,102,'数据挖掘','developing.html?num=2',NULL,1,NULL,0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (105,95,'业务风险_模板1','bddpshow/show/4286e3f913e364025ddc91d74ab7a5ad',NULL,1,'fa fa-eye',7,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (106,107,'左右轮播1','modules/bddp/swiper/swiper.html',NULL,1,'fa fa-eye',99,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (107,0,'整套报表轮播效果',NULL,NULL,0,'fa fa-refresh',101,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (108,107,'左右轮播-淡入式','modules/bddp/swiper/swiperfade.html',NULL,1,'fa fa-eye',0,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (109,107,'左右轮播-自动切换','modules/bddp/swiper/swiperauto.html',NULL,1,'fa fa-eye',0,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (110,107,'不规则切换式1','modules/bddp/swiper/swiper.html',NULL,1,'fa fa-eye',0,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (111,95,'公司预览图','bddpshow/show/e22d6f7344ea0645b84c60a0a5a57cda',NULL,1,'fa fa-eye',2,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (112,95,'人力资源','bddpshow/show/45eef4da7a8f4b56235e24190acd800f',NULL,1,'fa fa-eye',9,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (113,0,'报表管理',NULL,NULL,0,'fa fa-table',4,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (114,92,'网格式报表设计器','./modules/rdp/rdpDesign.html',NULL,1,'fa fa-braille',0,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (115,113,'网格报表管理','modules/rdp/list.html',NULL,1,'fa fa-user',0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (116,0,'公共数据源配置','modules/ser/config/rdpDataConfig.html',NULL,1,'fa fa-database',0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (117,0,'网格报表DEMO',NULL,NULL,0,'fa fa-table',99,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (118,117,'交叉-客户与产品交叉报表','rdppage/show/1ea3e7ef2e8d9bd9a44ba3f24a1417de',NULL,1,'fa fa-eye',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (119,117,'分组-地域客户信息报表','rdppage/show/04c65e333d6c8cf1e006c054f8d6158b',NULL,1,'fa fa-eye',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (120,117,'分块-用户信息','rdppage/show/b0f44689bd804c43d59d85871a99711c',NULL,1,'fa fa-eye',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (121,117,'详情-入库通知书','rdppage/main/f001db5305e400fe28bb5f3ebac7e451',NULL,1,'fa fa-eye',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (122,117,'动态-水电费统计','rdppage/show/f004ff76e9e10b6b7d4ecb396608ee0a',NULL,1,'fa fa-eye',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (123,117,'对比-季度对比分析报表','rdppage/show/23a58db31668eef064370d9706a3896c',NULL,1,'fa fa-eye',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (124,117,'预警-客户风险预警报表','rdppage/show/8b9873d6fb7e14e93794ee7fc11cc3a0',NULL,1,'fa fa-eye',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (125,117,'一体化生成-查询列表','modules/rdp/demo/demo2.html',NULL,1,'fa fa-eye',0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (126,117,'自定义查询条件-查询列表','modules/rdp/demo/demo1.html',NULL,1,'fa fa-eye',0,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (129,117,'动态列JAVABEAN','modules/rdp/javabean/c.html',NULL,1,'fa fa-eye',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (131,107,'盒模型切换','modules/bddp/swiper/swipercube.html',NULL,1,'fa fa-eye',0,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (132,113,'大屏幕报表管理','modules/bddp/home.html',NULL,1,NULL,0,'_blank');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (133,0,'填报报表DEMO','',NULL,0,'fa fa-wpforms',100,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (134,133,'人员基本情况表','rdppage/main/e93657d429ea44bfe6f5b7872676b35f',NULL,1,'fa fa-eye',1,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (135,133,'申报事项审批单','rdppage/main/6fbd2deabc701284edeb14003b26baea',NULL,1,'fa fa-eye',2,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (136,133,'申报事项审批单编辑','rdppage/main/5bd730f8f1b65b0908e383ad76d15642',NULL,1,'fa fa-eye',3,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (137,133,'填报添加验证DEMO','rdppage/main/b00eaf643bd2034ebc2a2e402a785667',NULL,1,'fa fa-eye',4,'_self');
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`,`open_mode`) values (138,133,'填报详情明细','rdppage/main/3132737d6c808d35f2fbc60f6ec6e2a5',NULL,1,'fa fa-eye',5,'_self');

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色';

/*Data for the table `sys_role` */

insert  into `sys_role`(`role_id`,`role_name`,`remark`,`dept_id`,`create_time`) values (1,'开发人员',NULL,1,'2018-10-31 17:27:10');
insert  into `sys_role`(`role_id`,`role_name`,`remark`,`dept_id`,`create_time`) values (2,'业务人员',NULL,1,'2018-10-31 17:28:01');

/*Table structure for table `sys_role_dept` */

DROP TABLE IF EXISTS `sys_role_dept`;

CREATE TABLE `sys_role_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='角色与部门对应关系';

/*Data for the table `sys_role_dept` */

insert  into `sys_role_dept`(`id`,`role_id`,`dept_id`) values (1,1,1);
insert  into `sys_role_dept`(`id`,`role_id`,`dept_id`) values (2,1,2);
insert  into `sys_role_dept`(`id`,`role_id`,`dept_id`) values (3,1,3);
insert  into `sys_role_dept`(`id`,`role_id`,`dept_id`) values (4,2,1);
insert  into `sys_role_dept`(`id`,`role_id`,`dept_id`) values (5,2,2);
insert  into `sys_role_dept`(`id`,`role_id`,`dept_id`) values (6,2,3);

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';

/*Data for the table `sys_role_menu` */

insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (1,1,92);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (2,1,93);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (3,1,114);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (4,1,95);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (5,1,96);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (6,1,97);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (7,1,98);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (8,1,99);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (9,1,100);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (10,1,101);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (11,1,105);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (12,1,111);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (13,1,112);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (14,1,102);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (15,1,103);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (16,1,104);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (17,1,107);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (18,1,106);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (19,1,108);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (20,1,109);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (21,1,110);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (22,1,113);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (23,1,115);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (24,1,116);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (25,1,117);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (26,1,118);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (27,1,119);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (28,1,120);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (29,1,121);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (30,1,122);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (31,1,123);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (32,1,124);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (33,1,125);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (34,1,126);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (35,1,129);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (36,2,95);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (37,2,96);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (38,2,97);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (39,2,98);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (40,2,99);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (41,2,100);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (42,2,101);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (43,2,105);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (44,2,111);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (45,2,112);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (46,2,107);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (47,2,106);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (48,2,108);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (49,2,109);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (50,2,110);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (51,2,117);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (52,2,118);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (53,2,119);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (54,2,120);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (55,2,121);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (56,2,122);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (57,2,123);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (58,2,124);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (59,2,125);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (60,2,126);
insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (61,2,129);

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) DEFAULT NULL COMMENT '盐',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='系统用户';

/*Data for the table `sys_user` */

insert  into `sys_user`(`user_id`,`username`,`password`,`salt`,`email`,`mobile`,`status`,`dept_id`,`create_time`) values (1,'admin','e1153123d7d180ceeb820d577ff119876678732a68eef4e6ffc0b1f06a01f91b','YzcmCZNvbXocrsz9dm8e','517537832@qq.com',' ',1,1,'2018-08-27 14:00:00');
insert  into `sys_user`(`user_id`,`username`,`password`,`salt`,`email`,`mobile`,`status`,`dept_id`,`create_time`) values (2,'user','7e9591ff11ba1fa4ef8f9c56483b79aed081f0beb46672820b6f9b1bb3aeed2a','rJOkHEBBEkdL1nt7ifW1','user@qq.com','13112345678',1,1,'2018-10-31 17:25:39');
insert  into `sys_user`(`user_id`,`username`,`password`,`salt`,`email`,`mobile`,`status`,`dept_id`,`create_time`) values (3,'guest','93ee72a556fd66126ac88633516c6ebe76c1490e99f92c3aa4a8e3cf2677080b','i8surV6S6L64zP5SO6yY','guest@qq.com','13212345678',1,1,'2018-10-31 17:26:20');
insert  into `sys_user`(`user_id`,`username`,`password`,`salt`,`email`,`mobile`,`status`,`dept_id`,`create_time`) values (4,'wangli','62eb29365851ecb8b71dde6f1eb06b27bcdc5dd214cfcc8f92120125591453e3','B1McpZZIbPEyZRkgMTAZ','wangli@qq.com',NULL,1,3,'2018-11-15 16:22:46');
insert  into `sys_user`(`user_id`,`username`,`password`,`salt`,`email`,`mobile`,`status`,`dept_id`,`create_time`) values (5,'zhengtao','3fda65d06831ae56ef17dd00bc51663722ce4dd47a50b32ac8cbe69f2d57808e','jS8QZrcVIDwKU46r9Hia','zhengtao@qq.com',NULL,1,3,'2018-11-15 16:23:12');
insert  into `sys_user`(`user_id`,`username`,`password`,`salt`,`email`,`mobile`,`status`,`dept_id`,`create_time`) values (6,'lixing','f7559b24a2e4b26fa0d6062e19b938c16d1ca24f8eb1f0be30262e3687d37a6b','3WY4u56aMUmE84T5lLYN','lixing@qq.com',NULL,1,3,'2018-11-16 09:13:02');
insert  into `sys_user`(`user_id`,`username`,`password`,`salt`,`email`,`mobile`,`status`,`dept_id`,`create_time`) values (7,'zhangjianing','b4c44d29c06009f953762e449087f534e07c98950b7a34703e96862f82075a1f','esQGA84bXZdfob7qPyfK','zhangjianing@qq.com',NULL,1,3,'2018-11-16 09:13:32');

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';

/*Data for the table `sys_user_role` */

insert  into `sys_user_role`(`id`,`user_id`,`role_id`) values (1,2,1);
insert  into `sys_user_role`(`id`,`user_id`,`role_id`) values (2,3,2);
insert  into `sys_user_role`(`id`,`user_id`,`role_id`) values (3,4,1);
insert  into `sys_user_role`(`id`,`user_id`,`role_id`) values (4,5,1);
insert  into `sys_user_role`(`id`,`user_id`,`role_id`) values (5,6,1);
insert  into `sys_user_role`(`id`,`user_id`,`role_id`) values (6,7,1);

/*Table structure for table `tb_token` */

DROP TABLE IF EXISTS `tb_token`;

CREATE TABLE `tb_token` (
  `user_id` bigint(20) NOT NULL,
  `token` varchar(100) NOT NULL COMMENT 'token',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户Token';

/*Data for the table `tb_token` */

/*Table structure for table `tb_user` */

DROP TABLE IF EXISTS `tb_user`;

CREATE TABLE `tb_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户';

/*Data for the table `tb_user` */

insert  into `tb_user`(`user_id`,`username`,`mobile`,`password`,`create_time`) values (1,'mark','admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','2017-03-23 22:37:41');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
