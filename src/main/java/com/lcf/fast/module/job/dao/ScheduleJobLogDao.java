package com.lcf.fast.module.job.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.job.entity.ScheduleJobLogEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 定时任务日志
 *
 * @author lcf
 * @date 2020-06-22 14:06:08
 */
@Mapper
public interface ScheduleJobLogDao extends BaseMapper<ScheduleJobLogEntity> {

}
