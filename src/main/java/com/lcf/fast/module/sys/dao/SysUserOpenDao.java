package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.sys.model.entity.SysUserOpenEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 三方接口开放用户表
 *
 * @author lcf
 * @date 2020-08-14 11:25:54
 */
@Mapper
public interface SysUserOpenDao extends BaseMapper<SysUserOpenEntity> {

}
