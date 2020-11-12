package com.lcf.fast.module.sys.controller;

import com.lcf.fast.common.annotation.SysLog;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.common.validator.ValidatorUtils;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;
import com.lcf.fast.module.sys.service.SysRoleMenuService;
import com.lcf.fast.module.sys.service.SysRoleService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 角色管理
 *
 * @author lcf
 * @date 2019/11/12 9:48:31
 */
@RestController
@RequestMapping("/sys/role")
@AllArgsConstructor
public class SysRoleController extends BaseController {
    private SysRoleService sysRoleService;
    private SysRoleMenuService sysRoleMenuService;

    /**
     * 角色列表 - 分页
     */
    @GetMapping("/list/page")
    @RequiresPermissions("sys:role:list")
    public ResultDTO page(@RequestParam Map<String, Object> params) {
        //如果不是超级管理员，则只查询自己创建的角色列表
        if (getUserId() != 1) {
            params.put("createUserId", getUserId());
        }

        PageUtils page = sysRoleService.queryPage(params);
        return ResultDTO.ok(page);
    }

    /**
     * 角色列表
     */
    @GetMapping("/list")
    @RequiresPermissions("sys:role:list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        //如果不是超级管理员，则只查询自己创建的角色列表
        if (getUserId() != 1) {
            params.put("createUserId", getUserId());
        }
        List<SysRoleEntity> list = sysRoleService.queryList(params);
        return ResultDTO.ok(list);
    }

    /**
     * 角色列表
     */
    @GetMapping("/select")
    @RequiresPermissions("sys:role:select")
    public ResultDTO select() {
        Map<String, Object> map = new HashMap<>();

        //如果不是超级管理员，则只查询自己所拥有的角色列表
        if (getUserId() != 1) {
            map.put("create_user_id", getUserId());
        }
        List<SysRoleEntity> list = (List<SysRoleEntity>) sysRoleService.listByMap(map);

        return ResultDTO.ok(list);
    }

    /**
     * 角色信息
     */
    @GetMapping("/info/{roleId}")
    @RequiresPermissions("sys:role:info")
    public ResultDTO info(@PathVariable("roleId") Long roleId) {
        SysRoleEntity role = sysRoleService.getById(roleId);

        //查询角色对应的菜单
        List<Long> menuIdList = sysRoleMenuService.queryMenuIdList(roleId);
        role.setMenuIdList(menuIdList);

        return ResultDTO.ok(role);
    }

    /**
     * 保存角色
     */
    @SysLog("保存角色")
    @PostMapping("/save")
    @RequiresPermissions("sys:role:save")
    public ResultDTO save(@RequestBody SysRoleEntity role) {
        ValidatorUtils.validateEntity(role);

//        role.setCreateUserId(getUserId());
        sysRoleService.saveRole(role);

        return ResultDTO.ok();
    }

    /**
     * 修改角色
     */
    @SysLog("修改角色")
    @PostMapping("/update")
    @RequiresPermissions("sys:role:update")
    public ResultDTO update(@RequestBody SysRoleEntity role) {
        ValidatorUtils.validateEntity(role);

//        role.setCreateUserId(getUserId());
        sysRoleService.update(role);

        return ResultDTO.ok();
    }

    /**
     * 加权限
     *
     * @return
     */
    @PostMapping("/authorize")
    @RequiresPermissions("sys:role:authority")
    public ResultDTO authorize(@RequestBody SysRoleEntity role) {
        sysRoleMenuService.saveOrUpdate(role.getRoleId().longValue(), role.getMenuIdList());
        return ResultDTO.ok();
    }

    /**
     * 删除角色
     */
    @SysLog("删除角色")
    @PostMapping("/delete")
    @RequiresPermissions("sys:role:delete")
    public ResultDTO delete(@RequestBody Long[] roleIds) {
        sysRoleService.deleteBatch(roleIds);

        return ResultDTO.ok();
    }
}
