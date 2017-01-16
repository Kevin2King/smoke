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

package com.funtl.framework.smoke.core.modules.version.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.core.type.TypeReference;
import com.funtl.framework.apache.httpclient.HttpClientUtil;
import com.funtl.framework.core.dto.BaseResult;
import com.funtl.framework.core.mapper.JsonMapper;
import com.funtl.framework.core.security.MD5Utils;
import com.funtl.framework.core.utils.Collections3;
import com.funtl.framework.core.utils.DateUtils;
import com.funtl.framework.core.utils.StringUtils;
import com.funtl.framework.smoke.core.commons.persistence.Page;
import com.funtl.framework.smoke.core.commons.service.CrudService;
import com.funtl.framework.smoke.core.commons.trans.ReMsg;
import com.funtl.framework.smoke.core.modules.version.dao.VersionInfoDao;
import com.funtl.framework.smoke.core.modules.version.entity.VersionDto;
import com.funtl.framework.smoke.core.modules.version.entity.VersionInfo;
import com.funtl.framework.smoke.core.modules.version.util.VersionUtils;
import com.google.common.collect.Lists;

import org.apache.http.NameValuePair;
import org.javatuples.Pair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 系统版本Service
 *
 * @author warne
 * @version 2016-12-04
 */
@Service
@Transactional(readOnly = true)
public class VersionInfoService extends CrudService<VersionInfoDao, VersionInfo> implements IVersion {

	public VersionInfo get(String id) {
		return super.get(id);
	}

	public List<VersionInfo> findList(VersionInfo versionInfo) {
		return super.findList(versionInfo);
	}

	public Page<VersionInfo> findPage(Page<VersionInfo> page, VersionInfo versionInfo) {
		return super.findPage(page, versionInfo);
	}

	@Transactional(readOnly = false)
	public void save(VersionInfo versionInfo) {
		super.save(versionInfo);
	}

	@Transactional(readOnly = false)
	public void delete(VersionInfo versionInfo) {
		super.delete(versionInfo);
	}

	//========================================================================================================================
	//========================================================================================================================
	//========================================================================================================================

	/**
	 * 获取当前版本信息
	 *
	 * @return
	 */
	public VersionInfo findCurrentVersion() {
		return Optional.ofNullable(super.dao.findCurrentVersion()).orElse(new VersionInfo());
	}

	/**
	 * 升级
	 *
	 * @param request
	 * @param updateVersion 即将更新的版本
	 */
	@Transactional(readOnly = false)
	public ReMsg doUpdateGrade(HttpServletRequest request, String updateVersion) {
		String updateUrl = genVersionExchangeUrl(findCurrentVersion(), ACTION_UPDATE);
		String callbackIp = getIP(request);

		VersionUtils.Version4Api version4Api = VersionUtils.buildOneVersion(callbackIp, updateVersion);
		logger.warn("\n----------------------------------------------------------------------------------------------------------------------\n " + "时间戳：{}, 请求地址：{}, 更新的版本新信息：{}\n", DateUtils.getDateTime(), updateUrl, version4Api.print() + "=====================================================================================================================\n");
		try {
			List<NameValuePair> params = httpClient.convert2Params(version4Api);
			String result = httpClient.postData(updateUrl, params);
			System.out.println("-----------result=" + result);
			ReMsg reMsg = jsonMapper.readValue(result, ReMsg.class);
			return reMsg;
		} catch (Exception e) {
			logger.error("---更新系统失败---\n" + "请求地址: {}\n" + "versionInfo: {}\n", updateUrl, version4Api.print(), "\n", e);
		}

		return error();
	}

	/**
	 * 修改密码
	 *
	 * @param passwd
	 * @return
	 */
	@Transactional(readOnly = false)
	public ReMsg doModifyPasswd(String passwd) {
		VersionInfo v = VersionUtils.getCurrentVersionInfo();
		try {
			v.setPassword(MD5Utils.getMD5StringWithSalt(passwd, "%^&*"));
			super.dao.modifyPassword(v);
		} catch (Exception e) {
			logger.error("---修改密码失败,识别码：{}", v.getUniqueCode(), e);
			return error();
		}

		return success();
	}

	/**
	 * 回退
	 */
	public void doRollbackGrade() {
	}

	/**
	 * 从version服务器读取版本列表
	 * 并判断当前版本和服务器版本作比较
	 *
	 * @return arg0：是否为最新版本
	 * arg1: 服务器版本列表
	 */
	public Pair<Boolean, List<VersionDto>> qryVersionsAndEqual() {
		Pair resultPair = Pair.with(true, Lists.newArrayList());

		VersionInfo currVersion = findCurrentVersion();
		String innerVersion = currVersion.getInnerVersion();
		String url = genVersionExchangeUrl(currVersion, ACTION_QUERY);

		BaseResult<List<VersionDto>> result = null;
		try {
			String json = httpClient.postData(url, Lists.newArrayList());
			if (StringUtils.isBlank(json)) {
				logger.error("---查询版本信息没有返回数据！请求地址：{} \n", url);
				return resultPair;
			}
			result = jsonMapper.readValue(json, new TypeReference<BaseResult<List<VersionDto>>>() {
			});
		} catch (Exception e) {
			logger.error("---查询版本信息发发生异常！\n 请求地址：{} \n", url, e);
			return resultPair;
		}

		if (result == null) {
			logger.error("---没有查询到任何的版本信息！\n 请求url：{} \n", url);
			return resultPair;
		}

		List<VersionDto> projectVersions = result.getData();
		if (Collections3.isEmpty(projectVersions)) {
			return resultPair;
		}

		final List<VersionDto> versions = projectVersions.stream().map(c -> {
			if (c.getInVerNo().equalsIgnoreCase(innerVersion)) {
				c.setCurrentVersion("currentVersion");
			}
			return c;
		}).sorted((c, o) -> o.getInVerNo().compareTo(c.getInVerNo())).collect(Collectors.toList());

		//# 是否最新版本
		if (currVersion.getInnerVersion().equalsIgnoreCase(versions.get(0).getInVerNo())) {
			return Pair.with(true, versions);
		}

		return resultPair.setAt0(false).setAt1(versions);
	}

	/**
	 * 是否可更新
	 *
	 * @return
	 */
	public ReMsg WhetherUpdate() {
		String innerVersion = findCurrentVersion().getInnerVersion();
		final List<VersionDto> versions = this.qryVersionsAndEqual().getValue1();

		/** 0. 干掉乱七八糟的request */
		if (Collections3.isEmpty(versions)) {
			return error();
		}

		VersionDto newest = versions.get(0);
		/** 1. 先检查版本是不是存在 */
		if (versions.stream().filter(v -> innerVersion.equalsIgnoreCase(v.getInVerNo())).count() < 1) {
			return unknownVersion();
		}
		/** 2. 先检查版本是不是最新版本 */
		if (innerVersion.equalsIgnoreCase(newest.getInVerNo())) {
			return isLatest();
		}

		/** 3. 检查当前版本是否低于最新版本 */
		if (Integer.parseInt(innerVersion) < Integer.parseInt(newest.getInVerNo())) {
			return allowUpdate();
		}

		return error(); //# 艹，吊了...

	}


	private static final Logger logger = LoggerFactory.getLogger(VersionInfoService.class);
	private HttpClientUtil httpClient = new HttpClientUtil();
	private JsonMapper jsonMapper = JsonMapper.getInstance();

	/**
	 * 处理与服务器交互地址
	 *
	 * @param v
	 * @return
	 */
	private String genVersionExchangeUrl(VersionInfo v, String actionCode) {
		if (v == null) {
			return "version_info_is_null";
		}

		String serverUrl = nvl4String(v.getServerUrl());
		String apiVersion = nvl4String(v.getApiVersion());
		String url = null;
		switch (actionCode) {
			case ACTION_QUERY:
				url = nvl4String(v.getVersionListUrl());
				break;
			case ACTION_UPDATE:
				url = nvl4String(v.getVersionUpdateUrl());
				break;
			default:
				url = StringUtils.EMPTY;
		}

		String projectCode = nvl4String(v.getProjectCode());

		return serverUrl + apiVersion + url + projectCode;
	}


	/**
	 * get remote ip
	 *
	 * @param request
	 * @return
	 */
	private String getIP(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		System.out.println("current ip: " + ip);
		return ip;
	}

}