package com.lcf.fast.init;

import com.lcf.fast.common.constant.RedisKeyEnum;
import com.lcf.fast.module.netty.server.NettyServer;
import com.lcf.fast.module.redis.RedisService;
import lombok.AllArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * 启动netty
 *
 * @author lcf
 * @date 2020/4/9 14:38
 */
@Component
@Order(1)
@AllArgsConstructor
public class InitNettyCommandLineRunner implements CommandLineRunner {

    private NettyServer nettyServer;
    private RedisService redisService;


    /**
     * 当jvm关闭的时候，会执行系统中已经设置的所有通过方法addShutdownHook添加的钩子，当系统执行完这些钩子后，jvm才会关闭
     *
     * @param args
     * @throws Exception
     */
    @Override
    public void run(String... args) throws Exception {
        //移除相关redis key
        redisService.delKeysPattern(RedisKeyEnum.RT.getValue() + "*");
        nettyServer.start();
        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                nettyServer.destroy();
            }
        });

    }
}
