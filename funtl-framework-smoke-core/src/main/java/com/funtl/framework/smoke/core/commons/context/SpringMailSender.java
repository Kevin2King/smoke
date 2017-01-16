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

package com.funtl.framework.smoke.core.commons.context;

import freemarker.template.Template;

import java.util.Map;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.MimeMessage;

import com.funtl.framework.core.utils.SpringContextHolder;
import com.funtl.framework.smoke.core.modules.sys.entity.SysMail;
import com.funtl.framework.smoke.core.modules.sys.service.SysMailService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

/**
 * Spring邮件发送工具
 * Created by 李卫民 on 2016/8/5.
 */
@Component
public class SpringMailSender {
	private static final Logger logger = LoggerFactory.getLogger(SpringMailSender.class);

	private JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
	private SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
	@Autowired
	private FreeMarkerConfigurer freeMarkerConfigurer;
	@Autowired
	private TaskExecutor taskExecutor;

	private SysMailService sysMailService = SpringContextHolder.getBean(SysMailService.class);

	/**
	 * 初始化参数
	 */
	private void initParams() throws AddressException {
		SysMail sysMail = sysMailService.get("bc97b7dd79444a6492cfe5d9db502902");
		javaMailSender.setHost(sysMail.getMailHost()); // 主机
		javaMailSender.setPort(sysMail.getMailPort()); // 端口
		javaMailSender.setUsername(sysMail.getMailUsername()); // 邮箱用户名
		javaMailSender.setPassword(sysMail.getMailPassword()); // 邮箱密码

		// 设置Properties属性
		Properties properties = System.getProperties();
		properties.put("mail.smtp.auth", "true");
		// 设置启动SSL/TLS
		if (sysMail.getMailSsl().equals("1")) {
			properties.put("mail.smtp.ssl", "true");
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.ssl.trust", sysMail.getMailHost());
		} else {
			properties.put("mail.smtp.ssl", "false");
			properties.put("mail.smtp.starttls.enable", "false");
		}
		javaMailSender.setJavaMailProperties(properties);

		simpleMailMessage.setFrom(sysMail.getMailFrom().concat("<" + sysMail.getMailUsername() + ">")); // 发件人地址，使用昵称的方式发送
	}

	/**
	 * 构建邮件内容，发送邮件
	 *
	 * @param to       收件人
	 * @param subject  邮件主题
	 * @param template 邮件模板名称
	 * @param map      邮件模板占位符参数
	 * @param isAsync  是否异步发送
	 */
	public boolean send(String to, String subject, String template, Map<String, Object> map, boolean isAsync) {
		String content = "";

		try {
			initParams();
			// 从FreeMarker模板生成邮件内容
			Template templateFile = freeMarkerConfigurer.getConfiguration().getTemplate("/".concat(template.concat(".ftl")));
			// 模板中用${XXX}站位，map中key为XXX的value会替换占位符内容
			content = FreeMarkerTemplateUtils.processTemplateIntoString(templateFile, map);

			// 异步发送邮件
			if (isAsync) {
				this.taskExecutor.execute(new SendMailThread(to, subject, content));
			} else {
				sendMail(to, subject, content);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * 内部线程类，利用线程池异步发邮件。
	 */
	private class SendMailThread implements Runnable {
		private String to;
		private String subject;
		private String content;

		private SendMailThread(String to, String subject, String content) {
			super();
			this.to = to;
			this.subject = subject;
			this.content = content;
		}

		@Override
		public void run() {
			sendMail(to, subject, content);
		}
	}

	/**
	 * 发送邮件
	 *
	 * @param to      收件人邮箱
	 * @param subject 邮件主题
	 * @param content 邮件内容
	 */
	private void sendMail(String to, String subject, String content) {
		try {
			MimeMessage message = javaMailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(simpleMailMessage.getFrom());
			if (subject != null) {
				messageHelper.setSubject(subject);
			} else {
				messageHelper.setSubject(simpleMailMessage.getSubject());
			}
			messageHelper.setTo(to);
			messageHelper.setText(content, true);
			javaMailSender.send(message);
		} catch (MessagingException e) {
			logger.error("邮件发送失败");
			e.printStackTrace();
		}
	}
}
