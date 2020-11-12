package com.lcf.fast.module.sys.controller;

import cn.hutool.core.util.ArrayUtil;
import com.lcf.fast.common.annotation.SysLog;
import com.lcf.fast.common.constant.RCodeEnum;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.common.validator.ValidatorUtils;
import com.lcf.fast.common.validator.group.AddGroup;
import com.lcf.fast.common.validator.group.UpdateGroup;
import com.lcf.fast.module.sys.model.dto.PasswordDTO;
import com.lcf.fast.module.sys.model.dto.SysUserDTO;
import com.lcf.fast.module.sys.model.dto.SysUserLockDTO;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.service.SysUserService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 系统用户
 *
 * @author lcf
 * @date 2019/11/12 9:48:41
 */
@RestController
@RequestMapping("/sys/user")
@AllArgsConstructor
public class SysUserController extends BaseController {
    private SysUserService sysUserService;

    /**
     * 所有用户列表 - 分页
     */
    @GetMapping("/list/page")
    @RequiresPermissions("sys:user:list")
    public ResultDTO page(@RequestParam Map<String, Object> params) {
        //只有超级管理员，才能查看所有管理员列表
        if (getUserId() != 1) {
            params.put("createUserId", getUserId());
        }
        PageUtils page = sysUserService.queryPage(params);

        return ResultDTO.ok(page);
    }

    /**
     * 所有用户列表 - 分页
     */
    @GetMapping("/list")
    @RequiresPermissions("sys:user:list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        //只有超级管理员，才能查看所有管理员列表
        if (getUserId() != 1) {
            params.put("createUserId", getUserId());
        }
        List<SysUserEntity> list = sysUserService.queryList(params);
        return ResultDTO.ok(list);
    }

    /**
     * 获取登录的用户信息
     */
    @GetMapping("/info")
    public ResultDTO info() {
        return ResultDTO.ok(sysUserService.getInfo());
//        return ResultDTO.ok(getUser());
    }


    /**
     * 用户信息
     */
    @GetMapping("/info/{userId}")
    @RequiresPermissions("sys:user:info")
    public ResultDTO info(@PathVariable("userId") Long userId) {
        SysUserDTO sysUserDTO = sysUserService.getUserById(userId);
        return ResultDTO.ok(sysUserDTO);
    }

    /**
     * 修改登录用户密码
     */
    @SysLog("修改密码")
    @PostMapping("/password")
    public ResultDTO password(@RequestBody PasswordDTO passwordDTO) {
        sysUserService.updatePassword(passwordDTO);
        return ResultDTO.ok();
    }

    /**
     * 重置登录用户密码
     */
    @SysLog("重置密码")
    @PostMapping("/reset/{id}")
    @RequiresPermissions("sys:user:reset")
    public ResultDTO password(@PathVariable(value = "id") Long id) {
        sysUserService.resetPassword(id);
        return ResultDTO.ok();
    }

    /**
     * 保存用户
     */
    @SysLog("保存用户")
    @PostMapping("/save")
    @RequiresPermissions("sys:user:save")
    public ResultDTO save(@RequestBody SysUserDTO user) {
        ValidatorUtils.validateEntity(user, AddGroup.class);
        sysUserService.saveUser(user);
        return ResultDTO.ok();
    }

    /**
     * 修改用户
     */
    @SysLog("修改用户")
    @PostMapping("/update")
    @RequiresPermissions("sys:user:update")
    public ResultDTO update(@RequestBody SysUserDTO user) {
        ValidatorUtils.validateEntity(user, UpdateGroup.class);
        sysUserService.update(user);
        return ResultDTO.ok();
    }

    /**
     * 锁定用户
     */
    @SysLog("锁定用户")
    @PostMapping("/lock")
    @RequiresPermissions("sys:user:lock")
    public ResultDTO lock(@RequestBody SysUserLockDTO user) {
        sysUserService.updateUserLockStatus(user);
        return ResultDTO.ok();
    }

    /**
     * 删除用户
     */
    @SysLog("删除用户")
    @PostMapping("/delete")
    @RequiresPermissions("sys:user:delete")
    public ResultDTO delete(@RequestBody Long[] userIds) {
        if (ArrayUtil.contains(userIds, 1L)) {
            return ResultDTO.error(RCodeEnum.Error.getCode(), "系统管理员不能删除");
        }

        if (ArrayUtil.contains(userIds, getUserId())) {
            return ResultDTO.error(RCodeEnum.Error.getCode(), "当前用户不能删除");
        }

        sysUserService.deleteUser(userIds);

        return ResultDTO.ok();
    }

}
