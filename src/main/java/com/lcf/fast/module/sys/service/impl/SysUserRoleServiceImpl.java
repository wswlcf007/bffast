package com.lcf.fast.module.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.module.sys.dao.SysUserRoleDao;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;
import com.lcf.fast.module.sys.model.entity.SysUserRoleEntity;
import com.lcf.fast.module.sys.service.SysUserRoleService;
import org.springframework.stereotype.Service;

import java.util.List;


/**
 * 用户与角色对应关系
 *
 * @author lcf
 */
@Service("sysUserRoleService")
public class SysUserRoleServiceImpl extends ServiceImpl<SysUserRoleDao, SysUserRoleEntity> implements SysUserRoleService {

    @Override
    public void saveOrUpdate(Long userId, Integer roleId) {
        //先删除用户与角色关系
        remove(new QueryWrapper<SysUserRoleEntity>().eq("user_id", userId));

        if (roleId == null) {
            return;
        }

        //保存用户与角色关系
        SysUserRoleEntity sysUserRoleEntity = new SysUserRoleEntity();
        sysUserRoleEntity.setUserId(userId);
        sysUserRoleEntity.setRoleId(roleId.longValue());
        this.save(sysUserRoleEntity);
    }

    @Override
    public List<Integer> queryRoleIdList(Long userId) {
        return baseMapper.queryRoleIdList(userId);
    }

    @Override
    public SysRoleEntity queryRole(Long userId) {
        return baseMapper.queryRole(userId);
    }

    @Override
    public int deleteBatch(Long[] roleIds) {
        return baseMapper.deleteBatch(roleIds);
    }

    /**
     * 根据用户Id删除该用户的角色关系
     *
     * @param userId 用户ID
     * @return boolean
     * @author 寻欢·李
     * @date 2017年12月7日 16:31:38
     */
    @Override
    public Boolean removeRoleByUserId(Long userId) {
        return baseMapper.deleteByUserId(userId);
    }
}
