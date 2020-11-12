package com.lcf.fast.common.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

/**
 * 异步任务线程池配置类
 *
 * @author lcf
 * @date 2020/4/20 14:41
 */

@Configuration("threadPoolConfig")
@Getter
@Setter
public class BFThreadPoolConfig {
    /**
     * 核心线程数
     */
    @Value("${zw.pool.corePoolSize}")
    private int corePoolSize;
    /**
     * 最大线程数
     */
    @Value("${zw.pool.maxPoolSize}")
    private int maxPoolSize;
    /**
     * 线程活跃时间（秒）
     */
    @Value("${zw.pool.keepAliveSeconds}")
    private int keepAliveSeconds;
    /**
     * 队列容量
     */
    @Value("${zw.pool.queueCapacity}")
    private int queueCapacity;

}
