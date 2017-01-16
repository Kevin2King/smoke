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

package com.funtl.framework.smoke.core.modules.sys.utils.quartz;

import com.funtl.framework.smoke.core.modules.sys.entity.TaskJob;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author chenjianlin
 * @Description: 计划任务执行处 无状态
 * @date 2014年4月24日 下午5:05:47
 */
public class QuartzJobFactory implements Job {
	private static final Logger logger = LoggerFactory.getLogger(QuartzJobFactory.class);

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		TaskJob taskJob = (TaskJob) context.getMergedJobDataMap().get("taskJob");
		TaskUtils.invokMethod(taskJob);
	}
}