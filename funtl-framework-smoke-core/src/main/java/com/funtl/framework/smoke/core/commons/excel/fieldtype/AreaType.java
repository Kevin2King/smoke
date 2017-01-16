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

package com.funtl.framework.smoke.core.commons.excel.fieldtype;

import com.funtl.framework.core.utils.StringUtils;
import com.funtl.framework.smoke.core.modules.sys.entity.Area;
import com.funtl.framework.smoke.core.modules.sys.utils.UserUtils;

/**
 * 字段类型转换
 *
 * @author 李卫民
 */
public class AreaType {

	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {
		for (Area e : UserUtils.getAreaList()) {
			if (StringUtils.trimToEmpty(val).equals(e.getName())) {
				return e;
			}
		}
		return null;
	}

	/**
	 * 获取对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null && ((Area) val).getName() != null) {
			return ((Area) val).getName();
		}
		return "";
	}
}
