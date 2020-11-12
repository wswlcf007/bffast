package com.lcf.fast.module.sys.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.sys.model.entity.SysLogEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 系统日志
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@Mapper
public interface SysLogDao extends BaseMapper<SysLogEntity> {

}
