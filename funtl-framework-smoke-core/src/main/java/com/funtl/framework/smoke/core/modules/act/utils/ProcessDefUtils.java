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

package com.funtl.framework.smoke.core.modules.act.utils;

import java.util.LinkedHashSet;
import java.util.Set;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.delegate.Expression;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.bpmn.behavior.UserTaskActivityBehavior;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.impl.el.FixedValue;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.task.TaskDefinition;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.log4j.Logger;

/**
 * 流程定义相关操作的封装
 *
 * @author bluejoe2008@gmail.com
 */
public abstract class ProcessDefUtils {

	public static ActivityImpl getActivity(ProcessEngine processEngine, String processDefId, String activityId) {
		ProcessDefinitionEntity pde = getProcessDefinition(processEngine, processDefId);
		return (ActivityImpl) pde.findActivity(activityId);
	}

	public static ProcessDefinitionEntity getProcessDefinition(ProcessEngine processEngine, String processDefId) {
		return (ProcessDefinitionEntity) ((RepositoryServiceImpl) processEngine.getRepositoryService()).getDeployedProcessDefinition(processDefId);
	}

	public static void grantPermission(ActivityImpl activity, String assigneeExpression, String candidateGroupIdExpressions, String candidateUserIdExpressions) throws Exception {
		TaskDefinition taskDefinition = ((UserTaskActivityBehavior) activity.getActivityBehavior()).getTaskDefinition();
		taskDefinition.setAssigneeExpression(assigneeExpression == null ? null : new FixedValue(assigneeExpression));
		FieldUtils.writeField(taskDefinition, "candidateUserIdExpressions", ExpressionUtils.stringToExpressionSet(candidateUserIdExpressions), true);
		FieldUtils.writeField(taskDefinition, "candidateGroupIdExpressions", ExpressionUtils.stringToExpressionSet(candidateGroupIdExpressions), true);

		Logger.getLogger(ProcessDefUtils.class).info(String.format("granting previledges for [%s, %s, %s] on [%s, %s]", assigneeExpression, candidateGroupIdExpressions, candidateUserIdExpressions, activity.getProcessDefinition().getKey(), activity.getProperty("name")));
	}

	/**
	 * 实现常见类型的expression的包装和转换
	 *
	 * @author bluejoe2008@gmail.com
	 */
	public static class ExpressionUtils {
		public static Expression stringToExpression(ProcessEngineConfigurationImpl conf, String expr) {
			return conf.getExpressionManager().createExpression(expr);
		}

		public static Expression stringToExpression(String expr) {
			return new FixedValue(expr);
		}

		public static Set<Expression> stringToExpressionSet(String exprs) {
			Set<Expression> set = new LinkedHashSet<Expression>();
			for (String expr : exprs.split(";")) {
				set.add(stringToExpression(expr));
			}

			return set;
		}
	}
}