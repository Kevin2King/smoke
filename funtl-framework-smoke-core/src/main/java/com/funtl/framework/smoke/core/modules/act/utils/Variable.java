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

package com.funtl.framework.smoke.core.modules.act.utils;

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.funtl.framework.core.utils.StringUtils;
import com.google.common.collect.Maps;

import org.apache.commons.beanutils.ConvertUtils;

/**
 * 流程变量对象
 *
 * @author
 * @version 2013-11-03
 */
public class Variable {

	private Map<String, Object> map = Maps.newHashMap();

	private String keys;
	private String values;
	private String types;

	public Variable() {

	}

	public Variable(Map<String, Object> map) {
		this.map = map;
	}

	public String getKeys() {
		return keys;
	}

	public void setKeys(String keys) {
		this.keys = keys;
	}

	public String getValues() {
		return values;
	}

	public void setValues(String values) {
		this.values = values;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	@JsonIgnore
	public Map<String, Object> getVariableMap() {

		ConvertUtils.register(new DateConverter(), java.util.Date.class);

		if (StringUtils.isBlank(keys)) {
			return map;
		}

		String[] arrayKey = keys.split(",");
		String[] arrayValue = values.split(",");
		String[] arrayType = types.split(",");
		for (int i = 0; i < arrayKey.length; i++) {
			String key = arrayKey[i];
			String value = arrayValue[i];
			String type = arrayType[i];

			Class<?> targetType = Enum.valueOf(PropertyType.class, type).getValue();
			Object objectValue = ConvertUtils.convert(value, targetType);
			map.put(key, objectValue);
		}
		return map;
	}

	public Map<String, Object> getMap() {
		return map;
	}

}
