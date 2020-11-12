package com.lcf.fast.module.job.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.job.entity.ScheduleJobEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

/**
 * 定时任务
 *
 * @author lcf
 * @date 2020-06-22 14:06:08
 */
@Mapper
public interface ScheduleJobDao extends BaseMapper<ScheduleJobEntity> {

    /**
     * 批量更新状态
     */
    int updateBatch(Map<String, Object> map);
}
