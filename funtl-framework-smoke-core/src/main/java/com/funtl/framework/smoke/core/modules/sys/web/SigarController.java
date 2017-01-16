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

package com.funtl.framework.smoke.core.modules.sys.web;

import java.util.Map;

import com.funtl.framework.core.utils.system.SysInfoAPI;
import com.funtl.framework.core.web.BaseController;
import com.google.common.collect.Maps;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.hyperic.sigar.SigarException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 系统监控
 * Created by 李卫民 on 2016/5/14.
 */
@Controller
@RequiresPermissions("sys:sigar:view")
@RequestMapping(value = "${adminPath}/sys/sigar")
public class SigarController extends BaseController {
	/**
	 * 物理内存总量
	 *
	 * @return
	 * @throws SigarException
	 */
	@ResponseBody
	@RequestMapping(value = "memory/total")
	public long getMemoryTotal() throws SigarException {
		return SysInfoAPI.getMemoryTotal();
	}

	/**
	 * 已用物理内存
	 *
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "memory/used")
	public long getMemoryUsed() throws SigarException {
		return SysInfoAPI.getMemoryUsed();
	}

	/**
	 * 物理内存使用率
	 *
	 * @return
	 * @throws SigarException
	 */
	@ResponseBody
	@RequestMapping(value = "memory/percent")
	public double getMemoryPercent() throws SigarException {
		return SysInfoAPI.getMemoryPercent();
	}

	/**
	 * CPU使用率
	 *
	 * @return
	 * @throws SigarException
	 */
	@ResponseBody
	@RequestMapping(value = "cpu/combined")
	public double getCpuCombined() throws SigarException {
		return SysInfoAPI.getCpuCombined();
	}

	/**
	 * 全部
	 *
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "all")
	public Map<String, Object> getAll() throws SigarException {
		Map<String, Object> map = Maps.newHashMap();
		map.put("memoryUsed", SysInfoAPI.getMemoryUsed());
		map.put("memoryPercent", SysInfoAPI.getMemoryPercent());
		map.put("cpuCombined", SysInfoAPI.getCpuCombined());
		return map;
	}
}
