package com.lcf.fast.module.sys.controller;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;
import lombok.AllArgsConstructor;

import com.lcf.fast.module.sys.model.entity.SysUserOpenEntity;
import com.lcf.fast.module.sys.service.SysUserOpenService;
import com.lcf.fast.common.annotation.SysLog;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.common.model.ResultDTO;



/**
 * 三方接口开放用户表
 *
 * @author lcf
 * @date 2020-10-30 17:31:52
 */
@RestController
@RequestMapping("sys/user/open")
@AllArgsConstructor
public class SysUserOpenController {
    private SysUserOpenService sysUserOpenService;

    /**
     * 列表-分页
     */
    @RequestMapping("/list/page")
    @RequiresPermissions("sys:user:open:list")
    public ResultDTO page(@RequestParam Map<String, Object> params){
        PageUtils page = sysUserOpenService.queryPage(params);

        return ResultDTO.ok(page);
    }

    /**
     * 列表-不分页
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:user:open:list")
    public ResultDTO list(@RequestParam Map<String, Object> params){
        List<SysUserOpenEntity> list = sysUserOpenService.queryList(params);

        return ResultDTO.ok(list);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    @RequiresPermissions("sys:user:open:info")
    public ResultDTO info(@PathVariable("id") Long id){
        SysUserOpenEntity sysUserOpen = sysUserOpenService.getOneById(id);

        return ResultDTO.ok(sysUserOpen);
    }

    /**
     * 保存
     */
    @SysLog("新增三方开放用户")
    @PostMapping("/save")
    @RequiresPermissions("sys:user:open:save")
    public ResultDTO save(@RequestBody SysUserOpenEntity sysUserOpen){
        sysUserOpenService.saveSysUserOpen(sysUserOpen);

        return ResultDTO.ok();
    }

    /**
     * 修改
     */
    @SysLog("修改三方开放用户")
    @PostMapping("/update")
    @RequiresPermissions("sys:user:open:update")
    public ResultDTO update(@RequestBody SysUserOpenEntity sysUserOpen){
        sysUserOpenService.updateSysUserOpen(sysUserOpen);

        return ResultDTO.ok();
    }

    /**
     * 删除
     */
    @SysLog("删除三方开放用户")
    @PostMapping("/delete")
    @RequiresPermissions("sys:user:open:delete")
    public ResultDTO delete(@RequestBody Long[] ids){
        sysUserOpenService.removeSysUserOpen(ids);

        return ResultDTO.ok();
    }

}
