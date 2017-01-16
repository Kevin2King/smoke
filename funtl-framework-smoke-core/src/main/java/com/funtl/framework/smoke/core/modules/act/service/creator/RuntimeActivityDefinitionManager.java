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

public interface RuntimeActivityDefinitionManager {
	/**
	 * 获取所有的活动定义信息，引擎会在启动的时候加载这些活动定义并进行注册
	 */
	List<RuntimeActivityDefinitionEntity> list() throws Exception;

	/**
	 * 删除所有活动定义
	 */
	void removeAll() throws Exception;

	/**
	 * 新增一条活动定义的信息
	 */
	void save(RuntimeActivityDefinitionEntity entity) throws Exception;

}