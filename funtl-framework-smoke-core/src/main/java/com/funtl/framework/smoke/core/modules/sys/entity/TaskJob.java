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

package com.funtl.framework.smoke.core.modules.sys.entity;

import com.funtl.framework.smoke.core.commons.persistence.DataEntity;

import org.hibernate.validator.constraints.Length;

/**
 * 系统设置Entity
 *
 * @author 李卫民
 * @version 2016-07-28
 */
public class TaskJob extends DataEntity<TaskJob> {
	public static final String STATUS_RUNNING = "1";
	public static final String STATUS_NOT_RUNNING = "0";
	public static final String CONCURRENT_IS = "1";
	public static final String CONCURRENT_NOT = "0";

	private String taskJobCode;        // 任务编码
	private String taskJobName;        // 任务名称
	private String taskJobGroup;        // 任务分组
	private String taskJobCron;        // 任务表达式
	private String taskJobStatus;        // 任务状态
	private String taskJobBean;        // 任务调用类
	private String taskJobConcurrent;        // 是否有状态
	private String taskJobSpring;        // SPRING
	private String taskJobMethod;        // 任务调用方法
	private String taskJobIp;        // 执行服务器IP
	private Integer sort;        // 排序

	public TaskJob() {
		super();
	}

	public TaskJob(String id) {
		super(id);
	}

	@Length(min = 1, max = 50, message = "任务编码长度必须介于 1 和 50 之间")
	public String getTaskJobCode() {
		return taskJobCode;
	}

	public void setTaskJobCode(String taskJobCode) {
		this.taskJobCode = taskJobCode;
	}

	@Length(min = 1, max = 100, message = "任务名称长度必须介于 1 和 100 之间")
	public String getTaskJobName() {
		return taskJobName;
	}

	public void setTaskJobName(String taskJobName) {
		this.taskJobName = taskJobName;
	}

	@Length(min = 0, max = 100, message = "任务分组长度必须介于 0 和 100 之间")
	public String getTaskJobGroup() {
		return taskJobGroup;
	}

	public void setTaskJobGroup(String taskJobGroup) {
		this.taskJobGroup = taskJobGroup;
	}

	@Length(min = 0, max = 50, message = "任务表达式长度必须介于 0 和 50 之间")
	public String getTaskJobCron() {
		return taskJobCron;
	}

	public void setTaskJobCron(String taskJobCron) {
		this.taskJobCron = taskJobCron;
	}

	@Length(min = 0, max = 2, message = "任务状态长度必须介于 0 和 2 之间")
	public String getTaskJobStatus() {
		return taskJobStatus;
	}

	public void setTaskJobStatus(String taskJobStatus) {
		this.taskJobStatus = taskJobStatus;
	}

	@Length(min = 0, max = 100, message = "任务调用类长度必须介于 0 和 100 之间")
	public String getTaskJobBean() {
		return taskJobBean;
	}

	public void setTaskJobBean(String taskJobBean) {
		this.taskJobBean = taskJobBean;
	}

	@Length(min = 0, max = 2, message = "是否有状态长度必须介于 0 和 2 之间")
	public String getTaskJobConcurrent() {
		return taskJobConcurrent;
	}

	public void setTaskJobConcurrent(String taskJobConcurrent) {
		this.taskJobConcurrent = taskJobConcurrent;
	}

	@Length(min = 0, max = 100, message = "SPRING长度必须介于 0 和 100 之间")
	public String getTaskJobSpring() {
		return taskJobSpring;
	}

	public void setTaskJobSpring(String taskJobSpring) {
		this.taskJobSpring = taskJobSpring;
	}

	@Length(min = 0, max = 100, message = "任务调用方法长度必须介于 0 和 100 之间")
	public String getTaskJobMethod() {
		return taskJobMethod;
	}

	public void setTaskJobMethod(String taskJobMethod) {
		this.taskJobMethod = taskJobMethod;
	}

	@Length(min = 0, max = 60, message = "执行服务器IP长度必须介于 0 和 60 之间")
	public String getTaskJobIp() {
		return taskJobIp;
	}

	public void setTaskJobIp(String taskJobIp) {
		this.taskJobIp = taskJobIp;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

}