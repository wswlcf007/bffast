package com.lcf.fast.module.netty.server.codec;

import com.lcf.fast.module.netty.util.ModBusUtils;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.ByteBufUtil;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.ByteToMessageDecoder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
 * ModBus解析
 *
 * @author lcf
 * @date 2020-05-12 15:25
 */
@Slf4j
@AllArgsConstructor
public class ModBusProtocolDecoder extends ByteToMessageDecoder {
    @Override
    protected void decode(ChannelHandlerContext channelHandlerContext, ByteBuf byteBuf, List<Object> list) throws Exception {
        int len = byteBuf.readableBytes();
        byte[] bytes = new byte[len];
        byteBuf.readBytes(bytes);
        //判断是否拆包
        if (!ModBusUtils.check(bytes)) {
            //校验失败
            log.info("check 485 failure - 报文[{}]", ByteBufUtil.hexDump(bytes));
            byteBuf.skipBytes(byteBuf.readableBytes());
            byteBuf.discardReadBytes();
        } else {
            list.add(bytes);
        }
    }
}
