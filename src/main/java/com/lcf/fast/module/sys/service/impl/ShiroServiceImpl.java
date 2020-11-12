package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.lcf.fast.module.sys.dao.SysMenuDao;
import com.lcf.fast.module.sys.dao.SysUserDao;
import com.lcf.fast.module.sys.dao.SysUserTokenDao;
import com.lcf.fast.module.sys.model.entity.SysMenuEntity;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.model.entity.SysUserTokenEntity;
import com.lcf.fast.module.sys.service.ShiroService;
import com.lcf.fast.module.sys.service.SysUserRoleService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@AllArgsConstructor
public class ShiroServiceImpl implements ShiroService {
    private SysMenuDao sysMenuDao;
    private SysUserDao sysUserDao;
    private SysUserRoleService sysUserRoleService;
    private SysUserTokenDao sysUserTokenDao;

    @Override
    public Set<String> getUserPermissions(long userId) {
        List<String> permsList;

        //系统管理员，拥有最高权限
        if (userId == 1) {
            List<SysMenuEntity> menuList = sysMenuDao.selectList(null);
            permsList = new ArrayList<>(menuList.size());
            for (SysMenuEntity menu : menuList) {
                permsList.add(menu.getPermission());
            }
        } else {
            permsList = sysUserDao.queryAllPerms(userId);
        }
        //用户权限列表
        Set<String> permsSet = new HashSet<>();
        for (String perms : permsList) {
            if (StrUtil.isBlank(perms)) {
                continue;
            }
            permsSet.addAll(Arrays.asList(perms.trim().split(",")));
        }
        return permsSet;
    }

    @Override
    public SysUserTokenEntity queryByToken(String token) {
        return sysUserTokenDao.queryByToken(token);
    }

    @Override
    public SysUserEntity queryUser(Long userId) {
        SysUserEntity userEntity = sysUserDao.selectById(userId);
        //获取用户所属的角色
        SysRoleEntity sysRoleEntity = sysUserRoleService.queryRole(userId);
        if (sysRoleEntity != null) {
            userEntity.setRoleId(sysRoleEntity.getRoleId());
            userEntity.setRoleCode(sysRoleEntity.getRoleCode());
            userEntity.setClientType(sysRoleEntity.getClientType());
        }
        return userEntity;
    }
}
