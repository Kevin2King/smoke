set session foreign_key_checks=0;

/* drop tables */

drop table if exists oa_notify;
drop table if exists oa_notify_record;


create table oa_notify
(
	id varchar(64) not null comment '编号',
	type char(1) comment '类型',
	title varchar(200) comment '标题',
	content varchar(2000) comment '内容',
	files varchar(2000) comment '附件',
	status char(1) comment '状态',
	create_by varchar(64) not null comment '创建者',
	create_date datetime not null comment '创建时间',
	update_by varchar(64) not null comment '更新者',
	update_date datetime not null comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记',
	primary key (id)
) comment = '通知通告';


create table oa_notify_record
(
	id varchar(64) not null comment '编号',
	oa_notify_id varchar(64) comment '通知通告id',
	user_id varchar(64) comment '接受人',
	read_flag char(1) default '0' comment '阅读标记',
	read_date date comment '阅读时间',
	primary key (id)
) comment = '通知通告发送记录';



/* create indexes */

create index oa_notify_del_flag on oa_notify (del_flag asc);
create index oa_notify_record_notify_id on oa_notify_record (oa_notify_id asc);
create index oa_notify_record_user_id on oa_notify_record (user_id asc);
create index oa_notify_record_read_flag on oa_notify_record (read_flag asc);