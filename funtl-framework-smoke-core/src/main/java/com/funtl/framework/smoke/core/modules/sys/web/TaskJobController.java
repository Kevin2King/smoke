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

import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.framework.core.config.Global;
import com.funtl.framework.core.utils.SpringContextHolder;
import com.funtl.framework.core.utils.StringUtils;
import com.funtl.framework.core.web.BaseController;
import com.funtl.framework.smoke.core.modules.sys.entity.TaskJob;
import com.funtl.framework.smoke.core.modules.sys.service.TaskJobService;
import com.funtl.framework.smoke.core.modules.sys.utils.quartz.JobTaskService;
import com.funtl.framework.smoke.core.modules.sys.utils.quartz.TaskGlobal;
import com.google.common.collect.Lists;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.quartz.CronScheduleBuilder;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 采集管理Controller
 *
 * @author 李卫民
 * @version 2016-07-27
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/taskJob")
@SuppressWarnings("unchecked")
public class TaskJobController extends BaseController {

	@Autowired
	private TaskJobService taskJobService;
	@Autowired
	private JobTaskService jobTaskService;

	@ModelAttribute
	public TaskJob get(@RequestParam(required = false) String id) {
		TaskJob entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = taskJobService.get(id);
		}
		if (entity == null) {
			entity = new TaskJob();
		}
		return entity;
	}

	@RequiresPermissions("sys:taskJob:view")
	@RequestMapping(value = {"list", ""})
	public String list(TaskJob taskJob, HttpServletRequest request, HttpServletResponse response, Model model) throws SchedulerException {
		// 获取原始计划任务
		List<TaskJob> list = null;

		// 获取预备计划任务或执行中的计划
		if (taskJob.getTaskJobStatus() != null && (taskJob.getTaskJobStatus().equals("2") || taskJob.getTaskJobStatus().equals("3"))) {
			String taskJobStatus = new String(taskJob.getTaskJobStatus());
			taskJob.setTaskJobStatus("");
			list = taskJobService.findList(taskJob);


			List<TaskJob> pList = null;
			if (taskJobStatus.equals("2")) {
				pList = jobTaskService.getAllJob();
			} else if (taskJobStatus.equals("3")) {
				pList = jobTaskService.getRunningJob();
			}

			// 封装调度任务信息
			for (TaskJob job : pList) {
				for (TaskJob item : list) {
					if (job.getTaskJobName().equals(item.getTaskJobName())) {
						job.setId(item.getId());
						job.setTaskJobCode(item.getTaskJobCode());
						job.setTaskJobBean(item.getTaskJobBean());
						job.setTaskJobMethod(item.getTaskJobMethod());
						job.setTaskJobSpring(item.getTaskJobSpring());
						job.setTaskJobConcurrent(item.getTaskJobConcurrent());
						job.setTaskJobStatus(item.getTaskJobStatus());
						job.setTaskJobIp(item.getTaskJobIp());
						job.setUpdateDate(item.getUpdateDate());
					}
				}
			}

			taskJob.setTaskJobStatus(taskJobStatus);
			model.addAttribute("list", pList);
			return "modules/sys/taskJobList";
		} else {
			list = taskJobService.findList(taskJob);
		}

		model.addAttribute("list", list);
		return "modules/sys/taskJobList";
	}

	@RequiresPermissions("sys:taskJob:view")
	@RequestMapping(value = "form")
	public String form(TaskJob taskJob, Model model) {
		model.addAttribute("taskJob", taskJob);
		return "modules/sys/taskJobForm";
	}

	@RequiresPermissions("sys:taskJob:edit")
	@RequestMapping(value = "save")
	public String save(TaskJob taskJob, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, taskJob)) {
			return form(taskJob, model);
		}

		// 检查任务状态
		if (taskJob.getTaskJobStatus() == null || taskJob.getTaskJobStatus().trim().length() == 0) {
			taskJob.setTaskJobStatus("0");
		}

		// 检测表达式
		try {
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(taskJob.getTaskJobCron());
		} catch (Exception e) {
			addMessage(redirectAttributes, "保存计划任务失败，表达式有错误不能被解析");
			return "redirect:" + Global.getAdminPath() + "/sys/taskJob/?repage";
		}

		// 检测调度任务是否存在
		Object obj = null;
		try {
			if (StringUtils.isNoneBlank(taskJob.getTaskJobSpring())) {
				obj = SpringContextHolder.getBean(taskJob.getTaskJobSpring());
			} else {
				Class clazz = Class.forName(taskJob.getTaskJobBean());
				obj = clazz.newInstance();
			}
		} catch (Exception e) {
			// ......
		}
		if (obj == null) {
			addMessage(redirectAttributes, "保存计划任务失败，未找到目标类");
			return "redirect:" + Global.getAdminPath() + "/sys/taskJob/?repage";
		} else {
			Class clazz = obj.getClass();
			Method method = null;
			try {
				Class[] classes = new Class[0];
				method = clazz.getMethod(taskJob.getTaskJobMethod(), classes);
			} catch (NoSuchMethodException e) {
				// ......
			}
			if (method == null) {
				addMessage(redirectAttributes, "保存计划任务失败，未找到目标方法");
				return "redirect:" + Global.getAdminPath() + "/sys/taskJob/?repage";
			}
		}

		taskJobService.save(taskJob); // 调度名 和 调度组   两个名称不应该重复
		addMessage(redirectAttributes, "保存计划任务成功");
		return "redirect:" + Global.getAdminPath() + "/sys/taskJob/?repage";
	}

	@RequiresPermissions("sys:taskJob:edit")
	@RequestMapping(value = "delete")
	public String delete(TaskJob taskJob, RedirectAttributes redirectAttributes) {
		taskJobService.delete(taskJob);
		addMessage(redirectAttributes, "删除采集任务成功");
		return "redirect:" + Global.getAdminPath() + "/sys/taskJob/?repage";
	}

	@RequiresPermissions("sys:taskJob:edit")
	@RequestMapping(value = "changeJobStatus")
	public String changeJobStatus(String ip, String id, String cmd, RedirectAttributes redirectAttributes) {
		List<NameValuePair> params = Lists.newArrayList();
		params.add(new BasicNameValuePair("id", id));
		params.add(new BasicNameValuePair("cmd", cmd));
		try {
			String result = TaskGlobal.httpClientUtil.postData(String.format(Global.getConfig("quartz.url"), ip), params);
			addMessage(redirectAttributes, result);
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "请求失败或调度IP不存在，请重试");
		}
		return "redirect:" + Global.getAdminPath() + "/sys/taskJob/?repage";
	}

}