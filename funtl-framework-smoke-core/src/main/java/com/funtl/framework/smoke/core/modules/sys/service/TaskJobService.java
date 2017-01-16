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

package com.funtl.framework.smoke.core.modules.sys.service;

import java.util.List;

import com.funtl.framework.smoke.core.commons.persistence.Page;
import com.funtl.framework.smoke.core.commons.service.CrudService;
import com.funtl.framework.smoke.core.modules.sys.entity.TaskJob;
import com.funtl.framework.smoke.core.modules.sys.dao.TaskJobDao;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 系统设置Service
 *
 * @author 李卫民
 * @version 2016-07-28
 */
@Service
@Transactional(readOnly = true)
public class TaskJobService extends CrudService<TaskJobDao, TaskJob> {

	public TaskJob get(String id) {
		return super.get(id);
	}

	public List<TaskJob> findList(TaskJob taskJob) {
		return super.findList(taskJob);
	}

	public Page<TaskJob> findPage(Page<TaskJob> page, TaskJob taskJob) {
		return super.findPage(page, taskJob);
	}

	@Transactional(readOnly = false)
	public void save(TaskJob taskJob) {
		super.save(taskJob);
	}

	@Transactional(readOnly = false)
	public void delete(TaskJob taskJob) {
		super.delete(taskJob);
	}

}