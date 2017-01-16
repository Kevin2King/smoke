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

import java.util.List;

import com.funtl.framework.core.utils.Collections3;
import com.funtl.framework.core.utils.SpringContextHolder;
import com.funtl.framework.core.utils.StringUtils;
import com.funtl.framework.smoke.core.modules.sys.entity.Role;
import com.funtl.framework.smoke.core.modules.sys.service.SystemService;
import com.google.common.collect.Lists;

/**
 * 字段类型转换
 *
 * @author 李卫民
 */
public class RoleListType {

	private static SystemService systemService = SpringContextHolder.getBean(SystemService.class);

	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {
		List<Role> roleList = Lists.newArrayList();
		List<Role> allRoleList = systemService.findAllRole();
		for (String s : StringUtils.split(val, ",")) {
			for (Role e : allRoleList) {
				if (StringUtils.trimToEmpty(s).equals(e.getName())) {
					roleList.add(e);
				}
			}
		}
		return roleList.size() > 0 ? roleList : null;
	}

	/**
	 * 设置对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null) {
			@SuppressWarnings("unchecked") List<Role> roleList = (List<Role>) val;
			return Collections3.extractToString(roleList, "name", ", ");
		}
		return "";
	}

}
