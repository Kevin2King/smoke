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

package com.funtl.framework.smoke.core.modules.act.service.creator;

import java.util.List;

import com.funtl.framework.smoke.core.modules.act.utils.ProcessDefUtils;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.impl.bpmn.behavior.MultiInstanceActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.ParallelMultiInstanceBehavior;
import org.activiti.engine.impl.bpmn.behavior.SequentialMultiInstanceBehavior;
import org.activiti.engine.impl.bpmn.behavior.TaskActivityBehavior;
import org.activiti.engine.impl.el.FixedValue;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;

public class MultiInstanceActivityCreator extends RuntimeActivityCreatorSupport implements RuntimeActivityCreator {

	public ActivityImpl[] createActivities(ProcessEngine processEngine, ProcessDefinitionEntity processDefinition, RuntimeActivityDefinitionEntity info) {
		info.setFactoryName(MultiInstanceActivityCreator.class.getName());
		RuntimeActivityDefinitionEntityIntepreter radei = new RuntimeActivityDefinitionEntityIntepreter(info);

		if (radei.getCloneActivityId() == null) {
			String cloneActivityId = createUniqueActivityId(info.getProcessInstanceId(), radei.getPrototypeActivityId());
			radei.setCloneActivityId(cloneActivityId);
		}

		return new ActivityImpl[]{createMultiInstanceActivity(processEngine, processDefinition, info.getProcessInstanceId(), radei.getPrototypeActivityId(), radei.getCloneActivityId(), radei.getSequential(), radei.getAssignees())};
	}

	private ActivityImpl createMultiInstanceActivity(ProcessEngine processEngine, ProcessDefinitionEntity processDefinition, String processInstanceId, String prototypeActivityId, String cloneActivityId, boolean isSequential, List<String> assignees) {
		ActivityImpl prototypeActivity = ProcessDefUtils.getActivity(processEngine, processDefinition.getId(), prototypeActivityId);

		//拷贝listener，executionListeners会激活历史记录的保存
		ActivityImpl clone = cloneActivity(processDefinition, prototypeActivity, cloneActivityId, "executionListeners", "properties");
		//拷贝所有后向链接
		for (PvmTransition trans : prototypeActivity.getOutgoingTransitions()) {
			clone.createOutgoingTransition(trans.getId()).setDestination((ActivityImpl) trans.getDestination());
		}

		MultiInstanceActivityBehavior multiInstanceBehavior = isSequential ? new SequentialMultiInstanceBehavior(clone, (TaskActivityBehavior) prototypeActivity.getActivityBehavior()) : new ParallelMultiInstanceBehavior(clone, (TaskActivityBehavior) prototypeActivity.getActivityBehavior());

		clone.setActivityBehavior(multiInstanceBehavior);

		clone.setScope(true);
		clone.setProperty("multiInstance", isSequential ? "sequential" : "parallel");

		//设置多实例节点属性
		multiInstanceBehavior.setLoopCardinalityExpression(new FixedValue(assignees.size()));
		multiInstanceBehavior.setCollectionExpression(new FixedValue(assignees));
		return clone;
	}
}
