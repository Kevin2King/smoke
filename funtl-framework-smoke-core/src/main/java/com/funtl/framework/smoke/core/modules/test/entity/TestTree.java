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

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.funtl.framework.smoke.core.commons.persistence.DataEntity;

import org.hibernate.validator.constraints.Length;

/**
 * 生成案例Entity
 *
 * @author 李卫民
 * @version 2016-10-31
 */
public class TestTree extends DataEntity<TestTree> {
	private TestTree parent;        // 父级编号
	private String parentIds;        // 所有父级编号
	private String name;        // 名称
	private String sort;        // 排序

	public TestTree() {
		super();
	}

	public TestTree(String id) {
		super(id);
	}

	@JsonBackReference
	@NotNull(message = "父级编号不能为空")
	public TestTree getParent() {
		return parent;
	}

	public void setParent(TestTree parent) {
		this.parent = parent;
	}

	@Length(min = 1, max = 2000, message = "所有父级编号长度必须介于 1 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	@Length(min = 1, max = 100, message = "名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

}