package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 角色管理
 *
 * @author lcf
 */
@Mapper
public interface SysRoleDao extends BaseMapper<SysRoleEntity> {

    /**
     * 查询用户创建的角色ID列表
     */
    List<Long> queryRoleIdList(Long createUserId);
}
