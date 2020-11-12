package com.lcf.fast.module.job.controller;

import com.lcf.fast.common.annotation.SysLog;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.common.validator.ValidatorUtils;
import com.lcf.fast.module.job.entity.ScheduleJobEntity;
import com.lcf.fast.module.job.service.ScheduleJobService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 定时任务
 *
 * @author lcf
 * @date 2020-06-22 14:03:03
 */
@RestController
@RequestMapping("/sys/schedule")
@AllArgsConstructor
public class ScheduleJobController {
    private ScheduleJobService scheduleJobService;

    /**
     * 定时任务列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:schedule:list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        PageUtils page = scheduleJobService.queryPage(params);

        return ResultDTO.ok(page);
    }

    /**
     * 定时任务信息
     */
    @RequestMapping("/info/{jobId}")
    @RequiresPermissions("sys:schedule:info")
    public ResultDTO info(@PathVariable("jobId") Long jobId) {
        ScheduleJobEntity schedule = scheduleJobService.getById(jobId);

        return ResultDTO.ok(schedule);
    }

    /**
     * 保存定时任务
     */
    @SysLog("保存定时任务")
    @RequestMapping("/save")
    @RequiresPermissions("sys:schedule:save")
    public ResultDTO save(@RequestBody ScheduleJobEntity scheduleJob) {
        ValidatorUtils.validateEntity(scheduleJob);

        scheduleJobService.saveJob(scheduleJob);

        return ResultDTO.ok();
    }

    /**
     * 修改定时任务
     */
    @SysLog("修改定时任务")
    @RequestMapping("/update")
    @RequiresPermissions("sys:schedule:update")
    public ResultDTO update(@RequestBody ScheduleJobEntity scheduleJob) {
        ValidatorUtils.validateEntity(scheduleJob);

        scheduleJobService.update(scheduleJob);

        return ResultDTO.ok();
    }

    /**
     * 删除定时任务
     */
    @SysLog("删除定时任务")
    @RequestMapping("/delete")
    @RequiresPermissions("sys:schedule:delete")
    public ResultDTO delete(@RequestBody Long[] jobIds) {
        scheduleJobService.deleteBatch(jobIds);

        return ResultDTO.ok();
    }

    /**
     * 立即执行任务
     */
    @SysLog("立即执行任务")
    @RequestMapping("/run")
    @RequiresPermissions("sys:schedule:run")
    public ResultDTO run(@RequestBody Long[] jobIds) {
        scheduleJobService.run(jobIds);

        return ResultDTO.ok();
    }

    /**
     * 暂停定时任务
     */
    @SysLog("暂停定时任务")
    @RequestMapping("/pause")
    @RequiresPermissions("sys:schedule:pause")
    public ResultDTO pause(@RequestBody Long[] jobIds) {
        scheduleJobService.pause(jobIds);

        return ResultDTO.ok();
    }

    /**
     * 恢复定时任务
     */
    @SysLog("恢复定时任务")
    @RequestMapping("/resume")
    @RequiresPermissions("sys:schedule:resume")
    public ResultDTO resume(@RequestBody Long[] jobIds) {
        scheduleJobService.resume(jobIds);

        return ResultDTO.ok();
    }

}
