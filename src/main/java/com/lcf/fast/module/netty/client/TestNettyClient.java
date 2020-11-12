package com.lcf.fast.module.netty.client;

/**
 * netty 客户端测试
 *
 * @author lcf
 * @date 2020/4/9 13:33
 */
public class TestNettyClient {
    public static void main(String[] args) {

        //开启10条线程，每条线程就相当于一个客户端
        for (int i = 1; i <= 10; i++) {
            new Thread(new NettyClient("thread" + "--" + i)).start();
        }
    }
}
