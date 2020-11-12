package com.lcf.fast.module.sys.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 用户锁定状态
 *
 * @author lcf
 * @date 2020-06-03 17:19
 */
@Getter
@Setter
public class SysUserLockDTO implements Serializable {
    private Long id;
    private String username;
    private String lockFlag;
}
