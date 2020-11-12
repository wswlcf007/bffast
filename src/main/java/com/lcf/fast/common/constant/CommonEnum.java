package com.lcf.fast.common.constant;

import lombok.Getter;

/**
 * 系统通用常量
 *
 * @author lcf
 * @date 2019/11/8 15:23:45
 */
@Getter
public enum CommonEnum {
    /**
     * 超级管理员ID
     */
    Super_Admin("admin"),
    /**
     * 重置密码
     */
    Reset_Password("000000"),
    /**
     * 重置密码(000000加密后)
     */
    Reset_Password_default("PA7YymvcZsXQ+0+zNbxwOQ=="),
    /**
     * 默认成功msg为success
     */
    Success_Msg("success"),
    /**
     * 当前页码
     */
    Page("page"),
    /**
     * 每页显示记录数
     */
    Limit("limit"),
    /**
     * 排序字段
     */
    Order_Field("sidx"),
    /**
     * 排序方式
     */
    Order("order"),
    /**
     * 升序
     */
    Asc("asc"),
    /**
     * 账号锁定状态
     */
    Lock_Status("9"),
    /**
     * jasypt私钥
     */
    Jasypt_Encryptor_Password("lcf"),
    /**
     * security encode key 16字符
     */
    Security_Encode_Key("bffast&123456789"),
    /**
     * Open_Api_Basic
     */
    Open_Api_Basic("basic="),
    /**
     * Open_Api_Sign
     */
    Open_Api_Sign("&amp;sign="),
    /**
     * Open_Api_Service_Err_Msg
     */
    Open_Api_Service_Err_Msg("service unavailable"),
    /**
     * Open_Api_Param_Err_Msg
     */
    Open_Api_Param_Err_Msg("invalid params"),
    /**
     * Open_Api_Default_Sign
     */
    Open_Api_Default_Sign("0155FB5B3C1D28EE3D1DC1A52B9ECE1C");

    private String value;

    CommonEnum(String value) {
        this.value = value;
    }

}
