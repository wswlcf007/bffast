package com.lcf.fast.common.constant;

/**
 * 控制指令 常量
 *
 * @author lcf
 * @date 2020/4/117:13
 */
public enum CMDEnum {
    /**
     * 发送指令
     */
    Send_Test("send-test"),
    /**
     * 开关指令
     */
    OC_Test("oc-test");
    private String value;

    CMDEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}