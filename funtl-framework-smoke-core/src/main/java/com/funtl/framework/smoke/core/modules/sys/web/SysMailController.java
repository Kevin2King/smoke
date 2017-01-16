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

package com.funtl.framework.smoke.core.modules.sys.web;

import java.util.Map;

import com.funtl.framework.core.config.Global;
import com.funtl.framework.core.utils.StringUtils;
import com.funtl.framework.core.web.BaseController;
import com.funtl.framework.smoke.core.commons.context.SpringMailSender;
import com.funtl.framework.smoke.core.modules.sys.entity.SysMail;
import com.funtl.framework.smoke.core.modules.sys.service.SysMailService;
import com.google.common.collect.Maps;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 系统设置Controller
 *
 * @author 李卫民
 * @version 2016-08-05
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysMail")
public class SysMailController extends BaseController {

	@Autowired
	private SpringMailSender springMailSender;

	@Autowired
	private SysMailService sysMailService;

	@ModelAttribute
	public SysMail get(@RequestParam(required = false) String id) {
		SysMail entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = sysMailService.get(id);
		}
		if (entity == null) {
			entity = new SysMail();
		}
		return entity;
	}

	@RequiresPermissions("sys:sysMail:view")
	@RequestMapping(value = "form")
	public String form(SysMail sysMail, Model model) {
		model.addAttribute("sysMail", sysMail);
		return "modules/sys/sysMailForm";
	}

	@RequiresPermissions("sys:sysMail:edit")
	@RequestMapping(value = "save")
	public String save(SysMail sysMail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysMail)) {
			return form(sysMail, model);
		}
		sysMailService.save(sysMail);
		addMessage(redirectAttributes, "保存邮箱配置成功");
		return "redirect:" + Global.getAdminPath() + "/sys/sysMail/form?id=".concat(sysMail.getId());
	}

	// ---------------------------------------- 校验代码 ----------------------------------------

	// ---------------------------------------- 业务代码 ----------------------------------------

	@RequiresPermissions("sys:sysMail:edit")
	@RequestMapping(value = "sendTestMail")
	public String sendTestMail(SysMail sysMail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysMail)) {
			return form(sysMail, model);
		}

		sysMailService.save(sysMail);

		Map<String, Object> map = Maps.newHashMap();
		map.put("username", sysMail.getMailUsername());
		boolean isSuccess = springMailSender.send(sysMail.getMailUsername(), "测试邮件", "test", map, false);
		if (isSuccess) {
			addMessage(redirectAttributes, "邮件发送成功");
		} else {
			addMessage(redirectAttributes, "邮件发送失败");
		}

		return "redirect:" + Global.getAdminPath() + "/sys/sysMail/form?id=".concat(sysMail.getId());
	}

}