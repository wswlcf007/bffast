package com.lcf.fast.common.constant;

/**
 * 客户端类型 枚举
 *
 * @author lcf
 * @date 2018/8/15
 */
public enum ClientTypeEnum {
    /**
     * 运管中心
     */
    ADMIN("admin"),
    /**
     * 数据中心
     */
    DATA("data"),
    /**
     * 移动端
     */
    APP("app");

    private String value;

    ClientTypeEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
