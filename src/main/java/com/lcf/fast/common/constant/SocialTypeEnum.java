package com.lcf.fast.common.constant;

/**
 * 社交账户 枚举
 *
 * @author lcf
 * @date 2018/8/15
 */
public enum SocialTypeEnum {
    /**
     * 管理员
     */
    WEI_XIN("weixin"),
    /**
     * 运营商
     */
    QQ("qq"),
    /**
     * 用户
     */
    WEI_BO("weibo"),
    /**
     * 手机号
     */
    Mobile("phone"),
    /**
     * 苹果用户
     */
    Apple("apple");


    private String value;

    SocialTypeEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
