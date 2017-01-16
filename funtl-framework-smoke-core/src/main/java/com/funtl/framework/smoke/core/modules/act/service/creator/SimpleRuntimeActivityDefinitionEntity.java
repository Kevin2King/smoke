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
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@SuppressWarnings("unchecked")
public class SimpleRuntimeActivityDefinitionEntity implements RuntimeActivityDefinitionEntity {
	String _factoryName;

	String _processDefinitionId;

	public Map<String, Object> getProperties() {
		return _properties;
	}

	public void setProperties(Map<String, Object> properties) {
		_properties = properties;
	}

	public void setFactoryName(String factoryName) {
		_factoryName = factoryName;
	}

	public void setProcessDefinitionId(String processDefinitionId) {
		_processDefinitionId = processDefinitionId;
	}

	public void setProcessInstanceId(String processInstanceId) {
		_processInstanceId = processInstanceId;
	}

	public void setPropertiesText(String propertiesText) {
		_propertiesText = propertiesText;
	}

	String _processInstanceId;

	Map<String, Object> _properties = new HashMap<String, Object>();

	String _propertiesText;

	@Override
	public void deserializeProperties() throws IOException {
		ObjectMapper objectMapper = new ObjectMapper();
		_properties = objectMapper.readValue(_propertiesText, Map.class);
	}

	@Override
	public String getFactoryName() {
		return _factoryName;
	}

	@Override
	public String getProcessDefinitionId() {
		return _processDefinitionId;
	}

	@Override
	public String getProcessInstanceId() {
		return _processInstanceId;
	}

	@Override
	public String getPropertiesText() {
		return _propertiesText;
	}

	@Override
	public <T> T getProperty(String name) {
		return (T) _properties.get(name);
	}

	@Override
	public void serializeProperties() throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		_propertiesText = objectMapper.writeValueAsString(_properties);
	}

	@Override
	public <T> void setProperty(String name, T value) {
		_properties.put(name, value);
	}
}
