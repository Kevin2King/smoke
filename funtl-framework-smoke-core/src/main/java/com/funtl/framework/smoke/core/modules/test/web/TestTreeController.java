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

package com.funtl.framework.smoke.core.modules.test.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.framework.core.config.Global;
import com.funtl.framework.core.utils.StringUtils;
import com.funtl.framework.core.web.BaseController;
import com.funtl.framework.smoke.core.commons.persistence.Page;
import com.funtl.framework.smoke.core.modules.test.entity.TestTree;
import com.funtl.framework.smoke.core.modules.test.service.TestTreeService;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 生成案例Controller
 *
 * @author 李卫民
 * @version 2016-10-31
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testTree")
public class TestTreeController extends BaseController {

	@Autowired
	private TestTreeService testTreeService;

	@ModelAttribute
	public TestTree get(@RequestParam(required = false) String id) {
		TestTree entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = testTreeService.get(id);
		}
		if (entity == null) {
			entity = new TestTree();
		}
		return entity;
	}

	@RequiresPermissions("test:testTree:view")
	@RequestMapping(value = {"list", ""})
	public String list(TestTree testTree, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TestTree> page = testTreeService.findPage(new Page<TestTree>(request, response), testTree);
		model.addAttribute("page", page);
		return "modules/test/testTreeList";
	}

	@RequiresPermissions("test:testTree:view")
	@RequestMapping(value = "form")
	public String form(TestTree testTree, Model model) {
		model.addAttribute("testTree", testTree);
		return "modules/test/testTreeForm";
	}

	@RequiresPermissions("test:testTree:edit")
	@RequestMapping(value = "save")
	public String save(TestTree testTree, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testTree)) {
			return form(testTree, model);
		}
		testTreeService.save(testTree);
		addMessage(redirectAttributes, "保存树结构表成功");
		return "redirect:" + Global.getAdminPath() + "/test/testTree/?repage";
	}

	@RequiresPermissions("test:testTree:edit")
	@RequestMapping(value = "delete")
	public String delete(TestTree testTree, RedirectAttributes redirectAttributes) {
		testTreeService.delete(testTree);
		addMessage(redirectAttributes, "删除树结构表成功");
		return "redirect:" + Global.getAdminPath() + "/test/testTree/?repage";
	}

	// ---------------------------------------- 校验代码 ----------------------------------------

	// ---------------------------------------- 业务代码 ----------------------------------------

}