package com.lcf.fast.module.sys.model.dto;

import lombok.Data;

/**
 * 登录表单 DTO
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@Data
public class SysLoginDTO {
    /**
     * 用户名
     */
    private String username;
    /**
     * 密码
     */
    private String password;
    /**
     * 验证码
     */
    private String captcha;
    /**
     * uuid
     */
    private String uuid;
    /**
     * 客户端
     */
    private String client;
}
