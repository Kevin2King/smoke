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

import org.quartz.Job;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerKey;
import org.quartz.impl.StdSchedulerFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.quartz.CronScheduleBuilder.cronSchedule;
import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;

/**
 * 任务调度工具类
 * Created by liweimin on 2015/11/12.
 */
public class QuartzUtils {
	private static Logger logger = LoggerFactory.getLogger(QuartzUtils.class);

	private Scheduler scheduler;

	public QuartzUtils() {
		try {
			scheduler = new StdSchedulerFactory().getScheduler();
			logger.info("初始化调度器");
		} catch (SchedulerException e) {
			logger.info("初始化调度器失败=> [失败]：" + e.getLocalizedMessage());
		}
	}

	/**
	 * 增加调度任务
	 *
	 * @param name           作业名称
	 * @param group          作业组
	 * @param clazz          作业
	 * @param cronExpression
	 */
	public void addJob(String name, String group, Class<? extends Job> clazz, String cronExpression) {
		try {
			// 构造任务
			JobDetail job = newJob(clazz).withIdentity(name, group).build();

			// 构造任务触发器
			Trigger trg = newTrigger().withIdentity(name, group).withSchedule(cronSchedule(cronExpression)).build();

			// 将作业添加到调度器
			scheduler.scheduleJob(job, trg);

			logger.info("创建作业=> [作业名称：" + name + " 作业组：" + group + "]");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("创建作业=> [作业名称：" + name + " 作业组：" + group + "]=> [失败]");
		}
	}

	/**
	 * 删除调度任务
	 *
	 * @param name
	 * @param group
	 */
	public void removeJob(String name, String group) {
		try {
			TriggerKey tk = TriggerKey.triggerKey(name, group);
			scheduler.pauseTrigger(tk); // 停止触发器
			scheduler.unscheduleJob(tk); // 移除触发器
			JobKey jobKey = JobKey.jobKey(name, group);
			scheduler.deleteJob(jobKey); // 删除调度任务
			logger.info("删除作业=> [作业名称：" + name + " 作业组：" + group + "]");
		} catch (SchedulerException e) {
			e.printStackTrace();
			logger.info("删除作业=> [作业名称：" + name + " 作业组：" + group + "]=> [失败]");
		}
	}

	/**
	 * 暂停调度任务
	 *
	 * @param name
	 * @param group
	 */
	public void pauseJob(String name, String group) {
		try {
			JobKey jobKey = JobKey.jobKey(name, group);
			scheduler.pauseJob(jobKey);
			logger.info("暂停作业=> [作业名称：" + name + " 作业组：" + group + "]");
		} catch (SchedulerException e) {
			e.printStackTrace();
			logger.info("暂停作业=> [作业名称：" + name + " 作业组：" + group + "]=> [失败]");
		}
	}

	/**
	 * 恢复调度任务
	 *
	 * @param name
	 * @param group
	 */
	public void resumeJob(String name, String group) {
		try {
			JobKey jobKey = JobKey.jobKey(name, group);
			scheduler.resumeJob(jobKey);
			logger.info("恢复作业=> [作业名称：" + name + " 作业组：" + group + "]");
		} catch (SchedulerException e) {
			e.printStackTrace();
			logger.info("恢复作业=> [作业名称：" + name + " 作业组：" + group + "]=> [失败]");
		}
	}

	/**
	 * 修改触发时间
	 *
	 * @param name
	 * @param group
	 * @param cronExpression
	 */
	public void modifyTime(String name, String group, String cronExpression) {
		try {
			TriggerKey tk = TriggerKey.triggerKey(name, group);
			// 构造调度任务触发器
			Trigger trg = newTrigger().withIdentity(name, group).withSchedule(cronSchedule(cronExpression)).build();
			scheduler.rescheduleJob(tk, trg);
			logger.info("修改作业触发时间=> [作业名称：" + name + " 作业组：" + group + "]");
		} catch (SchedulerException e) {
			e.printStackTrace();
			logger.info("修改作业触发时间=> [作业名称：" + name + " 作业组：" + group + "]=> [失败]");
		}
	}

	/**
	 * 启动任务调度
	 */
	public void start() {
		try {
			scheduler.start();
			logger.info("启动任务调度");
		} catch (SchedulerException e) {
			e.printStackTrace();
			logger.error("启动任务调度失败=> [失败]");
		}
	}

	/**
	 * 停止任务调度
	 */
	public void shutdown() {
		try {
			scheduler.shutdown();
			logger.info("停止任务调度");
		} catch (SchedulerException e) {
			e.printStackTrace();
			logger.error("停止任务调度失败=> [失败]");
		}
	}
}
