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

package com.funtl.framework.smoke.core.modules.sys.api;

import java.util.Map;

import com.funtl.framework.core.web.BaseController;
import com.funtl.framework.smoke.core.modules.sys.utils.quartz.JobTaskService;
import com.google.common.collect.Maps;

import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 调度任务
 * Created by Lusifer on 2015/11/18.
 */
@Controller
@RequestMapping(value = "${apiPath}/sys/task")
public class TaskJobAPIController extends BaseController {
	@Autowired
	private JobTaskService jobTaskService;

	/**
	 * 改变任务状态
	 *
	 * @param id
	 * @param cmd
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "status")
	public Map<String, Object> changeJobStatus(String id, String cmd) {
		Map<String, Object> map = Maps.newHashMap();

		try {
			jobTaskService.changeStatus(id, cmd);
		} catch (SchedulerException e) {
			map.put("message", "任务状态改变失败");
		}
		map.put("message", "任务状态改变成功");

		return map;
	}
}
