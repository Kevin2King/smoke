/*
 * Copyright 2015-2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.funtl.framework.smoke.core.commons.persistence;


import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.funtl.framework.core.utils.IdGen;
import com.funtl.framework.smoke.core.modules.sys.entity.User;
import com.funtl.framework.smoke.core.modules.sys.utils.UserUtils;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

/**
 * 数据Entity类
 *
 * @author 李卫民
 */
public abstract class DataEntity<T> extends BaseEntity<T> {
	private static final String SYSTEM_ID = "a7d05bd3bd374c49a3a9235d45b9650b";

	protected String remarks;    // 备注
	protected User createBy;    // 创建者
	protected Date createDate;    // 创建日期
	protected User updateBy;    // 更新者
	protected Date updateDate;    // 更新日期
	protected String delFlag;    // 删除标记（0：正常；1：删除；2：审核）

	public DataEntity() {
		super();
		this.delFlag = DEL_FLAG_NORMAL;
	}

	public DataEntity(String id) {
		super(id);
	}

	/**
	 * 插入之前执行方法，需要手动调用
	 */
	@Override
	public void preInsert() {
		// 不限制ID为UUID，调用setIsNewRecord()使用自定义ID
		if (!this.isNewRecord) {
			setId(IdGen.uuid());
		}
		User user = UserUtils.getUser();

		// 在未登录状态下的处理方式，比如前台请求增删改操作，使用system用户统一处理
		if (user.getId() == null) {
			user = new User();
			user.setId(SYSTEM_ID);
		}
		if (StringUtils.isNotBlank(user.getId())) {
			this.updateBy = user;
			this.createBy = user;
		}
		this.updateDate = new Date();
		this.createDate = this.updateDate;
	}

	/**
	 * 更新之前执行方法，需要手动调用
	 */
	@Override
	public void preUpdate() {
		User user = UserUtils.getUser();
		// 在未登录状态下的处理方式，比如前台请求增删改操作，使用system用户统一处理
		if (user.getId() == null) {
			user = new User();
			user.setId(SYSTEM_ID);
		}
		if (StringUtils.isNotBlank(user.getId())) {
			this.updateBy = user;
		}
		this.updateDate = new Date();
	}

	@Length(min = 0, max = 255)
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	@JsonIgnore
	public User getCreateBy() {
		return createBy;
	}

	public void setCreateBy(User createBy) {
		this.createBy = createBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@JsonIgnore
	public User getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(User updateBy) {
		this.updateBy = updateBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@JsonIgnore
	@Length(min = 1, max = 1)
	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

}
