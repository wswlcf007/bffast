package com.lcf.fast.module.sys.controller;

import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import org.apache.shiro.SecurityUtils;

/**
 * Controller公共组件
 *
 * @author lcf
 * @date 2019/11/12 9:46:34
 */
public abstract class BaseController {
    protected SysUserEntity getUser() {
        return (SysUserEntity) SecurityUtils.getSubject().getPrincipal();
    }

    protected Long getUserId() {
        return getUser().getUserId();
    }
}
