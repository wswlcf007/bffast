package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.dto.*;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;

import java.util.List;
import java.util.Map;


/**
 * 系统用户
 *
 * @author lcf
 * @date 2020/4/7 15:45
 */
public interface SysUserService extends IService<SysUserEntity> {

    /**
     * 分页查询用户列表
     *
     * @param params
     * @return
     */
    PageUtils queryPage(Map<String, Object> params);

    /**
     * 不分页查询用户列表
     *
     * @param params
     * @return
     */
    List<SysUserEntity> queryList(Map<String, Object> params);

    /**
     * 查询用户的所有权限
     *
     * @param userId 用户ID
     */
    List<String> queryAllPerms(Long userId);

    /**
     * 根据用户名，查询系统用户
     */
    SysUserEntity queryByUserName(String username);

    /**
     * 保存用户
     */
    Long saveUser(SysUserDTO user);

    /**
     * 修改用户
     */
    void update(SysUserDTO user);

    /**
     * 删除用户
     */
    void deleteUser(Long[] userIds);

    /**
     * 修改密码
     */
    void updatePassword(PasswordDTO passwordDTO);

    /**
     * 重置密码
     *
     * @param id
     */
    void resetPassword(Long id);

    /**
     * 更新用户锁定状态
     *
     * @param dto
     */
    void updateUserLockStatus(SysUserLockDTO dto);

    /**
     * 更新用户上次登录时间
     *
     * @param dto
     */
    void updateUserLastTime(SysUserLastTimeDTO dto);

    /**
     * 当前用户信息
     *
     * @return
     */
    UserInfoDTO getInfo();

    /**
     * 根据id单条查询
     *
     * @param userId
     * @return
     */
    SysUserDTO getUserById(Long userId);

}
