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

package com.funtl.framework.smoke.core.modules.sys.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.framework.core.utils.RequestUtils;
import com.funtl.framework.core.utils.StringUtils;
import com.funtl.framework.core.utils.UserAgentUtils;
import com.funtl.framework.smoke.core.commons.service.BaseService;
import com.funtl.framework.tencent.wechat.jsapi.JsApiManager;
import com.funtl.framework.tencent.wechat.jsapi.JsApiParam;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 手机端视图拦截器
 *
 * @author 李卫民
 */
public class MobileInterceptor extends BaseService implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (modelAndView != null) {
			// 如果是手机或平板访问的话，则跳转到手机视图页面。
			if (UserAgentUtils.isMobileOrTablet(request) && !StringUtils.startsWithIgnoreCase(modelAndView.getViewName(), "redirect:")) {
				String ua = request.getHeader("user-agent").toLowerCase();
				// 微信浏览器
				if (ua.indexOf("micromessenger") > 0) {
					// 引入JSSDK所需参数
					JsApiParam jsApiParam = JsApiManager.signature(RequestUtils.getFullURLWithOutPort(request));
					modelAndView.addObject("jsApiParam", jsApiParam);
				}
				modelAndView.setViewName("mobile/" + modelAndView.getViewName());
			}
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
	}

}
