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

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.funtl.framework.core.security.Digests;
import com.funtl.framework.core.utils.Encodes;
import com.funtl.framework.core.web.BaseController;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * Created by Lusifer on 2015/9/30.
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/upload")
public class FileUploadController extends BaseController {
	@RequestMapping(value = {"form"})
	@RequiresPermissions("user")
	public String form(String id, Model model) {
		model.addAttribute("id", id);
		return "modules/sys/fileUpload";
	}

	/**
	 * Ajax请求检查上传服务器是否可用
	 *
	 * @param hostName
	 * @param acceptType
	 * @param acceptLang
	 * @param acceptEnc
	 * @param cookie
	 * @param userAgent
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "check")
	@RequiresPermissions("user")
	public String check(@RequestHeader("host") String hostName, @RequestHeader("Accept") String acceptType, @RequestHeader("Accept-Language") String acceptLang, @RequestHeader("Accept-Encoding") String acceptEnc, @RequestHeader("Cookie") String cookie, @RequestHeader("User-Agent") String userAgent) {
		//        System.out.println("Host : " + hostName);
		//        System.out.println("Accept : " + acceptType);
		//        System.out.println("Accept Language : " + acceptLang);
		//        System.out.println("Accept Encoding : " + acceptEnc);
		//        System.out.println("Cache-Control : " + cacheCon);
		//        System.out.println("Cookie : " + cookie);
		//        System.out.println("User-Agent : " + userAgent);
		return "ok";
	}

	/**
	 * 文件上传
	 *
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "", method = RequestMethod.POST)
	@RequiresPermissions("user")
	public Map<String, Object> fileUpload(HttpServletRequest request) throws IOException {
		Map<String, Object> map = Maps.newHashMap();

		// 设置上下方文
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());

		// 检查form是否有enctype="multipart/form-data"
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				// 由CommonsMultipartFile继承而来,拥有上面的方法.
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					String oldName = new SimpleDateFormat("yyyyMMddHHmmssdd").format(new Date()) + file.getOriginalFilename();
					String fileName = Encodes.encodeHex(Digests.md5(oldName.getBytes())) + oldName.substring(oldName.lastIndexOf("."));
					String path = request.getSession().getServletContext().getRealPath(String.format("%simgs%s", File.separator, File.separator));
					File filePath = new File(path);
					if (!filePath.exists()) {
						filePath.mkdir();
					}
					path = request.getSession().getServletContext().getRealPath(String.format("%simgs%s", File.separator, File.separator) + fileName);
					File localFile = new File(path);
					file.transferTo(localFile);

					// 返回结果给jQuery file upload
					List<Map<String, Object>> mapList = Lists.newArrayList();
					Map<String, Object> result = Maps.newHashMap();
					result.put("name", new String[]{String.format("上传成功，文件名为：%s", fileName)});
					result.put("url", new String[]{String.format("/imgs/%s", fileName)});
					mapList.add(result);
					map.put("files", mapList);
				}

			}
		}

		return map;
	}

	/**
	 * 百度富文本编辑器上传组件
	 *
	 * @return
	 */
	@RequestMapping(value = "ueditor")
	@RequiresPermissions("user")
	public String ueditorUpload() {
		return "modules/sys/ueditorUpload";
	}
}
