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

package com.funtl.framework.smoke.core.modules.sys.entity;

import com.funtl.framework.smoke.core.commons.persistence.TreeEntity;

import org.hibernate.validator.constraints.Length;

/**
 * 区域Entity
 *
 * @author 李卫民
 */
public class Area extends TreeEntity<Area> {
	//	private Area parent;	// 父级编号
	//	private String parentIds; // 所有父级编号
	private String code;    // 区域编码
	//	private String name; 	// 区域名称
	//	private Integer sort;		// 排序
	private String type;    // 区域类型（1：国家；2：省份、直辖市；3：地市；4：区县）

	public Area() {
		super();
		this.sort = 30;
	}

	public Area(String id) {
		super(id);
	}

	//	@JsonBackReference
	//	@NotNull
	public Area getParent() {
		return parent;
	}

	public void setParent(Area parent) {
		this.parent = parent;
	}
	//
	//	@Length(min=1, max=2000)
	//	public String getParentIds() {
	//		return parentIds;
	//	}
	//
	//	public void setParentIds(String parentIds) {
	//		this.parentIds = parentIds;
	//	}
	//
	//	@Length(min=1, max=100)
	//	public String getName() {
	//		return name;
	//	}
	//
	//	public void setName(String name) {
	//		this.name = name;
	//	}
	//
	//	public Integer getSort() {
	//		return sort;
	//	}
	//
	//	public void setSort(Integer sort) {
	//		this.sort = sort;
	//	}

	@Length(min = 1, max = 1)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Length(min = 0, max = 100)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	//
	//	public String getParentId() {
	//		return parent != null && parent.getId() != null ? parent.getId() : "0";
	//	}

	@Override
	public String toString() {
		return name;
	}
}