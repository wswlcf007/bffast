package com.lcf.fast.common.constant;

/**
 * redis常用Key常量
 *
 * @author lcf
 * @date 2020/4/117:13
 */
public enum RedisKeyEnum {
    /**
     * 验证码 - cmd list
     */
    Captcha_Code("code:"),
    /**
     * 实时数据
     */
    RT("rt:");


    private String value;

    RedisKeyEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
