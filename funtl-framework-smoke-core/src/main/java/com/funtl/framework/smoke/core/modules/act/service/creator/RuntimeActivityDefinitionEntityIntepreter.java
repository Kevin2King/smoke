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

/**
 * RuntimeActivityDefinitionEntity的解释类（代理类）
 * 主要用以解释properties字段的值，如为get("name")提供getName()方法
 *
 * @author bluejoe2008@gmail.com
 */
public class RuntimeActivityDefinitionEntityIntepreter {
	RuntimeActivityDefinitionEntity _entity;

	public RuntimeActivityDefinitionEntityIntepreter(RuntimeActivityDefinitionEntity entity) {
		super();
		_entity = entity;
	}

	public List<String> getAssignees() {
		return _entity.getProperty("assignees");
	}

	public String getCloneActivityId() {
		return _entity.getProperty("cloneActivityId");
	}

	public List<String> getCloneActivityIds() {
		return _entity.getProperty("cloneActivityIds");
	}

	public String getNextActivityId() {
		return _entity.getProperty("nextActivityId");
	}

	public String getPrototypeActivityId() {
		return _entity.getProperty("prototypeActivityId");
	}

	public boolean getSequential() {
		return (Boolean) _entity.getProperty("sequential");
	}

	public void setAssignees(List<String> assignees) {
		_entity.setProperty("assignees", assignees);
	}

	public void setCloneActivityId(String cloneActivityId) {
		_entity.setProperty("cloneActivityId", cloneActivityId);
	}

	public void setCloneActivityIds(List<String> cloneActivityIds) {
		_entity.setProperty("cloneActivityIds", cloneActivityIds);
	}

	public void setNextActivityId(String nextActivityId) {
		_entity.setProperty("nextActivityId", nextActivityId);
	}

	public void setPrototypeActivityId(String prototypeActivityId) {
		_entity.setProperty("prototypeActivityId", prototypeActivityId);
	}

	public void setSequential(boolean sequential) {
		_entity.setProperty("sequential", sequential);
	}
}
