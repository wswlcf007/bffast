package com.lcf.fast.module.sys.controller;

import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.entity.SysUserSocialEntity;
import com.lcf.fast.module.sys.service.SysUserSocialService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 第三方账号绑定设备
 *
 * @author lcf
 * @date 2019-09-24 14:54:02
 */
@RestController
@RequestMapping("user/social")
@AllArgsConstructor
public class SysUserSocialController {
    private SysUserSocialService sysUserSocialService;

    /**
     * 列表-分页
     *
     * @return
     */
    @RequestMapping("/list/page")
    @RequiresPermissions("sys:user:social:list")
    public ResultDTO page(@RequestParam Map<String, Object> params) {
        PageUtils page = sysUserSocialService.queryPage(params);
        return ResultDTO.ok(page);
    }

    /**
     * 列表-不分页
     *
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:user:social:list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        List<SysUserSocialEntity> list = sysUserSocialService.queryList(params);
        return ResultDTO.ok(list);
    }


    /**
     * 信息
     *
     * @return
     */
    @GetMapping("/info/{id}")
    @RequiresPermissions("sys:user:social:info")
    public ResultDTO info(@PathVariable("id") Long id) {
        SysUserSocialEntity eqpSocialUser = sysUserSocialService.getBaseMapper().selectById(id);
        return ResultDTO.ok(eqpSocialUser);
    }

    /**
     * 保存
     *
     * @return
     */
    @PostMapping("/save")
    @RequiresPermissions("sys:user:social:save")
    public ResultDTO save(@RequestBody SysUserSocialEntity eqpSocialUser) {
        sysUserSocialService.getBaseMapper().insert(eqpSocialUser);
        return ResultDTO.ok();
    }

    /**
     * 修改
     *
     * @return
     */
    @PostMapping("/update")
    @RequiresPermissions("sys:user:social:update")
    public ResultDTO update(@RequestBody SysUserSocialEntity eqpSocialUser) {
        sysUserSocialService.updateById(eqpSocialUser);
        return ResultDTO.ok();
    }

    /**
     * 删除
     *
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("sys:user:social:delete")
    public ResultDTO delete(@RequestBody Long[] ids) {
        sysUserSocialService.getBaseMapper().deleteBatchIds(Arrays.asList(ids));
        return ResultDTO.ok();
    }
}
