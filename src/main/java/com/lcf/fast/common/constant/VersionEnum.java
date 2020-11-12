package com.lcf.fast.common.constant;

/**
 * 版本枚举
 *
 * @author lcf
 * @date 2020/5/8 13:20
 */
public enum VersionEnum {
    /**
     * 测试版本
     */
    Version_Test("test"),
    /**
     * 发行版本
     */
    Version_Release("release"),
    /**
     * 未发行版
     */
    Version_No_Release("noRelease");


    private String value;

    VersionEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
