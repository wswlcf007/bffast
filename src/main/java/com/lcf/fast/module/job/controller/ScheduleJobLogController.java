package com.lcf.fast.module.job.controller;

import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.job.entity.ScheduleJobLogEntity;
import com.lcf.fast.module.job.service.ScheduleJobLogService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 定时任务日志
 *
 * @author lcf
 * @date 2020-06-22 14:03:03
 */
@RestController
@RequestMapping("/sys/scheduleLog")
@AllArgsConstructor
public class ScheduleJobLogController {
    private ScheduleJobLogService scheduleJobLogService;

    /**
     * 定时任务日志列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:schedule:log")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        PageUtils page = scheduleJobLogService.queryPage(params);
        return ResultDTO.ok(page);
    }

    /**
     * 定时任务日志信息
     */
    @RequestMapping("/info/{logId}")
    public ResultDTO info(@PathVariable("logId") Long logId) {
        ScheduleJobLogEntity log = scheduleJobLogService.getById(logId);

        return ResultDTO.ok(log);
    }
}
