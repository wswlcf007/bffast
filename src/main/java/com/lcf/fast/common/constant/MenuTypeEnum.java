package com.lcf.fast.common.constant;

/**
 * 菜单类型枚举
 *
 * @author lcf
 * @date 2020/4/7 15:01
 */
public enum MenuTypeEnum {
    /**
     * 目录
     */
    CATALOG("0"),
    /**
     * 菜单
     */
    MENU("1"),
    /**
     * 按钮
     */
    BUTTON("2"),
    /**
     * 系统菜单
     */
    SYS("1");

    private String value;

    MenuTypeEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
