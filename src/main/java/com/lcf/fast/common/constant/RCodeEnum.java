package com.lcf.fast.common.constant;

import lombok.Getter;

/**
 * 通用返回码
 *
 * @author lcf
 * @date 2020/4/7 15:04
 */
@Getter
public enum RCodeEnum {
    /**
     * 默认成功为0
     */
    Success_Code(0),
    /**
     * 授权未通过
     */
    Unauthorized(401),
    /**
     * 没有权限
     */
    Permission_Denied(403),
    /**
     * 路径不存在
     */
    Path_Not_Found(404),
    /**
     * 系统异常
     */
    Error(1001),
    /**
     * 请求方法不支持
     */
    Method_Not_Supported(1002),
    /**
     * 查询数据不存在
     */
    Data_Not_Exist(1003),
    /**
     * 保存记录重复
     */
    Data_Duplicate_Key(1004),
    /**
     * 文件操作失败
     */
    File_Error(1010),
    /**
     * 三方开放接口服务异常
     */
    Open_Error(8001),
    /**
     * 三方开放接口鉴权失败
     */
    Open_Auth_Failed(8002),
    /**
     * 三方开放接口参数有误
     */
    Open_Parameter_Failed(8003);

    private int code;

    RCodeEnum(int code) {
        this.code = code;
    }
}
