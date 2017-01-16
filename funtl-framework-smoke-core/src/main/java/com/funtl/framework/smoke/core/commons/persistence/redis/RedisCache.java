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

package com.funtl.framework.smoke.core.commons.persistence.redis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.util.Set;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import com.funtl.framework.core.config.Global;
import com.funtl.framework.core.serialize.SerializeUtil;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.ibatis.cache.Cache;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by 李卫民 on 2016/7/19.
 */
public class RedisCache implements Cache {
	private static Logger logger = LoggerFactory.getLogger(RedisCache.class);

	// Redis服务器IP
	private static String ADDR_ARRAY = Global.getConfig("redis.host");
	// Redis的端口号
	private static int PORT = Integer.parseInt(Global.getConfig("redis.port"));
	// 访问密码
	private static String AUTH = Global.getConfig("redis.pass");

	/**
	 * The ReadWriteLock.
	 */
	private final ReadWriteLock readWriteLock = new ReentrantReadWriteLock();
	private String id;
	private JedisPool jedisPool;
	private static final int DB_INDEX = 1;
	private final String KEY_PREFIX = Global.getConfig("redis.keyPrefix");
	private static final String UTF8 = "utf-8";

	private ApplicationContext context;

	/**
	 * 按照一定规则标识key
	 */
	private String getKey(Object key) {
		StringBuilder accum = new StringBuilder();
		accum.append(KEY_PREFIX);
		accum.append(this.id).append(":");
		accum.append(DigestUtils.md5Hex(String.valueOf(key)));
		return accum.toString();
	}

	/**
	 * redis key规则前缀
	 */
	private String getKeys() {
		return KEY_PREFIX + this.id + ":*";
	}

	public RedisCache() {

	}

	public RedisCache(final String id) {
		if (id == null) {
			throw new IllegalArgumentException("必须传入ID");
		}
		context = new ClassPathXmlApplicationContext("spring-context-jedis.xml");
		JedisPoolConfig jedisPoolConfig = (JedisPoolConfig) context.getBean("jedisPoolConfig");
		jedisPool = new JedisPool(jedisPoolConfig, ADDR_ARRAY.split(",")[0], PORT, 30000, AUTH.length() == 0 ? null : AUTH);
		logger.debug("MybatisRedisCache:id=" + id);
		this.id = id;
	}

	@Override
	public String getId() {
		return this.id;
	}

	@Override
	public int getSize() {
		Jedis jedis = null;
		int result = 0;
		boolean borrowOrOprSuccess = true;
		try {
			jedis = jedisPool.getResource();
			jedis.select(DB_INDEX);
			Set<byte[]> keys = jedis.keys(getKeys().getBytes(UTF8));
			if (null != keys && !keys.isEmpty()) {
				result = keys.size();
			}
			logger.debug(this.id + "---->>>>总缓存数:" + result);
		} catch (Exception e) {
			borrowOrOprSuccess = false;
			if (jedis != null) jedis.close();
		} finally {
			if (borrowOrOprSuccess) jedis.close();
		}
		return result;
	}

	@Override
	public void putObject(Object key, Object value) {
		Jedis jedis = null;
		boolean borrowOrOprSuccess = true;
		try {
			jedis = jedisPool.getResource();
			jedis.select(DB_INDEX);

			byte[] keys = getKey(key).getBytes(UTF8);
			jedis.set(keys, SerializeUtil.serialize(value));
			logger.debug("添加缓存--------" + this.id);
			// getSize();
		} catch (Exception e) {
			borrowOrOprSuccess = false;
			if (jedis != null) jedis.close();
		} finally {
			if (borrowOrOprSuccess) jedis.close();
		}
	}

	@Override
	public Object getObject(Object key) {
		Jedis jedis = null;
		Object value = null;
		boolean borrowOrOprSuccess = true;
		try {
			jedis = jedisPool.getResource();
			jedis.select(DB_INDEX);
			value = SerializeUtil.unserialize(jedis.get(getKey(key).getBytes(UTF8)));
			logger.debug("从缓存中获取-----" + this.id);
			// getSize();
		} catch (Exception e) {
			borrowOrOprSuccess = false;
			if (jedis != null) jedis.close();
		} finally {
			if (borrowOrOprSuccess) jedis.close();
		}
		return value;
	}

	@Override
	public Object removeObject(Object key) {
		Jedis jedis = null;
		Object value = null;
		boolean borrowOrOprSuccess = true;
		try {
			jedis = jedisPool.getResource();
			jedis.select(DB_INDEX);
			value = jedis.del(getKey(key).getBytes(UTF8));
			logger.debug("LRU算法从缓存中移除-----" + this.id);
			// getSize();
		} catch (Exception e) {
			borrowOrOprSuccess = false;
			if (jedis != null) jedis.close();
		} finally {
			if (borrowOrOprSuccess) jedis.close();
		}
		return value;
	}

	@Override
	public void clear() {
		Jedis jedis = null;
		boolean borrowOrOprSuccess = true;
		try {
			jedis = jedisPool.getResource();
			jedis.select(DB_INDEX);
			// 如果有删除操作，会影响到整个表中的数据，因此要清空一个mapper的缓存（一个mapper的不同数据操作对应不同的key）
			Set<byte[]> keys = jedis.keys(getKeys().getBytes(UTF8));
			logger.debug("出现CUD操作，清空对应Mapper缓存======>" + keys.size());
			for (byte[] key : keys) {
				jedis.del(key);
			}
			// 下面是网上流传的方法，极大的降低系统性能，没起到加入缓存应有的作用，这是不可取的。
			// jedis.flushDB();
			// jedis.flushAll();
		} catch (Exception e) {
			borrowOrOprSuccess = false;
			if (jedis != null) jedis.close();
		} finally {
			if (borrowOrOprSuccess) jedis.close();
		}
	}

	@Override
	public ReadWriteLock getReadWriteLock() {
		return readWriteLock;
	}
}
