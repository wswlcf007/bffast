package com.lcf.fast.module.sys.controller;

import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.module.sys.service.SysOpenApiLogService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;


/**
 * 系统日志-开放接口三方调用记录
 *
 * @author lcf
 * @date 2020-10-30 17:31:52
 */
@RestController
@RequestMapping("sys/open/api/log")
@AllArgsConstructor
public class SysOpenApiLogController {
    private SysOpenApiLogService sysOpenApiLogService;

    /**
     * 列表-分页
     */
    @RequestMapping("/list/page")
    @RequiresPermissions("sys:open:api:log:list")
    public ResultDTO page(@RequestParam Map<String, Object> params) {
        PageUtils page = sysOpenApiLogService.queryPage(params);

        return ResultDTO.ok(page);
    }

}
