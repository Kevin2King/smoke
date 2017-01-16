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

package com.funtl.framework.smoke.core.commons.supcan.common.properties;

import com.funtl.framework.core.utils.ObjectUtils;
import com.funtl.framework.smoke.core.commons.supcan.annotation.common.properties.SupExpress;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamAsAttribute;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.converters.extended.ToAttributedValueConverter;

/**
 * 硕正TreeList Properties Express
 *
 * @author WangZhen
 * @version 2013-11-04
 */
@XStreamAlias("Express")
@XStreamConverter(value = ToAttributedValueConverter.class, strings = {"text"})
public class Express {

	/**
	 * 是否自动按列的引用关系优化计算顺序  默认值true
	 */
	@XStreamAsAttribute
	private String isOpt;

	/**
	 * 文本
	 */
	private String text;

	public Express() {

	}

	public Express(SupExpress supExpress) {
		this();
		ObjectUtils.annotationToObject(supExpress, this);
	}

	public Express(String text) {
		this.text = text;
	}

	public Express(String name, String text) {
		this(name);
		this.text = text;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getIsOpt() {
		return isOpt;
	}

	public void setIsOpt(String isOpt) {
		this.isOpt = isOpt;
	}

}
