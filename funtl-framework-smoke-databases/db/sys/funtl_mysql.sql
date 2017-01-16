set session foreign_key_checks=0;

/* drop tables */

drop table if exists sys_role_office;
drop table if exists sys_user_role;
drop table if exists sys_user;
drop table if exists sys_office;
drop table if exists sys_area;
drop table if exists sys_dict;
drop table if exists sys_log;
drop table if exists sys_mdict;
drop table if exists sys_role_menu;
drop table if exists sys_menu;
drop table if exists sys_role;
drop table if exists task_job;
drop table if exists sys_mail;


/* create tables */

create table sys_area
(
	id varchar(64) not null comment '编号',
	parent_id varchar(64) not null comment '父级编号',
	parent_ids varchar(2000) not null comment '所有父级编号',
	name varchar(100) not null comment '名称',
	sort decimal(10,0) not null comment '排序',
	code varchar(100) comment '区域编码',
	type char(1) comment '区域类型',
	create_by varchar(64) not null comment '创建者',
	create_date datetime not null comment '创建时间',
	update_by varchar(64) not null comment '更新者',
	update_date datetime not null comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记',
	primary key (id)
) comment = '区域表';


create table sys_dict
(
	id varchar(64) not null comment '编号',
	value varchar(100) not null comment '数据值',
	label varchar(100) not null comment '标签名',
	type varchar(100) not null comment '类型',
	description varchar(100) not null comment '描述',
	sort decimal(10,0) not null comment '排序（升序）',
	parent_id varchar(64) default '0' comment '父级编号',
	create_by varchar(64) not null comment '创建者',
	create_date datetime not null comment '创建时间',
	update_by varchar(64) not null comment '更新者',
	update_date datetime not null comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记',
	primary key (id)
) comment = '字典表';


create table sys_log
(
	id varchar(64) not null comment '编号',
	type char(1) default '1' comment '日志类型',
	title varchar(255) default '' comment '日志标题',
	create_by varchar(64) comment '创建者',
	create_date datetime comment '创建时间',
	remote_addr varchar(255) comment '操作ip地址',
	user_agent varchar(255) comment '用户代理',
	request_uri varchar(255) comment '请求uri',
	method varchar(5) comment '操作方式',
	params text comment '操作提交的数据',
	exception text comment '异常信息',
	primary key (id)
) comment = '日志表';


create table sys_mdict
(
	id varchar(64) not null comment '编号',
	parent_id varchar(64) not null comment '父级编号',
	parent_ids varchar(2000) not null comment '所有父级编号',
	name varchar(100) not null comment '名称',
	sort decimal(10,0) not null comment '排序',
	description varchar(100) comment '描述',
	create_by varchar(64) not null comment '创建者',
	create_date datetime not null comment '创建时间',
	update_by varchar(64) not null comment '更新者',
	update_date datetime not null comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记',
	primary key (id)
) comment = '多级字典表';


create table sys_menu
(
	id varchar(64) not null comment '编号',
	parent_id varchar(64) not null comment '父级编号',
	parent_ids varchar(2000) not null comment '所有父级编号',
	name varchar(100) not null comment '名称',
	sort decimal(10,0) not null comment '排序',
	href varchar(2000) comment '链接',
	target varchar(20) comment '目标',
	icon varchar(100) comment '图标',
	is_show char(1) not null comment '是否在菜单中显示',
	permission varchar(200) comment '权限标识',
	create_by varchar(64) not null comment '创建者',
	create_date datetime not null comment '创建时间',
	update_by varchar(64) not null comment '更新者',
	update_date datetime not null comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记',
	primary key (id)
) comment = '菜单表';


create table sys_office
(
	id varchar(64) not null comment '编号',
	parent_id varchar(64) not null comment '父级编号',
	parent_ids varchar(2000) not null comment '所有父级编号',
	name varchar(100) not null comment '名称',
	sort decimal(10,0) not null comment '排序',
	area_id varchar(64) not null comment '归属区域',
	code varchar(100) comment '区域编码',
	type char(1) not null comment '机构类型',
	grade char(1) not null comment '机构等级',
	address varchar(255) comment '联系地址',
	zip_code varchar(100) comment '邮政编码',
	master varchar(100) comment '负责人',
	phone varchar(200) comment '电话',
	fax varchar(200) comment '传真',
	email varchar(200) comment '邮箱',
	useable varchar(64) comment '是否启用',
	primary_person varchar(64) comment '主负责人',
	deputy_person varchar(64) comment '副负责人',
	create_by varchar(64) not null comment '创建者',
	create_date datetime not null comment '创建时间',
	update_by varchar(64) not null comment '更新者',
	update_date datetime not null comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记',
	primary key (id)
) comment = '机构表';


create table sys_role
(
	id varchar(64) not null comment '编号',
	office_id varchar(64) comment '归属机构',
	name varchar(100) not null comment '角色名称',
	enname varchar(255) comment '英文名称',
	role_type varchar(255) comment '角色类型',
	data_scope char(1) comment '数据范围',
	is_sys varchar(64) comment '是否系统数据',
	useable varchar(64) comment '是否可用',
	create_by varchar(64) not null comment '创建者',
	create_date datetime not null comment '创建时间',
	update_by varchar(64) not null comment '更新者',
	update_date datetime not null comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记',
	primary key (id)
) comment = '角色表';


create table sys_role_menu
(
	role_id varchar(64) not null comment '角色编号',
	menu_id varchar(64) not null comment '菜单编号',
	primary key (role_id, menu_id)
) comment = '角色-菜单';


create table sys_role_office
(
	role_id varchar(64) not null comment '角色编号',
	office_id varchar(64) not null comment '机构编号',
	primary key (role_id, office_id)
) comment = '角色-机构';


create table sys_user
(
	id varchar(64) not null comment '编号',
	company_id varchar(64) not null comment '归属公司',
	office_id varchar(64) not null comment '归属部门',
	login_name varchar(100) not null comment '登录名',
	password varchar(100) not null comment '密码',
	no varchar(100) comment '工号',
	name varchar(100) not null comment '姓名',
	email varchar(200) comment '邮箱',
	phone varchar(200) comment '电话',
	mobile varchar(200) comment '手机',
	user_type char(1) comment '用户类型',
	photo varchar(1000) comment '用户头像',
	login_ip varchar(100) comment '最后登陆ip',
	login_date datetime comment '最后登陆时间',
	login_flag varchar(64) comment '是否可登录',
	create_by varchar(64) not null comment '创建者',
	create_date datetime not null comment '创建时间',
	update_by varchar(64) not null comment '更新者',
	update_date datetime not null comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记',
	primary key (id)
) comment = '用户表';


create table sys_user_role
(
	user_id varchar(64) not null comment '用户编号',
	role_id varchar(64) not null comment '角色编号',
	primary key (user_id, role_id)
) comment = '用户-角色';

create table task_job
(
   id                   varchar(36) not null comment '编号',
   task_job_code        varchar(50) not null comment '任务编码',
   task_job_name        varchar(100) not null comment '任务名称',
   task_job_group       varchar(100) comment '任务分组',
   task_job_cron        varchar(50) comment '任务表达式',
   task_job_status      varchar(2) default '0' comment '任务状态',
   task_job_bean        varchar(100) comment '任务调用类',
   task_job_concurrent  varchar(2) comment '是否有状态',
   task_job_spring      varchar(100) comment 'SPRING',
   task_job_method      varchar(100) comment '任务调用方法',
   task_job_ip          varchar(60) comment '执行服务器IP',
   sort                 integer default '100' comment '排序',
   create_by            varchar(36) not null comment '创建人',
   create_date          datetime not null comment '创建日期',
   update_by            varchar(36) not null comment '更新人员',
   update_date          datetime not null comment '更新时间',
   remarks              varchar(255) comment '备注',
   del_flag             varchar(1) not null default '0' comment '删除标记',
   primary key (id)
) comment '计划任务表';

create table sys_mail
(
	id varchar(36) not null comment '编号',
	mail_host varchar(100) not null comment '主机名',
	mail_port decimal(10,0) not null comment '主机端口',
	mail_username varchar(100) not null comment '邮箱地址',
	mail_password varchar(100) not null comment '邮箱密码',
	mail_from varchar(100) not null comment '发件人昵称',
	mail_ssl varchar(1) not null comment '使用SSL/TLS',
	primary key (id)
) comment = '邮箱配置表';


/* create indexes */

create index sys_area_parent_id on sys_area (parent_id asc);
/*create index sys_area_parent_ids on sys_area (parent_ids asc);*/
create index sys_area_del_flag on sys_area (del_flag asc);
create index sys_dict_value on sys_dict (value asc);
create index sys_dict_label on sys_dict (label asc);
create index sys_dict_del_flag on sys_dict (del_flag asc);
create index sys_log_create_by on sys_log (create_by asc);
create index sys_log_type on sys_log (type asc);
create index sys_log_create_date on sys_log (create_date asc);
create index sys_mdict_parent_id on sys_mdict (parent_id asc);
/*create index sys_mdict_parent_ids on sys_mdict (parent_ids asc);*/
create index sys_mdict_del_flag on sys_mdict (del_flag asc);
create index sys_menu_parent_id on sys_menu (parent_id asc);
/*create index sys_menu_parent_ids on sys_menu (parent_ids asc);*/
create index sys_menu_del_flag on sys_menu (del_flag asc);
create index sys_office_parent_id on sys_office (parent_id asc);
/*create index sys_office_parent_ids on sys_office (parent_ids asc);*/
create index sys_office_del_flag on sys_office (del_flag asc);
create index sys_office_type on sys_office (type asc);
create index sys_role_del_flag on sys_role (del_flag asc);
create index sys_user_office_id on sys_user (office_id asc);
create index sys_user_login_name on sys_user (login_name asc);
create index sys_user_company_id on sys_user (company_id asc);
create index sys_user_update_date on sys_user (update_date asc);
create index sys_user_del_flag on sys_user (del_flag asc);
create index task_job_del_flag on task_job(del_flag asc);



