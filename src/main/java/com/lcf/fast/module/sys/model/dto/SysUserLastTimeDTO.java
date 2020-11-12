package com.lcf.fast.module.sys.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 用户上次登录时间
 *
 * @author lcf
 * @date 2020-06-03 17:19
 */
@Getter
@Setter
public class SysUserLastTimeDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private String username;
    private Long lastTime;
}
