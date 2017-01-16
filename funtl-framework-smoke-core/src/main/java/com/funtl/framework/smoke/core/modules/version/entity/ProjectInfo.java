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

package com.funtl.framework.smoke.core.modules.version.entity;

import java.io.Serializable;

/**
 * Created by warne on 2016/11/30.
 * DESC: word brother 666
 */
public class ProjectInfo implements Serializable {
	private ProjectInfo parent;        // 父级编号
	private String parentIds;        // 所有父级编号
	private String prjCode;        // 项目编码
	private String prjCn;        // 项目中文名称
	private String prjEn;        // 项目英文名称
	private String prjShUrl;        // 构建地址

	public ProjectInfo getParent() {
		return parent;
	}

	public void setParent(ProjectInfo parent) {
		this.parent = parent;
	}

	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	public String getPrjCode() {
		return prjCode;
	}

	public void setPrjCode(String prjCode) {
		this.prjCode = prjCode;
	}

	public String getPrjCn() {
		return prjCn;
	}

	public void setPrjCn(String prjCn) {
		this.prjCn = prjCn;
	}

	public String getPrjEn() {
		return prjEn;
	}

	public void setPrjEn(String prjEn) {
		this.prjEn = prjEn;
	}

	public String getPrjShUrl() {
		return prjShUrl;
	}

	public void setPrjShUrl(String prjShUrl) {
		this.prjShUrl = prjShUrl;
	}
}
