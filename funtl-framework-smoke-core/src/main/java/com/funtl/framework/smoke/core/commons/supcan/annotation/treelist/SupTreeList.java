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

package com.funtl.framework.smoke.core.commons.supcan.annotation.treelist;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.funtl.framework.smoke.core.commons.supcan.annotation.treelist.cols.SupGroup;
import com.funtl.framework.smoke.core.commons.supcan.annotation.common.fonts.SupFont;
import com.funtl.framework.smoke.core.commons.supcan.annotation.common.properties.SupProperties;

/**
 * 硕正TreeList注解
 *
 * @author WangZhen
 * @version 2013-11-12
 * @SupTreeList( properties=@SupProperties(headerFontIndex="2", curSelBgColor="#ccddcc",
 * displayMask="backColor=if(name='管理员', '#ff0000', transparent)",
 * expresses={
 * @SupExpress(text="total=round(price*num, 2)"),
 * @SupExpress(text="price=round(total/num, 4)")
 * }),
 * fonts={
 * @SupFont(faceName="宋体", weight="400"),
 * @SupFont(faceName="楷体", weight="700", height="-12"),
 * @SupFont(faceName="楷体", weight="400", height="-12")},
 * groups={
 * @SupGroup(id="date", name="日期", headerFontIndex="1", sort=50),
 * @SupGroup(id="date2", name="日期2", headerFontIndex="2", sort=60, parentId="date"),
 * @SupGroup(id="date3", name="日期3", headerFontIndex="2", sort=70, parentId="date")
 * })
 * @see 在类上添加注解，应用实例：
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface SupTreeList {

	/**
	 * 属性对象
	 */
	SupProperties properties() default @SupProperties;

	/**
	 * 字体对象
	 */
	SupFont[] fonts() default {};

	/**
	 * 列表头组
	 */
	SupGroup[] groups() default {};

}
