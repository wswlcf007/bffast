package com.lcf.fast.module.sys.controller;

import com.lcf.fast.module.sys.service.SysLogService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.common.model.ResultDTO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;


/**
 * 系统日志
 *
 * @author lcf
 * @date 2019/11/12 9:46:46
 */
@RestController
@RequestMapping("/sys/log")
public class SysLogController {
    @Autowired
    private SysLogService sysLogService;

    /**
     * 列表
     */
    @GetMapping("/list")
    @RequiresPermissions("sys:log:list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        PageUtils page = sysLogService.queryPage(params);
        return ResultDTO.ok(page);
    }

}
