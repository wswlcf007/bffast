package com.lcf.fast.module.worker;

import org.jetbrains.annotations.NotNull;

import java.util.concurrent.ThreadFactory;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 描述: 线程工厂
 *
 * @author lcf
 * @date 2020-10-29 10:59
 */
public class ZWTreadFactory implements ThreadFactory {
    private final AtomicInteger mThreadNum = new AtomicInteger(1);

    @Override
    public Thread newThread(@NotNull Runnable r) {
        Thread t = new Thread(r, "send-thread-" + mThreadNum.getAndIncrement());
//        System.out.println(t.getName() + " has been created");
        return t;
    }
}
