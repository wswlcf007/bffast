package com.lcf.fast.module.sys.model.dto;

import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import lombok.Data;

import java.io.Serializable;

/**
 * 用户信息
 *
 * @author lcf
 * @date 2019/2/1
 */
@Data
public class UserInfoDTO implements Serializable {
    /**
     * 用户基本信息
     */
    private SysUserEntity sysUser;
    /**
     * 权限标识集合
     */
    private String[] permissions;

}
