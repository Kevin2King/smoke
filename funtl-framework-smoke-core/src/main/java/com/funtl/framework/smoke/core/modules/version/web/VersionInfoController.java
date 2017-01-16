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

package com.funtl.framework.smoke.core.modules.version.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.framework.core.config.Global;
import com.funtl.framework.core.utils.StringUtils;
import com.funtl.framework.core.web.BaseController;
import com.funtl.framework.smoke.core.commons.persistence.Page;
import com.funtl.framework.smoke.core.commons.trans.ReMsg;
import com.funtl.framework.smoke.core.modules.version.entity.VersionInfo;
import com.funtl.framework.smoke.core.modules.version.service.IVersion;
import com.funtl.framework.smoke.core.modules.version.service.VersionInfoService;
import com.funtl.framework.smoke.core.modules.version.util.VersionUtils;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 系统版本Controller
 *
 * @author warne
 * @version 2016-12-04
 */
@Controller
@RequestMapping(value = "${adminPath}/version/versionInfo")
public class VersionInfoController extends BaseController implements IVersion {

	@Autowired
	private VersionInfoService versionInfoService;

	@ModelAttribute
	public VersionInfo get(@RequestParam(required = false) String id) {
		VersionInfo entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = versionInfoService.get(id);
		}
		if (entity == null) {
			entity = new VersionInfo();
		}
		return entity;
	}

	@RequiresPermissions("version:versionInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(VersionInfo versionInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<VersionInfo> page = versionInfoService.findPage(new Page<VersionInfo>(request, response), versionInfo);
		model.addAttribute("page", page);
		return "modules/version/versionInfoList";
	}

	@RequiresPermissions("version:versionInfo:view")
	@RequestMapping(value = "form")
	public String form(VersionInfo versionInfo, Model model) {
		model.addAttribute("versionInfo", versionInfo);
		return "modules/version/versionInfoForm";
	}

	@RequiresPermissions("version:versionInfo:edit")
	@RequestMapping(value = "save")
	public String save(VersionInfo versionInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, versionInfo)) {
			return form(versionInfo, model);
		}
		versionInfoService.save(versionInfo);
		addMessage(redirectAttributes, "保存系统版本成功");
		return "redirect:" + Global.getAdminPath() + "/version/versionInfo/?repage";
	}

	@RequiresPermissions("version:versionInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(VersionInfo versionInfo, RedirectAttributes redirectAttributes) {
		versionInfoService.delete(versionInfo);
		addMessage(redirectAttributes, "删除系统版本成功");
		return "redirect:" + Global.getAdminPath() + "/version/versionInfo/?repage";
	}

	// ---------------------------------------- 校验代码 ----------------------------------------

	// ---------------------------------------- 业务代码 ----------------------------------------
	@Resource
	private VersionInfoService versionService;

	@RequiresPermissions("version:versionInfo:view")
	@RequestMapping(value = "listing")
	public String versionList(Model model) {
		model.addAttribute("versions", VersionUtils.qryVersionsAndEqual4Map().getValue1());
		return "modules/version/versionList";
	}

	/**
	 * 立即更新（升级）
	 *
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("version:versionInfo:edit")
	@RequestMapping(value = "update/upgrade/{inVerNo}", method = RequestMethod.POST)
	public ReMsg nowUpgradeSys(@PathVariable String inVerNo, HttpServletRequest request) {
		ReMsg msg = versionService.WhetherUpdate();
		if (msg.state()) { //# update
			msg = versionService.doUpdateGrade(request, inVerNo);
			if (!msg.state()) {
				return msg;
			}
		}
		return msg; //# 如果失败，返回错误描述
	}


	/**
	 * 修改密码
	 * 部署服务器的root密码
	 *
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("version:versionInfo:edit")
	@RequestMapping(value = "modify/password/{passwd}", method = RequestMethod.POST)
	public ReMsg modifyPassword(@PathVariable String passwd) {
		return versionInfoService.doModifyPasswd(passwd);
	}


	/**
	 * 立即回退（回滚）
	 *
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("version:versionInfo:edit")
	@RequestMapping(value = "update/rollback", method = RequestMethod.POST)
	public String nowRollBackSys(@RequestParam String inVerNo, HttpServletRequest request) {
		return "程序猿上厕所ing, 完了就写回退的功能~~~";
	}


}