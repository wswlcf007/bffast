package com.lcf.fast.common.constant;

/**
 * 角色类型 枚举
 *
 * @author lcf
 * @date 2018/8/15
 */
public enum RoleTypeEnum {
    /**
     * 管理员
     */
    ADMIN("admin"),
    /**
     * 手机用户
     */
    PHONE_USER("phone_user"),
    /**
     * 第三方用户
     */
    SOCIAL_USER("social_user");

    private String value;

    RoleTypeEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
