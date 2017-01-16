set session foreign_key_checks=0;

/* drop tables*/

drop table if exists gen_scheme;
drop table if exists gen_table_column;
drop table if exists gen_table;
drop table if exists gen_template; 

/* create tables */

create table gen_scheme
(
	id varchar(64) not null comment '编号',
	name varchar(200) comment '名称',
	category varchar(2000) comment '分类',
	package_name varchar(500) comment '生成包路径',
	module_name varchar(30) comment '生成模块名',
	sub_module_name varchar(30) comment '生成子模块名',
	function_name varchar(500) comment '生成功能名',
	function_name_simple varchar(100) comment '生成功能名（简写）',
	function_author varchar(100) comment '生成功能作者',
	gen_table_id varchar(200) comment '生成表编号',
	create_by varchar(64) comment '创建者',
	create_date datetime comment '创建时间',
	update_by varchar(64) comment '更新者',
	update_date datetime comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记（0：正常；1：删除）',
	primary key (id)
) comment = '生成方案';


create table gen_table
(
	id varchar(64) not null comment '编号',
	name varchar(200) comment '名称',
	comments varchar(500) comment '描述',
	primary_id varchar(100) not null comment '主键标识',
	class_name varchar(100) comment '实体类名称',
	parent_table varchar(200) comment '关联父表',
	parent_table_fk varchar(100) comment '关联父表外键',
	create_by varchar(64) comment '创建者',
	create_date datetime comment '创建时间',
	update_by varchar(64) comment '更新者',
	update_date datetime comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记（0：正常；1：删除）',
	primary key (id)
) comment = '业务表';


create table gen_table_column
(
	id varchar(64) not null comment '编号',
	gen_table_id varchar(64) comment '归属表编号',
	name varchar(200) comment '名称',
	comments varchar(500) comment '描述',
	jdbc_type varchar(100) comment '列的数据类型的字节长度',
	java_type varchar(500) comment 'java类型',
	java_field varchar(200) comment 'java字段名',
	is_pk char(1) comment '是否主键',
	is_null char(1) comment '是否可为空',
	is_insert char(1) comment '是否为插入字段',
	is_edit char(1) comment '是否编辑字段',
	is_list char(1) comment '是否列表字段',
	is_query char(1) comment '是否查询字段',
	query_type varchar(200) comment '查询方式（等于、不等于、大于、小于、范围、左like、右like、左右like）',
	show_type varchar(200) comment '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
	dict_type varchar(200) comment '字典类型',
	settings varchar(2000) comment '其它设置（扩展字段json）',
	sort decimal comment '排序（升序）',
	create_by varchar(64) comment '创建者',
	create_date datetime comment '创建时间',
	update_by varchar(64) comment '更新者',
	update_date datetime comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(64) default '0' not null comment '删除标记（0：正常；1：删除）',
	primary key (id)
) comment = '业务表字段';


create table gen_template
(
	id varchar(64) not null comment '编号',
	name varchar(200) comment '名称',
	category varchar(2000) comment '分类',
	file_path varchar(500) comment '生成文件路径',
	file_name varchar(200) comment '生成文件名',
	content text comment '内容',
	create_by varchar(64) comment '创建者',
	create_date datetime comment '创建时间',
	update_by varchar(64) comment '更新者',
	update_date datetime comment '更新时间',
	remarks varchar(255) comment '备注信息',
	del_flag char(1) default '0' not null comment '删除标记（0：正常；1：删除）',
	primary key (id)
) comment = '代码模板表';


/* create indexes */

create index gen_scheme_del_flag on gen_scheme (del_flag asc);
create index gen_table_del_flag on gen_table (del_flag asc);
create index gen_table_column_table_id on gen_table_column (gen_table_id asc);
create index gen_table_column_sort on gen_table_column (sort asc);
create index gen_table_column_del_flag on gen_table_column (del_flag asc);
create index gen_template_del_falg on gen_template (del_flag asc);



