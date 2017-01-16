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

package com.funtl.framework.smoke.core.modules.sys.entity;

import javax.validation.constraints.NotNull;

import com.funtl.framework.smoke.core.commons.persistence.DataEntity;

import org.hibernate.validator.constraints.Length;

/**
 * 系统设置Entity
 *
 * @author 李卫民
 * @version 2016-08-05
 */
public class SysMail extends DataEntity<SysMail> {
	private String mailHost;        // 主机名
	private Integer mailPort;        // 主机端口
	private String mailUsername;        // 邮箱地址
	private String mailPassword;        // 邮箱密码
	private String mailFrom;        // 发件人名称
	private String mailSsl;        // 使用SSL/TLS

	public SysMail() {
		super();
	}

	public SysMail(String id) {
		super(id);
	}

	@Length(min = 1, max = 100, message = "主机名长度必须介于 1 和 100 之间")
	public String getMailHost() {
		return mailHost;
	}

	public void setMailHost(String mailHost) {
		this.mailHost = mailHost;
	}

	@NotNull(message = "主机端口不能为空")
	public Integer getMailPort() {
		return mailPort;
	}

	public void setMailPort(Integer mailPort) {
		this.mailPort = mailPort;
	}

	@Length(min = 1, max = 100, message = "邮箱地址长度必须介于 1 和 100 之间")
	public String getMailUsername() {
		return mailUsername;
	}

	public void setMailUsername(String mailUsername) {
		this.mailUsername = mailUsername;
	}

	@Length(min = 1, max = 100, message = "邮箱密码长度必须介于 1 和 100 之间")
	public String getMailPassword() {
		return mailPassword;
	}

	public void setMailPassword(String mailPassword) {
		this.mailPassword = mailPassword;
	}

	@Length(min = 1, max = 100, message = "发件人名称长度必须介于 1 和 100 之间")
	public String getMailFrom() {
		return mailFrom;
	}

	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}

	@Length(min = 1, max = 1, message = "使用SSL/TLS长度必须介于 1 和 1 之间")
	public String getMailSsl() {
		return mailSsl;
	}

	public void setMailSsl(String mailSsl) {
		this.mailSsl = mailSsl;
	}

}