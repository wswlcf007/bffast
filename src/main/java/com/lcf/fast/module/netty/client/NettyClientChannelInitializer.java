package com.lcf.fast.module.netty.client;

import com.lcf.fast.module.netty.client.handler.NettyClientHandler;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.socket.SocketChannel;
import io.netty.handler.codec.string.StringDecoder;
import io.netty.handler.codec.string.StringEncoder;
import io.netty.util.CharsetUtil;

/**
 * 客户端初始化
 *
 * @author lcf
 * @date 2020/4/9 13:30
 */
public class NettyClientChannelInitializer extends ChannelInitializer<SocketChannel> {
    @Override
    protected void initChannel(SocketChannel socketChannel) throws Exception {
        socketChannel.pipeline().addLast("decoder", new StringDecoder(CharsetUtil.UTF_8));
        socketChannel.pipeline().addLast("encoder", new StringEncoder(CharsetUtil.UTF_8));

        socketChannel.pipeline().addLast(new NettyClientHandler());
    }
}
