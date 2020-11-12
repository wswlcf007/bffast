package com.lcf.fast.module.sys.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 手机号登录 DTO
 *
 * @author lcf
 * @date 2020/7/20 15:23
 */
@Getter
@Setter
public class SysLoginMobileDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private String mobile;
    private String appKey;
    private String zone;
    private String smsCode;
}
