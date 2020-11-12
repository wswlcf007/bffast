package com.lcf.fast.module.sys.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 三方登录 DTO
 *
 * @author lcf
 * @date 2020/7/20 15:23
 */
@Getter
@Setter
public class SysLoginSocialDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private String openId;
    private String providerId;
    private String accessToken;
    private String refreshToken;
    private String expireTime;
}
