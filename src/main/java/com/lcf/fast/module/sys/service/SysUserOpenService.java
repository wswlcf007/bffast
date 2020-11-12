package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.entity.SysUserOpenEntity;

import java.util.Map;
import java.util.List;

/**
 * 三方接口开放用户表
 *
 * @author lcf
 * @date 2020-08-14 11:25:54
 */
public interface SysUserOpenService extends IService<SysUserOpenEntity> {

    /**
     * 自定义分页查询
     *
     * @param params
     * @return
     */
    PageUtils queryPage(Map<String, Object> params);

    /**
     * 自定义列表
     *
     * @param params
     * @return
     */
    List<SysUserOpenEntity> queryList(Map<String, Object> params);

    /**
     * 单条查询
     *
     * @param id
     * @return
     */
    SysUserOpenEntity getOneById(Long id);

    /**
     * 自定义保存
     *
     * @param entity
     */
    void saveSysUserOpen(SysUserOpenEntity entity);

    /**
     * 自定义修改
     *
     * @param entity
     */
    void updateSysUserOpen(SysUserOpenEntity entity);

    /**
     * 自定义删除
     *
     * @param ids
     */
    void removeSysUserOpen(Long[] ids);
}

