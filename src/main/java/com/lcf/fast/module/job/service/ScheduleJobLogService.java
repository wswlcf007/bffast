package com.lcf.fast.module.job.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.job.entity.ScheduleJobLogEntity;

import java.util.Map;

/**
 * 定时任务日志
 *
 * @author lcf
 * @date 2020-06-22 14:06:08
 */
public interface ScheduleJobLogService extends IService<ScheduleJobLogEntity> {

    PageUtils queryPage(Map<String, Object> params);

}
