package com.lcf.fast.module.socket.server;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * web socket接口
 *
 * @author lcf
 * @date 2020-06-28 11:41
 */
@Slf4j
@ServerEndpoint("/ws/{userId}")
@Component
public class WebSocketServer {
    /**
     * 存放所有在线的客户端
     */
    private static Map<Long, Session> clients = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(@PathParam(value = "userId") Long userId, Session session) {
        //将新用户存入在线的组
        clients.put(userId, session);
        log.info("alarm client[{} - {}] connected, total[{}]", userId, session.getRequestURI().getHost(), clients.size());
    }

    /**
     * 客户端关闭
     *
     * @param session session
     */
    @OnClose
    public void onClose(@PathParam(value = "userId") Long userId, Session session) {
        //将掉线的用户移除在线的组里
        clients.remove(userId);
        log.info("alarm client[{} - {}] disconnected, total[{}]", userId, session.getRequestURI().getHost(), clients.size());
    }

    /**
     * 发生错误
     *
     * @param throwable e
     */
    @OnError
    public void onError(Throwable throwable) {
        throwable.printStackTrace();
    }

    /**
     * 收到客户端发来消息
     *
     * @param message 消息对象
     */
    @OnMessage
    public void onMessage(String message) {
        log.info("alarm websocket receive message: {}", message);
//        this.sendAll(message);
    }

    /**
     * 发送信息给指定ID用户，如果用户不在线则返回不在线信息给自己
     *
     * @param message
     * @param userId
     */
    public static void send2User(String message, Long userId) {
        Session session = clients.get(userId);
        if (session != null) {
            sendMessage(session, message);
            log.info("websocket send to userId[{}] - msg[{}]",userId, message);
        } else {
            log.error("当前用户[{}]不在线", userId);
        }
    }

    /**
     * 群发消息
     *
     * @param message 消息内容
     */
    public static void sendAll(String message) {
        for (Map.Entry<Long, Session> sessionEntry : clients.entrySet()) {
            sendMessage(sessionEntry.getValue(), message);
        }
    }

    /**
     * 发送消息
     *
     * @param session
     * @param message
     */
    private static void sendMessage(Session session, String message) {
        session.getAsyncRemote().sendText(message);
    }
}
