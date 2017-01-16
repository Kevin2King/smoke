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

package com.funtl.framework.smoke.core.modules.act.service.cmd;

import java.util.Map;

import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.runtime.AtomicOperation;

public class JumpTaskCmd implements Command<Void> {

	private TaskEntity taskEntity;
	private ActivityImpl targetActivity;
	protected Map<String, Object> variables;

	public JumpTaskCmd(TaskEntity taskEntity, ActivityImpl targetActivity, Map<String, Object> variables) {
		this.taskEntity = taskEntity;
		this.targetActivity = targetActivity;
		this.variables = variables;
	}

	@Override
	public Void execute(CommandContext commandContext) {

		if (taskEntity != null) {

			//删除当前的任务，不能删除当前正在执行的任务，所以要先清除掉关联
			if (variables != null) {
				if (taskEntity.getExecutionId() != null) {
					taskEntity.setExecutionVariables(variables);
				} else {
					taskEntity.setVariables(variables);
				}
			}

			//			// 完成活动历史
			//			Context.getCommandContext().getHistoryManager()
			//				.recordActivityEnd((ExecutionEntity) taskEntity.getExecution());

			// 完成待办任务
			Context.getCommandContext().getTaskEntityManager().deleteTask(taskEntity, TaskEntity.DELETE_REASON_COMPLETED, false);    // DELETE_REASON_DELETED  DELETE_REASON_COMPLETED

			// 跳转任务
			ExecutionEntity execution = taskEntity.getExecution();
			execution.setActivity(targetActivity);
			execution.performOperation(AtomicOperation.ACTIVITY_START);

		}

		return null;
	}
}