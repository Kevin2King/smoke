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

package com.funtl.framework.smoke.core.commons.supcan.annotation.common.fonts;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 硕正Font注解
 *
 * @author WangZhen
 * @version 2013-11-12
 */
@Target({ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface SupFont {

	/**
	 * 字体名称   微软雅黑  宋体
	 */
	String faceName() default "";

	/**
	 * 字符集 134
	 */
	String charSet() default "";

	/**
	 * Height(或size)是字体的尺寸，单位是字体的逻辑单位，通常采用小于0的数字，
	 * 如果大于0，则高度不包含文字的内部行距(internal-leading)。
	 * 常用的尺寸是-8, -9, -10, -11, -12, -14, -16, -18, -20, -22, -24, -26, -28, -36, -48, -72() ;
	 */
	String height() default "";

	/**
	 * 字体加粗 weight=400/700 对应 非粗体/粗体；
	 */
	String weight() default "";

	/**
	 * 字体宽度
	 */
	String width() default "";

	/**
	 * 字体斜体
	 */
	String italic() default "";

	/**
	 * 字体下划线
	 */
	String underline() default "";

}
