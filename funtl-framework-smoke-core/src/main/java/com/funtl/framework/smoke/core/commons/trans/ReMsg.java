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

package com.funtl.framework.smoke.core.commons.trans;

import java.io.Serializable;
import java.util.Map;

import com.google.common.collect.Maps;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

/**
 * @author warne create by 2016/12/14
 * @version: V1.1.0
 * @desc: 对于返回类型的结果使用该DTO来实现数据传输，
 */
public final class ReMsg implements Serializable {
	private Boolean state = false;
	private String code = "";
	private String msg = "";
	private Map<String, Object> param = null; //主要用于增加简单参数的扩展


	/**
	 * 增加参数
	 */
	public ReMsg param(String name, Object value) {
		if (param == null) {
			param = Maps.newHashMap();
		}
		if (value == null) {
			param.put(name, "");
		} else {
			param.put(name, value);
		}
		return this;
	}

	/**
	 * 清空参数
	 */
	public void clean() {
		if (param != null) {
			param.clear();
		}
	}

	private ReMsg() {
	}

	public String code() {
		return code;
	}

	public Boolean state() {
		return state;
	}

	public ReMsg state(Boolean state) {
		this.state = state;
		return this;
	}

	public ReMsg code(String code) {
		this.code = code;
		return this;

	}

	public String msg() {
		return msg;
	}

	public ReMsg msg(String msg) {
		this.msg = msg;
		return this;
	}

	public Map<String, Object> param() {
		return param;
	}

	public ReMsg param(Map<String, Object> param) {
		if (param != null && param.size() != 0) {
			this.param.putAll(param);
		}
		return this;
	}

	private static ReMsg getMsgInstance() {
		return new ReMsg();
	}

	public static ReMsg of(Boolean state, String code, String msg) {
		return getMsgInstance().state(state).code(code).msg(msg);
	}

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}
}
