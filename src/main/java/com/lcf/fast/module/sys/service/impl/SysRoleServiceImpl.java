package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.dao.SysRoleDao;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.service.SysRoleMenuService;
import com.lcf.fast.module.sys.service.SysRoleService;
import com.lcf.fast.module.sys.service.SysUserRoleService;
import lombok.AllArgsConstructor;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 角色
 *
 * @author lcf
 */
@Service("sysRoleService")
@AllArgsConstructor
public class SysRoleServiceImpl extends ServiceImpl<SysRoleDao, SysRoleEntity> implements SysRoleService {
    private SysRoleMenuService sysRoleMenuService;
    private SysUserRoleService sysUserRoleService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");
        String size = (String) params.get("size");
        String roleName = (String) params.get("roleName");
        Long createUserId = (Long) params.get("createUserId");
        Page<SysRoleEntity> page = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));
        IPage<SysRoleEntity> iPage = baseMapper.selectPage(page, new QueryWrapper<SysRoleEntity>()
                .like(StrUtil.isNotBlank(roleName), "role_name", roleName)
                .eq(createUserId != null, "create_user_id", createUserId)
        );

        return new PageUtils(iPage);
    }

    @Override
    public List<SysRoleEntity> queryList(Map<String, Object> params) {
        String roleName = (String) params.get("roleName");
        Long createUserId = (Long) params.get("createUserId");
        return baseMapper.selectList(new QueryWrapper<SysRoleEntity>()
                .like(StrUtil.isNotBlank(roleName), "role_name", roleName)
                .eq(createUserId != null, "create_user_id", createUserId));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveRole(SysRoleEntity role) {
        String roleCode = role.getRoleCode();
        SysRoleEntity sysRoleEntity = baseMapper.selectOne(new QueryWrapper<SysRoleEntity>().eq("role_code", roleCode));
        if (sysRoleEntity != null) {
            throw new BFRuntimeException("当前角色代码已存在");
        }
        SysUserEntity user = (SysUserEntity) SecurityUtils.getSubject().getPrincipal();
        role.setCreateUserId(user.getUserId());
        role.setCreateTime(new Date());
        this.save(role);

        //保存角色与菜单关系
        //sysRoleMenuService.saveOrUpdate(role.getRoleId(), role.getMenuIdList());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(SysRoleEntity role) {
        this.updateById(role);

        //更新角色与菜单关系
//        sysRoleMenuService.saveOrUpdate(role.getRoleId(), role.getMenuIdList());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteBatch(Long[] roleIds) {
        //删除角色
        this.removeByIds(Arrays.asList(roleIds));

        //删除角色与菜单关联
        sysRoleMenuService.deleteBatch(roleIds);

        //删除角色与用户关联
        sysUserRoleService.deleteBatch(roleIds);
    }


    @Override
    public List<Long> queryRoleIdList(Long createUserId) {
        return baseMapper.queryRoleIdList(createUserId);
    }

}
