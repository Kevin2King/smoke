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

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;

import com.funtl.framework.smoke.core.commons.service.CrudService;
import com.funtl.framework.smoke.core.modules.sys.dao.TaskJobDao;
import com.funtl.framework.smoke.core.modules.sys.entity.TaskJob;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 李卫民
 * @Description: 计划任务管理
 */
@Service
@Transactional(readOnly = true)
@SuppressWarnings("unchecked")
public class JobTaskService extends CrudService<TaskJobDao, TaskJob> {
	private static final Logger logger = LoggerFactory.getLogger(JobTaskService.class);

	@Autowired
	private SchedulerFactoryBean schedulerFactoryBean;

	/**
	 * 从数据库中查询job
	 */
	public TaskJob getTaskById(String jobId) {
		return super.get(jobId);
	}

	/**
	 * 更改任务状态
	 *
	 * @throws SchedulerException
	 */
	@Transactional(readOnly = false)
	public void changeStatus(String jobId, String cmd) throws SchedulerException {
		TaskJob job = getTaskById(jobId);
		if (job == null) {
			return;
		}
		if ("stop".equals(cmd)) {
			deleteJob(job);
			job.setTaskJobStatus(TaskJob.STATUS_NOT_RUNNING);
		} else if ("start".equals(cmd)) {
			job.setTaskJobStatus(TaskJob.STATUS_RUNNING);
			addJob(job);
		}
		super.save(job);
	}

	/**
	 * 更改任务 cron表达式
	 *
	 * @throws SchedulerException
	 */
	@Transactional(readOnly = false)
	public void updateCron(String jobId, String cron) throws SchedulerException {
		TaskJob job = getTaskById(jobId);
		if (job == null) {
			return;
		}
		job.setTaskJobCron(cron);
		if (TaskJob.STATUS_RUNNING.equals(job.getTaskJobStatus())) {
			updateJobCron(job);
		}
		super.save(job);
	}

	/**
	 * 添加任务
	 *
	 * @param job
	 * @throws SchedulerException
	 */
	public void addJob(TaskJob job) throws SchedulerException {
		if (job == null || !TaskJob.STATUS_RUNNING.equals(job.getTaskJobStatus())) {
			return;
		}

		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		logger.debug(scheduler + ".......................................................................................add");
		TriggerKey triggerKey = TriggerKey.triggerKey(job.getTaskJobName(), job.getTaskJobGroup());

		CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);

		// 不存在，创建一个
		if (null == trigger) {
			Class clazz = TaskJob.CONCURRENT_IS.equals(job.getTaskJobConcurrent()) ? QuartzJobFactory.class : QuartzJobFactoryDisallowConcurrentExecution.class;

			JobDetail jobDetail = JobBuilder.newJob(clazz).withIdentity(job.getTaskJobName(), job.getTaskJobGroup()).build();

			jobDetail.getJobDataMap().put("taskJob", job);

			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getTaskJobCron());

			trigger = TriggerBuilder.newTrigger().withIdentity(job.getTaskJobName(), job.getTaskJobGroup()).withSchedule(scheduleBuilder).build();

			scheduler.scheduleJob(jobDetail, trigger);
		} else {
			// Trigger已存在，那么更新相应的定时设置
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getTaskJobCron());

			// 按新的cronExpression表达式重新构建trigger
			trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();

			// 按新的trigger重新设置job执行
			scheduler.rescheduleJob(triggerKey, trigger);
		}
	}

	/**
	 * 获取所有计划中的任务列表
	 *
	 * @return
	 * @throws SchedulerException
	 */
	public List<TaskJob> getAllJob() throws SchedulerException {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		GroupMatcher<JobKey> matcher = GroupMatcher.anyJobGroup();
		Set<JobKey> jobKeys = scheduler.getJobKeys(matcher);
		List<TaskJob> jobList = new ArrayList<TaskJob>();
		for (JobKey jobKey : jobKeys) {
			List<? extends Trigger> triggers = scheduler.getTriggersOfJob(jobKey);
			for (Trigger trigger : triggers) {
				TaskJob job = new TaskJob();
				job.setTaskJobName(jobKey.getName());
				job.setTaskJobGroup(jobKey.getGroup());
				job.setRemarks("触发器:" + trigger.getKey());
				Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());
				job.setTaskJobStatus(triggerState.name());
				if (trigger instanceof CronTrigger) {
					CronTrigger cronTrigger = (CronTrigger) trigger;
					String cronExpression = cronTrigger.getCronExpression();
					job.setTaskJobCron(cronExpression);
				}
				jobList.add(job);
			}
		}
		return jobList;
	}

	/**
	 * 所有正在运行的job
	 *
	 * @return
	 * @throws SchedulerException
	 */
	public List<TaskJob> getRunningJob() throws SchedulerException {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		List<JobExecutionContext> executingJobs = scheduler.getCurrentlyExecutingJobs();
		List<TaskJob> jobList = new ArrayList<TaskJob>(executingJobs.size());
		for (JobExecutionContext executingJob : executingJobs) {
			TaskJob job = new TaskJob();
			JobDetail jobDetail = executingJob.getJobDetail();
			JobKey jobKey = jobDetail.getKey();
			Trigger trigger = executingJob.getTrigger();
			job.setTaskJobName(jobKey.getName());
			job.setTaskJobGroup(jobKey.getGroup());
			job.setRemarks("触发器:" + trigger.getKey());
			Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());
			job.setTaskJobStatus(triggerState.name());
			if (trigger instanceof CronTrigger) {
				CronTrigger cronTrigger = (CronTrigger) trigger;
				String cronExpression = cronTrigger.getCronExpression();
				job.setTaskJobCron(cronExpression);
			}
			jobList.add(job);
		}
		return jobList;
	}

	/**
	 * 暂停一个job
	 *
	 * @param taskJob
	 * @throws SchedulerException
	 */
	public void pauseJob(TaskJob taskJob) throws SchedulerException {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		JobKey jobKey = JobKey.jobKey(taskJob.getTaskJobName(), taskJob.getTaskJobGroup());
		scheduler.pauseJob(jobKey);
	}

	/**
	 * 恢复一个job
	 *
	 * @param taskJob
	 * @throws SchedulerException
	 */
	public void resumeJob(TaskJob taskJob) throws SchedulerException {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		JobKey jobKey = JobKey.jobKey(taskJob.getTaskJobName(), taskJob.getTaskJobGroup());
		scheduler.resumeJob(jobKey);
	}

	/**
	 * 删除一个job
	 *
	 * @param taskJob
	 * @throws SchedulerException
	 */
	public void deleteJob(TaskJob taskJob) throws SchedulerException {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		JobKey jobKey = JobKey.jobKey(taskJob.getTaskJobName(), taskJob.getTaskJobGroup());
		scheduler.deleteJob(jobKey);
	}

	/**
	 * 立即执行job
	 *
	 * @param taskJob
	 * @throws SchedulerException
	 */
	public void runAJobNow(TaskJob taskJob) throws SchedulerException {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		JobKey jobKey = JobKey.jobKey(taskJob.getTaskJobName(), taskJob.getTaskJobGroup());
		scheduler.triggerJob(jobKey);
	}

	/**
	 * 更新job时间表达式
	 *
	 * @param taskJob
	 * @throws SchedulerException
	 */
	public void updateJobCron(TaskJob taskJob) throws SchedulerException {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();

		TriggerKey triggerKey = TriggerKey.triggerKey(taskJob.getTaskJobName(), taskJob.getTaskJobGroup());

		CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);

		CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(taskJob.getTaskJobCron());

		trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();

		scheduler.rescheduleJob(triggerKey, trigger);
	}

	@PostConstruct
	public void init() throws Exception {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();

		// 这里获取任务信息数据
		TaskJob taskJob = new TaskJob();
		// 通过获取本机IP的方式来查询本机的任务状态，在系统初始化时可以按原状态启动
		taskJob.setTaskJobIp(InetAddress.getLocalHost().getHostAddress().toString());
		List<TaskJob> jobList = super.findList(taskJob);
		for (TaskJob job : jobList) {
			addJob(job);
		}
	}
}
