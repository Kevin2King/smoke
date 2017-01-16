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

package com.funtl.framework.smoke.core.commons.persistence;

import java.util.List;

/**
 * DAO支持类实现
 *
 * @author 李卫民
 */
public interface CrudDao<T> extends BaseDao {
	/**
	 * 获取单条数据
	 *
	 * @param id
	 * @return
	 */
	public T get(String id);

	/**
	 * 获取单条数据
	 *
	 * @param entity
	 * @return
	 */
	public T get(T entity);

	/**
	 * 查询数据列表，如果需要分页，请设置分页对象，如：entity.setPage(new Page<T>());
	 *
	 * @param entity
	 * @return
	 */
	public List<T> findList(T entity);

	/**
	 * 查询所有数据列表
	 *
	 * @param entity
	 * @return
	 */
	public List<T> findAllList(T entity);

	/**
	 * 查询所有数据列表
	 *
	 * @return
	 * @see public List<T> findAllList(T entity)
	 */
	@Deprecated
	public List<T> findAllList();

	/**
	 * 插入数据
	 *
	 * @param entity
	 * @return
	 */
	public int insert(T entity);

	/**
	 * 更新数据
	 *
	 * @param entity
	 * @return
	 */
	public int update(T entity);

	/**
	 * 删除数据（一般为逻辑删除，更新del_flag字段为1）
	 *
	 * @param id
	 * @return
	 * @see public int delete(T entity)
	 */
	@Deprecated
	public int delete(String id);

	/**
	 * 删除数据（一般为逻辑删除，更新del_flag字段为1）
	 *
	 * @param entity
	 * @return
	 */
	public int delete(T entity);

}