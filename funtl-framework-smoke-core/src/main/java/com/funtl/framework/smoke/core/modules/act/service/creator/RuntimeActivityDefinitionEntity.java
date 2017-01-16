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

import java.io.IOException;

import com.fasterxml.jackson.core.JsonProcessingException;

public interface RuntimeActivityDefinitionEntity {
	/**
	 * 反序列化PropertiesText到Map
	 */
	void deserializeProperties() throws IOException;

	/**
	 * 获取工厂名
	 */
	String getFactoryName();

	/**
	 * 获取流程定义的ID
	 */
	String getProcessDefinitionId();

	/**
	 * 获取流程实例的ID
	 */
	String getProcessInstanceId();

	/**
	 * 获取PropertiesText，它是一个JSON字符串
	 */
	String getPropertiesText();

	/**
	 * 获取指定的属性值
	 */
	<T> T getProperty(String name);

	/**
	 * 序列化Map至PropertiesText
	 */
	void serializeProperties() throws JsonProcessingException;

	/**
	 * 设置工厂名
	 */
	void setFactoryName(String factoryName);

	/**
	 * 设置流程定义ID
	 */
	void setProcessDefinitionId(String processDefinitionId);

	/**
	 * 设置流程实例ID
	 */
	void setProcessInstanceId(String processInstanceId);

	/**
	 * 设置PropertiesText
	 */
	void setPropertiesText(String propertiesText);

	<T> void setProperty(String name, T value);
}