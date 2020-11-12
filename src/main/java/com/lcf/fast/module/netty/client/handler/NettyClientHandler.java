package com.lcf.fast.module.netty.client.handler;

import cn.hutool.core.date.DateUtil;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelId;
import io.netty.channel.ChannelInboundHandlerAdapter;
import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.ConcurrentHashMap;

/**
 * 客户端处理类
 *
 * @author lcf
 * @date 2020/4/9 13:31
 */
@Slf4j
public class NettyClientHandler extends ChannelInboundHandlerAdapter {
    /**
     * 计算有多少客户端接入，第一个string为客户端ip
     */
    private static final ConcurrentHashMap<ChannelId, ChannelHandlerContext> CLIENT_MAP = new ConcurrentHashMap<>();

    @Override
    public void channelActive(ChannelHandlerContext ctx) {
        CLIENT_MAP.put(ctx.channel().id(), ctx);
        log.info("ClientHandler Active");
    }

    /**
     * 有服务端端终止连接服务器会触发此函数
     *
     * @param ctx
     * @return: void
     */
    @Override
    public void channelInactive(ChannelHandlerContext ctx) {
        ctx.close();
        log.info("服务端终止了服务");
    }

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) {
        log.info("回写数据:" + msg);
    }


    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
        //cause.printStackTrace();
        log.info("服务端发生异常【" + cause.getMessage() + "】");
        ctx.close();
    }

    /**
     * 客户端给服务端发送消息
     *
     * @param msg       需要发送的消息内容
     * @param channelId 连接通道唯一id
     * @return: void
     */
    public void channelWrite(ChannelId channelId, String msg) {
        ChannelHandlerContext ctx = CLIENT_MAP.get(channelId);
        if (ctx == null) {
            log.info("通道【" + channelId + "】不存在");
            return;
        }
        //将客户端的信息直接返回写入ctx
        ctx.write(msg + " 时间：" + DateUtil.now());
        //刷新缓存区
        ctx.flush();
    }
}
