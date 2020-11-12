package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.sys.model.entity.SysUserTokenEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 系统用户Token
 *
 * @author lcf
 */
@Mapper
public interface SysUserTokenDao extends BaseMapper<SysUserTokenEntity> {

    SysUserTokenEntity queryByToken(String token);

}
