package com.lcf.fast.module.job.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.job.dao.ScheduleJobLogDao;
import com.lcf.fast.module.job.entity.ScheduleJobLogEntity;
import com.lcf.fast.module.job.service.ScheduleJobLogService;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("scheduleJobLogService")
public class ScheduleJobLogServiceImpl extends ServiceImpl<ScheduleJobLogDao, ScheduleJobLogEntity> implements ScheduleJobLogService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");
        String size = (String) params.get("size");
        String jobId = (String) params.get("jobId");

        Page<ScheduleJobLogEntity> page = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));
        IPage<ScheduleJobLogEntity> iPage = baseMapper.selectPage(page,
                new QueryWrapper<ScheduleJobLogEntity>().like(StrUtil.isNotBlank(jobId), "job_id", jobId)
        );

        return new PageUtils(iPage);
    }

}
