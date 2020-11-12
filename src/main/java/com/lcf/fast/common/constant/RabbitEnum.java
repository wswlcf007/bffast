package com.lcf.fast.common.constant;

import lombok.Getter;

/**
 * rabbit 枚举类
 *
 * @author lcf
 * @date 2020/4/30 14:13
 */
@Getter
public enum RabbitEnum {
    /**
     * 交换机1
     */
    Exchange_1("exchange_1"),
    /**
     * 队列1
     */
    Queue_1("queue_1"),
    /**
     * 队列2
     */
    Queue_2("queue_2"),

    /**
     * routing key 1
     */
    Routing_Key_1("routing_key_1"),
    /**
     * routing key 2
     */
    Routing_Key_2("routing_key_2");

    private String value;

    RabbitEnum(String value) {
        this.value = value;
    }
}
