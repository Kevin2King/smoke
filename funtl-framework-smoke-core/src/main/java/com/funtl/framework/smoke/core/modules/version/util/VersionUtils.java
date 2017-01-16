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

package com.funtl.framework.smoke.core.modules.version.util;

import lombok.Data;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.funtl.framework.core.utils.JedisUtils;
import com.funtl.framework.core.utils.SpringContextHolder;
import com.funtl.framework.smoke.core.modules.version.entity.VersionDto;
import com.funtl.framework.smoke.core.modules.version.entity.VersionInfo;
import com.funtl.framework.smoke.core.modules.version.service.VersionInfoService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import org.javatuples.Pair;

/**
 * Created by warne on 2016/12/2.
 * DESC: word brother 666
 * <p>
 * 版本信息utils
 */
public abstract class VersionUtils {

	/**
	 * 当前版本
	 *
	 * @return
	 */
	public static String versionName() {
		return Optional.ofNullable(getCurrentVersionInfo().getVersionName()).orElse("");
	}

	/**
	 * 唯一识别码
	 *
	 * @return
	 */
	public static String uniqueCode() {
		return Optional.ofNullable(getCurrentVersionInfo().getUniqueCode()).orElse("");
	}

	/**
	 * 是否最新版本
	 *
	 * @return
	 */
	public static boolean isNewestVersion() {
		return dealVersionsInfo().getValue0();
	}

	/**
	 * 构建出一个版本版本信息
	 *
	 * @param updateVersion
	 * @return
	 */
	public static Version4Api buildOneVersion(String callBackUrl, String updateVersion) {
		VersionInfo v = getCurrentVersionInfo();
		return new Version4Api().uniqueCode(uniqueCode()).versionName(versionName()).innerVersion(v.getInnerVersion()).projectCode(v.getProjectCode()).admin(v.getAdmin()).password(v.getPassword()).updateVersion(updateVersion).callbackUrl(callBackUrl);
	}

	/**
	 * map中获取版本信息,不存在时则查询数据库
	 *
	 * @return
	 */
	public static Pair<Boolean, List<VersionDto>> qryVersionsAndEqual4Map() {
		return versionInfoService.qryVersionsAndEqual();
	}

	private static VersionInfoService versionInfoService = SpringContextHolder.getBean(VersionInfoService.class);
	public static final String VERSION_LIST_INFO_MAP_KEY = "version_list_info_map_key";
	public static final String CURRENT_VERSION_INFO_KEY = "current_version_info_key";
	public static Map<String, Pair<Boolean, List<VersionDto>>> versionMap = Maps.newHashMap(); //# 存储版本列表信息

	/**
	 * //# 存储版本列表信息
	 *
	 * @return
	 */
	public static Pair<Boolean, List<VersionDto>> dealVersionsInfo() {
		Pair<Boolean, List<VersionDto>> versionInfoPair = (Pair<Boolean, List<VersionDto>>) JedisUtils.getObject(VERSION_LIST_INFO_MAP_KEY);
		if (versionInfoPair != null) {
			return versionInfoPair;
		}
		versionInfoPair = versionInfoService.qryVersionsAndEqual();
		JedisUtils.setObject(VERSION_LIST_INFO_MAP_KEY, versionInfoPair, 15 * 25 * 60 * 60); //# 15 days

		return Optional.ofNullable(versionInfoPair).orElse(Pair.with(false, Lists.newArrayList()));
	}

	/**
	 * 当前版本信息
	 *
	 * @return
	 */
	public static VersionInfo getCurrentVersionInfo() {
		VersionInfo version = (VersionInfo) JedisUtils.getObject(CURRENT_VERSION_INFO_KEY);
		if (version != null) {
			return version;
		}
		version = versionInfoService.findCurrentVersion();
		JedisUtils.setObject(CURRENT_VERSION_INFO_KEY, version, 15 * 24 * 60 * 60); //# 15 days

		return Optional.ofNullable(version).orElse(new VersionInfo());
	}

	/**
	 * Version4Api 内部版本信息，只适用于api
	 */
	@Data
	public static class Version4Api {
		private String uniqueCode;        // 唯一识别码
		private String versionName;        // 版本名称
		private String innerVersion;        // 内部版本号
		private String projectCode;        // 项目编码
		private String admin;        // 账号
		private String password;        // 密码
		private String callbackUrl;        // 回调地址
		private String updateVersion;        // 申请更新的版本

		public Version4Api uniqueCode(String uniqueCode) {
			this.uniqueCode = uniqueCode;
			return this;
		}

		public Version4Api versionName(String versionName) {
			this.versionName = versionName;
			return this;
		}

		public Version4Api innerVersion(String innerVersion) {
			this.innerVersion = innerVersion;
			return this;
		}

		public Version4Api updateVersion(String updateVersion) {
			this.updateVersion = updateVersion;
			return this;
		}

		public Version4Api projectCode(String projectCode) {
			this.projectCode = projectCode;
			return this;
		}

		public Version4Api admin(String admin) {
			this.admin = admin;
			return this;
		}

		public Version4Api password(String password) {
			this.password = password;
			return this;
		}

		public Version4Api callbackUrl(String callbackUrl) {
			this.callbackUrl = callbackUrl;
			return this;
		}

		public String print() {
			return " \n\t uniqueCode = " + uniqueCode + " \n\t projectCode = " + projectCode + " \n\t innerVersion = " + innerVersion + " \n\t versionName = " + versionName + " \n\t admin = " + admin + " \n\t callbackUrl = " + callbackUrl + " \n\t updateVersion = " + updateVersion + "\n";
		}
	}
}

