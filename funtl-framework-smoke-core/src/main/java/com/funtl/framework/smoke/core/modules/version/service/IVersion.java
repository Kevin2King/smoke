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

import java.util.Optional;

import com.funtl.framework.smoke.core.commons.trans.ReMsg;

/**
 * Created by jetty on 2016/12/14.
 */
public interface IVersion {

	String EMPTY = " ";

	String ACTION_UPDATE = "update"; //# 更新
	String ACTION_QUERY = "query";  //# 查询

	String SUCCESS = "0000";
	String SUCCESS_DESC = "成功";
	String PASSWORD_ERROR = "0001";
	String PASSWORD_ERROR_DESC = "服务器root密码错误";
	String PROJECT_NOT_EXIST = "0002";
	String PROJECT_NOT_EXIST_DESC = "请求更新的项目不存在";
	String ERROR = "0003";
	String ERROR_DESC = "发生错误,刷新试试";


	String UNKNOWN_VERSION = "1000";
	String UNKNOWN_VERSION_DESC = "没有找到请求的版本";
	String ALLOW_UPDATE = "1001";
	String ALLOW_UPDATE_DESC = "可以更新版本";
	String IS_LATEST = "1002";
	String IS_LATEST_DESC = "已经是最新版本，无需更新";


	default ReMsg success() {
		return ReMsg.of(true, SUCCESS, SUCCESS_DESC);
	}

	default ReMsg passwdError() {
		return ReMsg.of(false, PASSWORD_ERROR, PASSWORD_ERROR_DESC);
	}

	default ReMsg projectNotExist() {
		return ReMsg.of(false, PROJECT_NOT_EXIST, PROJECT_NOT_EXIST_DESC);
	}

	default ReMsg error() {
		return ReMsg.of(false, ERROR, ERROR_DESC);
	}

	default ReMsg unknownVersion() {
		return ReMsg.of(false, UNKNOWN_VERSION, UNKNOWN_VERSION_DESC);
	}

	default ReMsg allowUpdate() {
		return ReMsg.of(true, ALLOW_UPDATE, ALLOW_UPDATE_DESC);
	}

	default ReMsg isLatest() {
		return ReMsg.of(false, IS_LATEST, IS_LATEST_DESC);
	}

	default ReMsg initMsg() {
		return ReMsg.of(false, "", "");
	}

	/**
	 * 是null时 返回""
	 *
	 * @param srcStr
	 * @return
	 */
	default String nvl4String(String srcStr) {
		return Optional.ofNullable(srcStr).orElse(EMPTY);
	}
}
