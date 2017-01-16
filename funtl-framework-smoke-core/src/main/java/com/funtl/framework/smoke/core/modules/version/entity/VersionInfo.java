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

import com.funtl.framework.smoke.core.commons.persistence.DataEntity;

import org.hibernate.validator.constraints.Length;

/**
 * 系统版本Entity
 *
 * @author warne
 * @version 2016-12-04
 */
public class VersionInfo extends DataEntity<VersionInfo> {
	private String uniqueCode;        // 唯一识别码
	private String versionName;        // 版本名称
	private String innerVersion;        // 内部版本号
	private String projectCode;        // 项目编码
	private String admin;        // 账号
	private String password;        // 密码
	private String serverUrl;        // 版本服务器地址
	private String apiVersion;        // api版本
	private String versionListUrl;        // 版本列表url
	private String callbackUrl;        // 回调地址
	private String versionUpdateUrl;        // 版本更新url
	private String updateVersion;        // 申请更新的版本

	public VersionInfo() {
		super();
	}

	public VersionInfo(String id) {
		super(id);
	}

	@Length(min = 1, max = 255, message = "唯一识别码长度必须介于 1 和 255 之间")
	public String getUniqueCode() {
		return uniqueCode;
	}

	public void setUniqueCode(String uniqueCode) {
		this.uniqueCode = uniqueCode;
	}

	@Length(min = 1, max = 255, message = "版本名称长度必须介于 1 和 255 之间")
	public String getVersionName() {
		return versionName;
	}

	public void setVersionName(String versionName) {
		this.versionName = versionName;
	}

	@Length(min = 1, max = 255, message = "内部版本号长度必须介于 1 和 255 之间")
	public String getInnerVersion() {
		return innerVersion;
	}

	public void setInnerVersion(String innerVersion) {
		this.innerVersion = innerVersion;
	}

	@Length(min = 1, max = 255, message = "项目编码长度必须介于 1 和 255 之间")
	public String getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}

	@Length(min = 1, max = 255, message = "账号长度必须介于 1 和 255 之间")
	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	@Length(min = 1, max = 255, message = "密码长度必须介于 1 和 255 之间")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Length(min = 1, max = 255, message = "版本服务器地址长度必须介于 1 和 255 之间")
	public String getServerUrl() {
		return serverUrl;
	}

	public void setServerUrl(String serverUrl) {
		this.serverUrl = serverUrl;
	}

	@Length(min = 1, max = 255, message = "api版本长度必须介于 1 和 255 之间")
	public String getApiVersion() {
		return apiVersion;
	}

	public void setApiVersion(String apiVersion) {
		this.apiVersion = apiVersion;
	}

	@Length(min = 0, max = 255, message = "版本列表url长度必须介于 0 和 255 之间")
	public String getVersionListUrl() {
		return versionListUrl;
	}

	public void setVersionListUrl(String versionListUrl) {
		this.versionListUrl = versionListUrl;
	}

	@Length(min = 1, max = 255, message = "回调地址长度必须介于 1 和 255 之间")
	public String getCallbackUrl() {
		return callbackUrl;
	}

	public void setCallbackUrl(String callbackUrl) {
		this.callbackUrl = callbackUrl;
	}

	@Length(min = 0, max = 255, message = "版本更新url长度必须介于 0 和 255 之间")
	public String getVersionUpdateUrl() {
		return versionUpdateUrl;
	}

	public void setVersionUpdateUrl(String versionUpdateUrl) {
		this.versionUpdateUrl = versionUpdateUrl;
	}

	@Length(min = 1, max = 255, message = "申请更新的版本长度必须介于 1 和 255 之间")
	public String getUpdateVersion() {
		return updateVersion;
	}

	public void setUpdateVersion(String updateVersion) {
		this.updateVersion = updateVersion;
	}

	public String print() {
		return " \n\t versionName= " + versionName + " \n\t innerVersion= " + innerVersion + " \n\t updateVersion= " + updateVersion + " \n\t projectCode= " + projectCode + " \n\t admin= " + admin + " \n\t uniqueCode= " + uniqueCode + " \n\t versionServerUrl= " + serverUrl + " \n\t callbackIp=" + callbackUrl + "\n";
	}

}