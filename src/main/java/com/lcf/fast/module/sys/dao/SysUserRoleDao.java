package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;
import com.lcf.fast.module.sys.model.entity.SysUserRoleEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 用户与角色对应关系
 *
 * @author lcf
 */
@Mapper
public interface SysUserRoleDao extends BaseMapper<SysUserRoleEntity> {

    /**
     * 根据用户ID，获取角色ID列表
     */
    List<Integer> queryRoleIdList(Long userId);

    /**
     * 根据用户ID，获取单个角色
     */
    SysRoleEntity queryRole(Long userId);


    /**
     * 根据角色ID数组，批量删除
     */
    int deleteBatch(Long[] roleIds);

    Boolean deleteByUserId(Long userId);
}
