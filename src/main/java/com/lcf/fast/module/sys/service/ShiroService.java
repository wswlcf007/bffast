package com.lcf.fast.module.sys.service;


import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.model.entity.SysUserTokenEntity;

import java.util.Set;

/**
 * shiro相关接口
 *
 * @author lcf
 * @date 2020/4/7 15:45
 */
public interface ShiroService {
    /**
     * 获取用户权限列表
     */
    Set<String> getUserPermissions(long userId);

    SysUserTokenEntity queryByToken(String token);

    /**
     * 根据用户ID，查询用户
     *
     * @param userId
     */
    SysUserEntity queryUser(Long userId);
}
