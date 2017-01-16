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

package com.funtl.framework.smoke.core.modules.test.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.funtl.framework.smoke.core.modules.sys.entity.Area;
import com.funtl.framework.smoke.core.modules.sys.entity.Office;
import com.funtl.framework.smoke.core.commons.persistence.DataEntity;
import com.funtl.framework.smoke.core.modules.sys.entity.User;

import org.hibernate.validator.constraints.Length;

/**
 * 生成案例Entity
 *
 * @author 李卫民
 * @version 2016-10-31
 */
public class TestData extends DataEntity<TestData> {
	private User user;        // 归属用户
	private Office office;        // 归属部门
	private Area area;        // 归属区域
	private String name;        // 名称
	private String sex;        // 性别
	private Date inDate;        // 加入日期

	public TestData() {
		super();
	}

	public TestData(String id) {
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	@Length(min = 0, max = 100, message = "名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Length(min = 0, max = 1, message = "性别长度必须介于 0 和 1 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getInDate() {
		return inDate;
	}

	public void setInDate(Date inDate) {
		this.inDate = inDate;
	}

}