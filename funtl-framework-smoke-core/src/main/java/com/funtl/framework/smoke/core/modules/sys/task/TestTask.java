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

package com.funtl.framework.smoke.core.modules.sys.task;

import java.net.InetAddress;
import java.net.UnknownHostException;

import com.funtl.framework.core.utils.DateUtils;

/**
 * 测试调度任务
 * Created by 李卫民 on 2016/7/27.
 */
public class TestTask {
	public void run() {
		try {
			String currentDate = DateUtils.getDate("yyyy-MM-dd HH:mm:ss");
			System.out.println(currentDate + " " + InetAddress.getLocalHost().getHostAddress().toString() + " TestTask");
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
}
