package com.lcf.fast.module.netty.server;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.*;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * netty 服务端
 * 1.创建一个ServerBootstrap的实例引导和绑定服务器。
 * 2.创建并分配一个NioEventLoopGroup实例以进行事件的处理，比如接受连接以及读写数据。
 * 3.指定服务器绑定的本地的InetSocketAddress。
 *
 * @author lcf
 * @date 2020/4/9 13:16
 */
@Slf4j
@Component
public class NettyServer {
    @Value("${netty.port}")
    private int port; //启动端口

    private NettyServerInitializer nettyServerInitializer;

    public NettyServer(NettyServerInitializer nettyServerInitializer) {
        this.nettyServerInitializer = nettyServerInitializer;
    }

    /**
     * NioEventLoop并不是一个纯粹的I/O线程，它除了负责I/O的读写之外
     * 创建了两个NioEventLoopGroup，
     * 它们实际是两个独立的Reactor线程池。
     * 一个用于接收客户端的TCP连接，
     * 另一个用于处理I/O相关的读写操作，或者执行系统Task、定时任务Task等。
     */
    private final EventLoopGroup bossGroup = new NioEventLoopGroup(1);
    private final EventLoopGroup workerGroup = new NioEventLoopGroup(4);
    //    private final EventLoopGroup bossGroup = new NioEventLoopGroup(2, new DefaultThreadFactory("server1", true));
//    private final EventLoopGroup workerGroup = new NioEventLoopGroup(4, new DefaultThreadFactory("server2", true));
    private Channel channel;


    public void start() {
        try {
            ServerBootstrap bootstrap = new ServerBootstrap()
                    .group(bossGroup, workerGroup)  // 绑定线程池
                    .channel(NioServerSocketChannel.class)
                    .childHandler(nettyServerInitializer)
                    .option(ChannelOption.SO_BACKLOG, 1024)   //服务端接受连接的队列长度，如果队列已满，客户端连接将被拒绝
                    .option(ChannelOption.SO_RCVBUF, 1024 * 256) //接收缓冲区
//                    .option(ChannelOption.SO_SNDBUF, 1024*256) //发送缓冲区
//                    .option(ChannelOption.ALLOCATOR, PooledByteBufAllocator.DEFAULT)
//                    .childOption(ChannelOption.ALLOCATOR, PooledByteBufAllocator.DEFAULT)
                    .childOption(ChannelOption.SO_KEEPALIVE, true) //保持长连接，2小时无数据激活心跳机制
                    .childOption(ChannelOption.TCP_NODELAY, true); //是否开启Nagle算法，true表示关闭，false表示开启
            // 如果要求高实时性，有数据发送时就马上发送，就关闭，如果需要减少发送次数减少网络交互，就开启

            //绑定485端口
            ChannelFuture future485 = bootstrap.bind(port).sync();
            log.info("netty server started on port[{}]", port);
            channel = future485.channel();
            channel.closeFuture().addListener((ChannelFutureListener) future1 -> {
                future1.channel().close();
            });
            //关闭channel和块，直到它被关闭
            //channel.closeFuture().sync();
        } catch (Exception e) {
            e.printStackTrace();
            log.info("netty server started fail on port[{}] - 异常[{}]", port, e.getCause());
            bossGroup.shutdownGracefully();
            workerGroup.shutdownGracefully();
        }
    }

    /**
     * 停止服务
     */
    public void destroy() {
        if (channel != null) {
            channel.close();
        }
        workerGroup.shutdownGracefully();
        bossGroup.shutdownGracefully();
        log.info("shutdown netty server success!");
    }
}
