package com.lcf.fast.module.netty.server.handler;

import com.lcf.fast.module.netty.util.ModBusUtils;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.ByteBufUtil;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelFutureListener;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.handler.timeout.IdleState;
import io.netty.handler.timeout.IdleStateEvent;
import io.netty.util.ReferenceCountUtil;
import lombok.extern.slf4j.Slf4j;

import java.net.InetSocketAddress;
import java.util.concurrent.ConcurrentHashMap;

/**
 * netty服务端处理类 - 485协议
 *
 * @author lcf
 * @date 2020/4/9 13:21
 */
@Slf4j
public class ServerChannelHandler extends ChannelInboundHandlerAdapter {
    /**
     * 管理一个全局map，保存连接进服务端的通道数量
     */
    public static final ConcurrentHashMap<String, ChannelHandlerContext> CHANNEL_MAP = new ConcurrentHashMap<>();
    /**
     * 记录当前发出的内容
     */
    private static final ConcurrentHashMap<String, String> CHANNEL_LAST_CMD_MAP = new ConcurrentHashMap<>();

    /**
     * 客户端连接
     *
     * @param ctx
     */
    @Override
    public void channelActive(ChannelHandlerContext ctx) {
        InetSocketAddress inetSocketAddress = (InetSocketAddress) ctx.channel().remoteAddress();
        String clientIp = inetSocketAddress.getAddress().getHostAddress();
        int clientPort = inetSocketAddress.getPort();
        //获取连接通道唯一标识
        String channelId = ctx.channel().id().toString();
        //如果map中不包含此连接，就保存连接
        if (!CHANNEL_MAP.containsKey(channelId)) {
            //保存连接
            CHANNEL_MAP.put(channelId, ctx);
            log.info("channel[{}-{}:{}]connected - total[{}]", channelId, clientIp, clientPort, CHANNEL_MAP.size());
        }
    }

    /**
     * 有客户端终止连接服务器会触发此函数
     *
     * @param ctx channel上下文
     */
    @Override
    public void channelInactive(ChannelHandlerContext ctx) {
        InetSocketAddress inetSocketAddress = (InetSocketAddress) ctx.channel().remoteAddress();
        String channelId = ctx.channel().id().toString();
        //包含此客户端才去删除
        if (CHANNEL_MAP.containsKey(channelId)) {
            //删除连接
            remove(channelId);
            log.info("channel[{}-{}:{}]disconnected - total[{}]", channelId, inetSocketAddress.getAddress().getHostAddress(), inetSocketAddress.getPort(), CHANNEL_MAP.size());
        }
    }


    /**
     * 数据处理器
     *
     * @param ctx
     * @param msg
     */
    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) {
        byte[] readBytes = (byte[]) msg;
        String channelId = ctx.channel().id().toString();
        String lastCmd = CHANNEL_LAST_CMD_MAP.get(channelId);
        log.info("readBytes[{}]", ByteBufUtil.hexDump(readBytes));
        ReferenceCountUtil.release(msg);
        ctx.flush();
    }

    /**
     * 从客户端收到新的数据、读取完成时调用
     *
     * @param ctx
     * @throws Exception
     */
    @Override
    public void channelReadComplete(ChannelHandlerContext ctx) throws Exception {
        ctx.flush();
//        ctx.writeAndFlush(Unpooled.EMPTY_BUFFER).addListener(ChannelFutureListener.CLOSE);
    }

    /**
     * 服务端给客户端发送消息
     *
     * @param data   需要发送的消息内容
     * @param ctx    channel上下文
     * @param isTask 是否缓存任务
     * @return: void
     */
    public void channelWrite(ChannelHandlerContext ctx, byte[] data, boolean isTask) {
        String channelId = ctx.channel().id().toString();
        InetSocketAddress socketAddress = (InetSocketAddress) ctx.channel().remoteAddress();
        String clientIp = socketAddress.getAddress().getHostAddress();
        int clientPort = socketAddress.getPort();
        //非池化8个字节大小ByteBuf
        ByteBuf sendBuf = Unpooled.buffer(8);
        sendBuf.writeBytes(data);
        ChannelFuture channelFuture = ctx.writeAndFlush(sendBuf);
        channelFuture.addListener(ChannelFutureListener.FIRE_EXCEPTION_ON_FAILURE)
                .addListener(future -> {
                    log.info("write success - channel[{}-{}:{}] - 报文[{}]", channelId, clientIp, clientPort, ModBusUtils.bytesToHexString(data));
                });
    }

    @Override
    public void userEventTriggered(ChannelHandlerContext ctx, Object evt) throws Exception {
        String channelId = ctx.channel().id().toString();
        InetSocketAddress inetSocketAddress = (InetSocketAddress) ctx.channel().remoteAddress();
        String clientIp = inetSocketAddress.getAddress().getHostAddress();
        int clientPort = inetSocketAddress.getPort();
        if (evt instanceof IdleStateEvent) {
            IdleStateEvent event = (IdleStateEvent) evt;
            if (event.state() == IdleState.READER_IDLE) {
                log.error("channel[{}:{}] - 读超时(READER_IDLE) - 连接关闭", clientIp, clientPort);
                //长时间读不到 则删除
                remove(channelId);
                ctx.channel().disconnect();
                ctx.channel().close();
                ctx.close();
            } else if (event.state() == IdleState.WRITER_IDLE) {
                //写超时，尝试从loop task中下发一条
                log.error("channel[{}:{}] - 写超时(WRITER_IDLE)", clientIp, clientPort);
            } else if (event.state() == IdleState.ALL_IDLE) {
                log.error("channel[{}:{}] - 总超时(ALL_IDLE) - 连接关闭", clientIp, clientPort);
                remove(channelId);
                //关闭调度任务
//                ctx.channel().eventLoop().shutdownGracefully();
                ctx.channel().disconnect();
                ctx.channel().close();
                ctx.close();
            }
        }
    }

    /**
     * channel关闭 移除相关存储
     *
     * @param channelId
     */
    private void remove(String channelId) {
        //移除静态组
        CHANNEL_MAP.remove(channelId);
        CHANNEL_LAST_CMD_MAP.remove(channelId);
    }

    /**
     * 发生异常会触发此函数
     *
     * @param ctx
     * @return: void
     */
    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        InetSocketAddress inetSocketAddress = (InetSocketAddress) ctx.channel().remoteAddress();
        String channelId = ctx.channel().id().toString();
        String clientIp = inetSocketAddress.getAddress().getHostAddress();
        int clientPort = inetSocketAddress.getPort();
        //移除静态组
        remove(channelId);
        //关闭调度任务
//        ctx.channel().eventLoop().shutdownGracefully();
        log.error("channel[{}:{}]发生异常 - 连接关闭[{}]", clientIp, clientPort, cause.getMessage());
        ctx.channel().disconnect();
        ctx.channel().close();
        ctx.close();
    }

}
