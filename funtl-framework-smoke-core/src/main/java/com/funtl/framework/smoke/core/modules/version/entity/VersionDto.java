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
import java.util.Date;

/**
 * Created by warne on 2016/11/30.
 * DESC: word brother 666
 */

public class VersionDto implements Serializable {

	private String inVerNo;        // 内部版本号
	private String exVerNo;        // 外部版本号
	private String verFeature;        // 新增功能描述
	private String verFixbug;        // 修复缺陷说明
	private Date releaseTime;        // 发布时间
	private ProjectInfo prjInfo;        // 归属项目

	private String currentVersion;

	public String getCurrentVersion() {
		return currentVersion;
	}

	public void setCurrentVersion(String currentVersion) {
		this.currentVersion = currentVersion;
	}

	public String getInVerNo() {
		return inVerNo;
	}

	public void setInVerNo(String inVerNo) {
		this.inVerNo = inVerNo;
	}

	public String getExVerNo() {
		return exVerNo;
	}

	public void setExVerNo(String exVerNo) {
		this.exVerNo = exVerNo;
	}

	public String getVerFeature() {
		return verFeature;
	}

	public void setVerFeature(String verFeature) {
		this.verFeature = verFeature;
	}

	public String getVerFixbug() {
		return verFixbug;
	}

	public void setVerFixbug(String verFixbug) {
		this.verFixbug = verFixbug;
	}

	public Date getReleaseTime() {
		return releaseTime;
	}

	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
	}

	public ProjectInfo getPrjInfo() {
		return prjInfo;
	}

	public void setPrjInfo(ProjectInfo prjInfo) {
		this.prjInfo = prjInfo;
	}
}
