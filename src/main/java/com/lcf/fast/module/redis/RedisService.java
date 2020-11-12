package com.lcf.fast.module.redis;

import cn.hutool.core.collection.CollectionUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lcf.fast.common.exception.BFRuntimeException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.*;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * redis 操作服务类
 *
 * @author lcf
 * @date 2020/4/9 16:36
 */
@Slf4j
@Component
public class RedisService {
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    private ValueOperations<String, String> redisValueOperations;
    @Autowired
    private HashOperations<String, String, Object> redisHashOperations;
    @Autowired
    private ListOperations<String, Object> redisListOperations;
    @Autowired
    private SetOperations<String, Object> redisSetOperations;

    /**
     * 指定缓存失效时间
     *
     * @param key  键
     * @param time 时间(秒)
     * @return
     */
    public boolean expire(String key, long time) {
        try {
            if (time > 0) {
                redisTemplate.expire(key, time, TimeUnit.SECONDS);
            }
            return true;
        } catch (Exception e) {
            log.error("设置缓存key[{}]失效时间异常[{}]", key, e);
            return false;
        }
    }

    /**
     * 根据key 获取过期时间
     *
     * @param key 键 不能为null
     * @return 时间(秒) 返回0代表为永久有效
     */
    public long getExpire(String key) {
        return redisTemplate.getExpire(key, TimeUnit.SECONDS);
    }

    //*******************************************Keys*******************************************//

    /**
     * 判断key是否存在
     *
     * @param key 键
     * @return true 存在 false不存在
     */
    public boolean hasKey(String key) {
        try {
            return redisTemplate.hasKey(key);
        } catch (Exception e) {
            log.error("判断key[{}]是否存在异常[{}]", key, e);
            return false;
        }
    }

    /**
     * 删除缓存
     *
     * @param key 可以传一个值 或多个
     */
    @SuppressWarnings("unchecked")
    public void del(String... key) {
        if (key != null && key.length > 0) {
            if (key.length == 1) {
                redisTemplate.delete(key[0]);
            } else {
                redisTemplate.delete(CollectionUtils.arrayToList(key));
            }
        }
    }

    /**
     * 模糊删除缓存
     *
     * @param key 模糊匹配
     */
    public void delKeysPattern(String key) {
        Set<String> keysList = redisTemplate.keys(key);
        redisTemplate.delete(keysList);
    }
    //*******************************************pub*******************************************//

    /**
     * 发送消息
     *
     * @param topic
     * @param msg
     */
    public void publish(String topic, Object msg) {
        redisTemplate.convertAndSend(topic, msg);
    }
    //*******************************************String*******************************************//
    // string 是 redis 最基本的类型，你可以理解成与 Memcached 一模一样的类型，一个 key 对应一个 value。
    // value其实不仅是String，也可以是数字。
    // string 类型是二进制安全的。意思是 redis 的 string 可以包含任何数据。比如jpg图片或者序列化的对象。
    // string 类型是 Redis 最基本的数据类型，string 类型的值最大能存储 512MB。
    // 常用命令：get、set、incr、decr、mget等

    /**
     * get 缓存获取
     *
     * @param key 键
     * @return 值
     */
    public String get(String key) {
        return key == null ? null : redisValueOperations.get(key);
    }

    /**
     * get 缓存获取映射对象
     *
     * @param key 键
     * @return 值
     */
    public <T> T getObject(String key, Class<T> clazz) {
        Object json = this.get(key);
        if (json == null) {
            return null;
        }
        T obj = JSON.parseObject(json.toString(), clazz);
        return obj;
    }

    /**
     * get 缓存获取映射对象列表
     *
     * @param key 键
     * @return 值
     */
    public <T> List<T> getList(String key, Class<T> clz) {
        Object json = this.get(key);
        if (json == null) {
            return CollectionUtil.newArrayList();
        }
        List<T> list = JSONObject.parseArray(json.toString(), clz);
        return list;
    }

    /**
     * set 缓存设置
     *
     * @param key   键
     * @param value 值
     * @return true成功 false失败
     */
    public boolean set(String key, String value) {
        try {
            redisValueOperations.set(key, value);
            return true;
        } catch (Exception e) {
            log.error("string缓存[{}]设置异常[{}]", key, e);
            return false;
        }

    }

    /**
     * set 缓存设置 设置过期时间
     *
     * @param key   键
     * @param value 值
     * @param time  时间(秒) time要大于0 如果time小于等于0 将设置无限期
     * @return true成功 false 失败
     */
    public boolean set(String key, String value, long time) {
        try {
            if (time > 0) {
                redisValueOperations.set(key, value, time, TimeUnit.SECONDS);
            } else {
                set(key, value);
            }
            return true;
        } catch (Exception e) {
            log.error("string缓存[{}]设置异常[{}]", key, e);
            return false;
        }
    }

    /**
     * incr 增量
     * 如果值不能进行加减运算会报异常
     *
     * @param key   键
     * @param delta 增加值 负数时为减
     * @return
     */
    public long increment(String key, long delta) {
        try {
            return redisValueOperations.increment(key, delta);
        } catch (Exception e) {
            log.error("增量[{}]设置异常[{}]", key, e);
            throw new BFRuntimeException("redis增量设置异常");
        }
    }

    //*******************************************Hash*******************************************//
    // Redis hash 是一个键值(key => value)对集合。
    // Redis hash 是一个 string 类型的 field 和 value 的映射表，hash 特别适合用于存储对象。
    // 常用命令：hget,hset,hgetall 等。

    /**
     * hget 获取hash对象
     *
     * @param key  键 不能为null
     * @param item 项 不能为null
     * @return 值
     */
    public Object hget(String key, String item) {
        return redisHashOperations.get(key, item);
    }

    /**
     * hgetall 获取hashKey对应的所有键值
     *
     * @param key 键
     * @return 对应的多个键值
     */
    public Map<String, Object> hgetall(String key) {
        return redisHashOperations.entries(key);
    }

    /**
     * hsetall 设置hash所有项
     *
     * @param key 键
     * @param map 对应多个键值
     * @return true 成功 false 失败
     */
    public boolean hsetall(String key, Map<String, Object> map) {
        try {
            redisHashOperations.putAll(key, map);
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * hsetall 设置hash所有项 并设置时间
     *
     * @param key  键
     * @param map  对应多个键值
     * @param time 时间(秒)
     * @return true成功 false失败
     */
    public boolean hsetall(String key, Map<String, Object> map, long time) {
        try {
            redisHashOperations.putAll(key, map);
            if (time > 0) {
                expire(key, time);
            }
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * hset 设置hash表某项,如果不存在将创建
     *
     * @param key   键
     * @param item  项
     * @param value 值
     * @return true 成功 false失败
     */
    public boolean hset(String key, String item, Object value) {
        try {
            redisHashOperations.put(key, item, value);
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * hset 设置hash表某项,如果不存在将创建 并设置过期时间
     *
     * @param key   键
     * @param item  项
     * @param value 值
     * @param time  时间(秒)  注意:如果已存在的hash表有时间,这里将会替换原有的时间
     * @return true 成功 false失败
     */
    public boolean hset(String key, String item, Object value, long time) {
        try {
            redisHashOperations.put(key, item, value);
            if (time > 0) {
                expire(key, time);
            }
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * hdel 删除hash表中的值
     *
     * @param key  键 不能为null
     * @param item 项 可以使多个 不能为null
     */
    public void hdel(String key, Object... item) {
        redisHashOperations.delete(key, item);
    }

    /**
     * 判断hash表中是否有该项的值
     *
     * @param key  键 不能为null
     * @param item 项 不能为null
     * @return true 存在 false不存在
     */
    public boolean hHasKey(String key, String item) {
        return redisHashOperations.hasKey(key, item);
    }

    /**
     * hincr hash递增 如果不存在,就会创建一个 并把新增后的值返回
     *
     * @param key  键
     * @param item 项
     * @param by   要增加几(大于0)
     * @return
     */
    public double hincr(String key, String item, double by) {
        return redisHashOperations.increment(key, item, by);
    }

    /**
     * hash递减
     *
     * @param key  键
     * @param item 项
     * @param by   要减少记(小于0)
     * @return
     */
    public double hdecr(String key, String item, double by) {
        return redisHashOperations.increment(key, item, -by);
    }

    //*******************************************set*******************************************//
    // Redis set是string类型的无序集合。
    // 集合是通过hashtable实现的，概念和数学中个的集合基本类似，可以交集，并集，差集等等
    // set中的元素是没有顺序的。所以添加，删除，查找的复杂度都是O(1)。

    /**
     * 根据key获取Set中的所有值
     *
     * @param key 键
     * @return
     */
    public Set<Object> sGet(String key) {
        try {
            return redisSetOperations.members(key);
        } catch (Exception e) {
            log.error("", e);
            return null;
        }
    }

    /**
     * 根据value从一个set中查询,是否存在
     *
     * @param key   键
     * @param value 值
     * @return true 存在 false不存在
     */
    public boolean sHasKey(String key, Object value) {
        try {
            return redisSetOperations.isMember(key, value);
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * 将数据放入set缓存
     *
     * @param key    键
     * @param values 值 可以是多个
     * @return 成功个数
     */
    public long sSet(String key, Object... values) {
        try {
            return redisSetOperations.add(key, values);
        } catch (Exception e) {
            log.error("", e);
            return 0;
        }
    }

    /**
     * 将set数据放入缓存
     *
     * @param key    键
     * @param time   时间(秒)
     * @param values 值 可以是多个
     * @return 成功个数
     */
    public long sSetAndTime(String key, long time, Object... values) {
        try {
            Long count = redisSetOperations.add(key, values);
            if (time > 0) {
                expire(key, time);
            }
            return count;
        } catch (Exception e) {
            log.error("", e);
            return 0;
        }
    }

    /**
     * 获取set缓存的长度
     *
     * @param key 键
     * @return
     */
    public long sGetSetSize(String key) {
        try {
            return redisSetOperations.size(key);
        } catch (Exception e) {
            log.error("", e);
            return 0;
        }
    }

    /**
     * 移除值为value的
     *
     * @param key    键
     * @param values 值 可以是多个
     * @return 移除的个数
     */
    public long setRemove(String key, Object... values) {
        try {
            Long count = redisSetOperations.remove(key, values);
            return count;
        } catch (Exception e) {
            log.error("", e);
            return 0;
        }
    }

    //*******************************************list*******************************************//
    // Redis list 列表是简单的字符串列表，按照插入顺序排序。你可以添加一个元素到列表的头部（左边）或者尾部（右边）。
    // 常用命令：lpush（添加左边元素）,rpush,lpop（移除左边第一个元素）,rpop,lrange（获取列表片段，LRANGE key start stop）等。
    // 应用场景：Redis list的应用场景非常多，也是Redis最重要的数据结构之一，比如twitter的关注列表，粉丝列表等都可以用Redis的list结构来实现。
    // List 就是链表，List的另一个应用就是消息队列，
    // 可以利用List的PUSH操作，将任务存在List中，然后工作线程再用POP操作将任务取出进行执行。
    // Redis还提供了操作List中某一段的api，你可以直接查询，删除List中某一段的元素。

    /**
     * 获取list缓存的内容
     *
     * @param key   键
     * @param start 开始
     * @param end   结束  0 到 -1代表所有值
     * @return
     */
    public List<Object> lGet(String key, long start, long end) {
        try {
            return redisListOperations.range(key, start, end);
        } catch (Exception e) {
            log.error("", e);
            return null;
        }
    }

    /**
     * 获取list缓存的所有内容
     *
     * @param key
     * @return
     */
    public List<Object> lGetAll(String key) {
        return lGet(key, 0, -1);
    }

    /**
     * 获取list缓存的长度
     *
     * @param key 键
     * @return
     */
    public long lGetListSize(String key) {
        try {
            return redisListOperations.size(key);
        } catch (Exception e) {
            log.error("", e);
            return 0;
        }
    }

    /**
     * 删除指定索引的值
     *
     * @param key 键
     * @return
     */
    public boolean lDelIndex(String key, long index) {
        try {
            redisListOperations.set(key, index, "delDel");
            redisListOperations.remove(key, 1, "delDel");
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * 左pop并删除此元素
     *
     * @param key 键
     * @return
     */
    public Object lRealLeftPop(String key) {
        try {
            Object o = redisListOperations.index(key, 0);
            lDelIndex(key, 0);
            return o;
        } catch (Exception e) {
            log.error("", e);
            return null;
        }
    }

    /**
     * 右pop并删除此元素
     *
     * @param key 键
     * @return
     */
    public Object lRealRightPop(String key) {
        try {
            Object o = redisListOperations.index(key, -1);
            lDelIndex(key, -1);
            return o;
        } catch (Exception e) {
            log.error("", e);
            return null;
        }
    }

    /**
     * 通过索引 获取list中的值
     *
     * @param key   键
     * @param index 索引  index>=0时， 0 表头，1 第二个元素，依次类推；index<0时，-1，表尾，-2倒数第二个元素，依次类推
     * @return
     */
    public Object lGetIndex(String key, long index) {
        try {
            return redisListOperations.index(key, index);
        } catch (Exception e) {
            log.error("", e);
            return null;
        }
    }

    /**
     * 将list放入缓存 左插
     *
     * @param key   键
     * @param value 值
     * @return
     */
    public boolean lLeftSet(String key, Object value) {
        try {
            redisListOperations.leftPush(key, value);
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * 将list放入缓存 右插
     *
     * @param key   键
     * @param value 值
     * @return
     */
    public boolean lRightSet(String key, Object value) {
        try {
            redisListOperations.rightPush(key, value);
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * 将list放入缓存 右插
     *
     * @param key   键
     * @param value 值
     * @param time  时间(秒)
     * @return
     */
    public boolean lRightSet(String key, Object value, long time) {
        try {
            redisListOperations.rightPush(key, value);
            if (time > 0) {
                expire(key, time);
            }
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * 将list放入缓存 右插
     *
     * @param key   键
     * @param value 值
     * @return
     */
    public boolean lRightSet(String key, List<Object> value) {
        try {
            redisListOperations.rightPushAll(key, value);
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * 将list放入缓存 右插
     *
     * @param key   键
     * @param value 值
     * @param time  时间(秒)
     * @return
     */
    public boolean lRightSet(String key, List<Object> value, long time) {
        try {
            redisListOperations.rightPushAll(key, value);
            if (time > 0) {
                expire(key, time);
            }
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * 删除集合中所有的元素，并返回集合第一个元素，从左往右
     *
     * @param key
     * @return
     */
    public Object lLeftPop(String key) {
        try {
            return redisListOperations.leftPop(key);
        } catch (Exception e) {
            log.error("", e);
            return null;
        }
    }

    /**
     * 根据索引修改list中的某条数据
     *
     * @param key   键
     * @param index 索引
     * @param value 值
     * @return
     */
    public boolean lUpdateIndex(String key, long index, Object value) {
        try {
            redisListOperations.set(key, index, value);
            return true;
        } catch (Exception e) {
            log.error("", e);
            return false;
        }
    }

    /**
     * 根据索引修改list中的某条数据
     *
     * @param sourceKey      源键
     * @param destinationKey 目标键
     * @return
     */
    public Object rightPopAndLeftPush(String sourceKey, String destinationKey) {
        try {
            return redisListOperations.rightPopAndLeftPush(sourceKey, destinationKey);
        } catch (Exception e) {
            log.error("", e);
            return null;
        }
    }

    /**
     * 移除N个值为value
     *
     * @param key   键
     * @param count 移除多少个
     * @param value 值
     * @return 移除的个数
     */
    public long lRemove(String key, long count, Object value) {
        try {
            Long remove = redisListOperations.remove(key, count, value);
            return remove;
        } catch (Exception e) {
            log.error("", e);
            return 0;
        }
    }
    //*******************************************zset *******************************************//
    // Redis zset 和 set 一样也是string类型元素的集合,且不允许重复的成员。
    // 常用命令：zadd,zrange,zrem,zcard等
}
