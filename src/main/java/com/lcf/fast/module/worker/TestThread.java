package com.lcf.fast.module.worker;

/**
 * 测试线程
 *
 * @author lcf
 * @date 2020-10-29 10:44
 */
public class TestThread implements Runnable {

    @Override
    public void run() {
        System.out.println("hello");
    }
}
