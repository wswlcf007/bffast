package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.sys.model.entity.SysOpenApiLogEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 系统日志-开放接口三方调用记录
 *
 * @author lcf
 * @date 2020-08-14 11:25:54
 */
@Mapper
public interface SysOpenApiLogDao extends BaseMapper<SysOpenApiLogEntity> {

}
