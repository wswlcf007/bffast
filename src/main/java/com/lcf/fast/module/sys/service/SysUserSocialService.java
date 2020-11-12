package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.entity.SysUserSocialEntity;

import java.util.List;
import java.util.Map;

/**
 * 社交账户表
 *
 * @author nyn
 * @email @
 * @date 2019-09-20 09:43:52
 */
public interface SysUserSocialService extends IService<SysUserSocialEntity> {

    //分页查询列表
    PageUtils queryPage(Map<String, Object> params);

    //不分页查询列表
    List<SysUserSocialEntity> queryList(Map<String, Object> params);

}

