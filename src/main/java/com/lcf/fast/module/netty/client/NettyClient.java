package com.lcf.fast.module.netty.client;

import cn.hutool.core.date.DateUtil;
import io.netty.bootstrap.Bootstrap;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioSocketChannel;
import lombok.extern.slf4j.Slf4j;

/**
 * netty 客户端
 *
 * @author lcf
 * @date 2020/4/9 13:25
 */
@Slf4j
public class NettyClient implements Runnable {
    static final String HOST = "127.0.0.1";
    static final int PORT = 8080;
    static final int SIZE = 256;
    private String content;

    public NettyClient(String content) {
        this.content = content;
    }

    @Override
    public void run() {
        // Configure the client.
        EventLoopGroup group = new NioEventLoopGroup();
        try {
            int num = 0;
            boolean result = true;
            Bootstrap b = new Bootstrap();
            b.group(group).handler(new NettyClientChannelInitializer())
                    .channel(NioSocketChannel.class)
                    .option(ChannelOption.TCP_NODELAY, true);
            ChannelFuture future = b.connect(HOST, PORT).sync();
            while (result) {
                num++;
                future.channel().writeAndFlush(content + "--" + DateUtil.now());
                try { //休眠一段时间
                    Thread.sleep(3000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                //每一条线程向服务端发送的次数
                if (num == 100) {
                    result = false;
                }
            }
            log.info(content + "-----------------------------" + num);
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            group.shutdownGracefully();
        }
    }
}
