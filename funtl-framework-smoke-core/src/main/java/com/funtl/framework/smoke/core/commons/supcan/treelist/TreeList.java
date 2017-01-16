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

package com.funtl.framework.smoke.core.commons.supcan.treelist;

import java.util.List;

import com.funtl.framework.smoke.core.commons.supcan.annotation.treelist.SupTreeList;
import com.funtl.framework.smoke.core.commons.supcan.common.Common;
import com.funtl.framework.smoke.core.commons.supcan.common.fonts.Font;
import com.funtl.framework.smoke.core.commons.supcan.annotation.common.fonts.SupFont;
import com.funtl.framework.smoke.core.commons.supcan.common.properties.Properties;
import com.google.common.collect.Lists;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * 硕正TreeList
 *
 * @author WangZhen
 * @version 2013-11-04
 */
@XStreamAlias("TreeList")
public class TreeList extends Common {

	/**
	 * 列集合
	 */
	@XStreamAlias("Cols")
	private List<Object> cols;

	public TreeList() {
		super();
	}

	public TreeList(Properties properties) {
		this();
		this.properties = properties;
	}

	public TreeList(SupTreeList supTreeList) {
		this();
		if (supTreeList != null) {
			if (supTreeList.properties() != null) {
				this.properties = new Properties(supTreeList.properties());
			}
			if (supTreeList.fonts() != null) {
				for (SupFont supFont : supTreeList.fonts()) {
					if (this.fonts == null) {
						this.fonts = Lists.newArrayList();
					}
					this.fonts.add(new Font(supFont));
				}
			}
		}
	}

	public List<Object> getCols() {
		if (cols == null) {
			cols = Lists.newArrayList();
		}
		return cols;
	}

	public void setCols(List<Object> cols) {
		this.cols = cols;
	}

}
