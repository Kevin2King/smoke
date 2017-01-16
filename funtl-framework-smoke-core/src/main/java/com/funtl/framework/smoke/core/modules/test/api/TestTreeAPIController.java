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

package com.funtl.framework.smoke.core.modules.test.api;

import java.util.List;

import com.funtl.framework.core.dto.BaseResult;
import com.funtl.framework.core.web.BaseController;
import com.funtl.framework.smoke.core.modules.test.entity.TestTree;
import com.funtl.framework.smoke.core.modules.test.service.TestTreeService;
import com.wordnik.swagger.annotations.ApiOperation;
import com.wordnik.swagger.annotations.ApiParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

/**
 * 生成案例APIController
 *
 * @author 李卫民
 * @version 2016-08-27
 */
@RestController
@RequestMapping(value = "${apiPath}/test")
public class TestTreeAPIController extends BaseController {
	@Autowired
	private TestTreeService testTreeService;

	@RequestMapping(value = "testTree", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ApiOperation(value = "获取全部数据", httpMethod = "GET", response = TestTree.class, notes = "获取全部数据")
	public BaseResult<List<TestTree>> getList() {
		return new BaseResult<List<TestTree>>(true, testTreeService.findList(new TestTree()));
	}

	@RequestMapping(value = "testTree/{id}", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ApiOperation(value = "根据ID获取数据项", httpMethod = "GET", response = TestTree.class, notes = "根据ID获取数据项")
	public BaseResult<TestTree> getObj(@ApiParam(required = true, name = "id", value = "数据项ID") @PathVariable String id) {
		return new BaseResult<TestTree>(true, testTreeService.get(id));
	}

	// ---------------------------------------- 校验代码 ----------------------------------------

	// ---------------------------------------- 业务代码 ----------------------------------------

}