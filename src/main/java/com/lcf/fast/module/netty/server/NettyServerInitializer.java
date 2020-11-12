package com.lcf.fast.module.netty.server;

import com.lcf.fast.module.netty.server.handler.ServerChannelHandler;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.socket.SocketChannel;
import io.netty.handler.codec.LengthFieldBasedFrameDecoder;
import io.netty.handler.timeout.IdleStateHandler;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

/**
 * 服务端初始化
 * 客户端与服务器端连接一旦创建，这个类中方法就会被回调，设置出站编码器和入站解码器
 *
 * @author lcf
 * @date 2020/4/9 13:19
 */
@Component
public class NettyServerInitializer extends ChannelInitializer<SocketChannel> {
    @Value("${netty.idle.reader}")
    private Long readerIdle; //读超时
    @Value("${netty.idle.writer}")
    private Long writerIdle; //写超时
    @Value("${netty.idle.all}")
    private Long allIdle; //总超时
    @Value("${netty.port}")
    private int port; //端口

    @Override
    protected void initChannel(SocketChannel socketChannel) throws Exception {
        socketChannel.pipeline().addLast(new IdleStateHandler(readerIdle, writerIdle, allIdle, TimeUnit.SECONDS));
        // lengthAdjustment = totalLen - dataLen - lengthFieldOffset - lengthFieldLength
        // 0103020021785C  7-2-2-1
//            socketChannel.pipeline().addLast("modBusFrameDecoder", new LengthFieldBasedFrameDecoder(1024, 2, 1, 2, 0));
        int localPort = socketChannel.localAddress().getPort();
        if (localPort == port) {
            //添加自己需要的decoder handler
            // lengthAdjustment = totalLen - dataLen - lengthFieldOffset - lengthFieldLength
            // 如 113 - 105 - 1 - 4 = 3
            socketChannel.pipeline().addLast("frameDecoder", new LengthFieldBasedFrameDecoder(1024, 1, 4, 2, 0));
            socketChannel.pipeline().addLast(new ServerChannelHandler());
        }
    }
}