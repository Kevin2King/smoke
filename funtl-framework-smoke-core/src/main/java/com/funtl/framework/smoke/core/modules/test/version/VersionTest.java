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

package com.funtl.framework.smoke.core.modules.test.version;

import com.funtl.framework.smoke.core.modules.version.entity.VersionInfo;
import com.funtl.framework.smoke.core.modules.version.service.VersionInfoService;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by warne on 2016/12/4.
 * DESC: word brother 666
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath*:/spring-context*.xml")
public class VersionTest {
	@Autowired
	private VersionInfoService versionService;

	@Test
	public void test1() {

		VersionInfo v = new VersionInfo();
		v.setProjectCode("10001001");
		v.setUniqueCode("123456");
		v.setServerUrl("http://172.16.6.40:8087/");
		v.setVersionListUrl("version/list/");
		v.setVersionUpdateUrl("version/update/");
		v.setVersionName("V1.1.0");
		v.setInnerVersion("5");
		v.setUpdateVersion("");
		v.setApiVersion("api/v1/");
		v.setAdmin("admin123");
		v.setPassword("123456");
		v.setUpdateVersion("V1.1.2");
		v.setCallbackUrl("http://172.16.6.40:8087/");

		versionService.save(v);

	}
}
