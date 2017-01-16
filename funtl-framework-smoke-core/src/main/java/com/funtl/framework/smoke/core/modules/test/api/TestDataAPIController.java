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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.funtl.framework.core.dto.BaseResult;
import com.funtl.framework.core.mapper.JsonMapper;
import com.funtl.framework.core.web.BaseController;
import com.funtl.framework.smoke.core.commons.persistence.Page;
import com.funtl.framework.smoke.core.modules.test.entity.TestData;
import com.funtl.framework.smoke.core.modules.test.service.TestDataService;
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
public class TestDataAPIController extends BaseController {
	@Autowired
	private TestDataService testDataService;

	@RequestMapping(value = "testData", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ApiOperation(value = "获取全部数据", httpMethod = "GET", response = TestData.class, notes = "获取全部数据")
	public BaseResult<List<TestData>> getList() {
		return new BaseResult<List<TestData>>(true, testDataService.findList(new TestData()));
	}

	@RequestMapping(value = "testData/{id}", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ApiOperation(value = "根据ID获取数据项", httpMethod = "GET", response = TestData.class, notes = "根据ID获取数据项")
	public BaseResult<TestData> getObj(@ApiParam(required = true, name = "id", value = "数据项ID") @PathVariable String id) {
		return new BaseResult<TestData>(true, testDataService.get(id));
	}

	@RequestMapping(value = "testData/page/{jsonParams}", method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ApiOperation(value = "根据对象参数查询分页数据", httpMethod = "GET", response = TestData.class, notes = "根据对象参数查询分页数据")
	public BaseResult<Page<TestData>> getPage(@ApiParam(required = true, name = "jsonParams", value = "查询对象的JSON形态") @PathVariable String jsonParams, @ApiParam(required = true, name = "request", value = "分页参数pageNo、pageSize需要通过request传递") HttpServletRequest request, @ApiParam(required = true, name = "response", value = "") HttpServletResponse response) {
		TestData testData = JsonMapper.getInstance().fromJson(jsonParams, TestData.class);
		if (testData == null) testData = new TestData();
		Page<TestData> page = testDataService.findPage(new Page<TestData>(request, response), testData);
		return new BaseResult<Page<TestData>>(true, testDataService.findPage(new Page<TestData>(request, response), testData));
	}

	// ---------------------------------------- 校验代码 ----------------------------------------

	// ---------------------------------------- 业务代码 ----------------------------------------

}