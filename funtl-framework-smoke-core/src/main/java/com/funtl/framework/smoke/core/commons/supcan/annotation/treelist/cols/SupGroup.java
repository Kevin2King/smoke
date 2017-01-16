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

package com.funtl.framework.smoke.core.commons.supcan.annotation.treelist.cols;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 硕正Group注解
 *
 * @author WangZhen
 * @version 2013-11-12
 */
@Target({ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface SupGroup {

	/**
	 * 分组的id，仅用于加载采用该id代替列名的XML/JSON数据
	 */
	String id();

	/**
	 * 显示的文字 串
	 */
	String name() default "";

	/**
	 * 采用的字体, 前面定义的<Font>的序号 数字 指向在<Fonts>中定义的字体的顺序号, 从0开始计数, 等级高于<Properties>中的同名属性
	 */
	String headerFontIndex() default "";

	/**
	 * 文字颜色 颜色串 #000000
	 */
	String textColor() default "";

	/**
	 * 文字对齐 left/center/right center
	 */
	String align() default "";

	/**
	 * 父级组ID
	 */
	String parentId() default "";

	/**
	 * 排序（升序）
	 */
	int sort() default 0;
}
