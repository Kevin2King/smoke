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

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import com.funtl.framework.core.utils.SpringContextHolder;
import com.funtl.framework.smoke.core.modules.sys.entity.TaskJob;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@SuppressWarnings("unchecked")
public class TaskUtils {
	private static final Logger logger = LoggerFactory.getLogger(TaskUtils.class);

	/**
	 * 通过反射调用scheduleJob中定义的方法
	 *
	 * @param taskJob
	 */
	public static void invokMethod(TaskJob taskJob) {
		Object object = null;
		Class clazz = null;
		if (StringUtils.isNotBlank(taskJob.getTaskJobSpring())) {
			object = SpringContextHolder.getBean(taskJob.getTaskJobSpring());
		} else if (StringUtils.isNotBlank(taskJob.getTaskJobBean())) {
			try {
				clazz = Class.forName(taskJob.getTaskJobBean());
				object = clazz.newInstance();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		if (object == null) {
			logger.error("任务名称 = [" + taskJob.getTaskJobName() + "]---------------未启动成功，请检查是否配置正确！！！");
			return;
		}
		clazz = object.getClass();
		Method method = null;
		try {
			method = clazz.getDeclaredMethod(taskJob.getTaskJobMethod());
		} catch (NoSuchMethodException e) {
			logger.error("任务名称 = [" + taskJob.getTaskJobName() + "]---------------未启动成功，方法名设置错误！！！");
		} catch (SecurityException e) {
			e.printStackTrace();
		}
		if (method != null) {
			try {
				method.invoke(object);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		logger.debug("任务名称 = [" + taskJob.getTaskJobName() + "]----------启动成功");
	}
}
