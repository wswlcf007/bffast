package com.lcf.fast.module.sys.service.impl;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.constant.MenuTypeEnum;
import com.lcf.fast.common.constant.RCodeEnum;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.module.sys.dao.SysMenuDao;
import com.lcf.fast.module.sys.model.entity.SysMenuEntity;
import com.lcf.fast.module.sys.model.entity.SysRoleMenuEntity;
import com.lcf.fast.module.sys.model.vo.MenuVO;
import com.lcf.fast.module.sys.service.SysMenuService;
import com.lcf.fast.module.sys.service.SysRoleMenuService;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Service("sysMenuService")
@AllArgsConstructor
public class SysMenuServiceImpl extends ServiceImpl<SysMenuDao, SysMenuEntity> implements SysMenuService {
    private SysRoleMenuService sysRoleMenuService;

    @Override
    public List<SysMenuEntity> queryListParentId(Long parentId, List<Long> menuIdList) {
        List<SysMenuEntity> menuList = queryListParentId(parentId);
        if (menuIdList == null) {
            return menuList;
        }

        List<SysMenuEntity> userMenuList = new ArrayList<>();
        for (SysMenuEntity menu : menuList) {
            if (menuIdList.contains(menu.getMenuId())) {
                userMenuList.add(menu);
            }
        }
        return userMenuList;
    }

    @Override
    public List<SysMenuEntity> queryListParentId(Long parentId) {
        return baseMapper.queryListParentId(parentId);
    }

    @Override
    public List<SysMenuEntity> queryNotButtonList() {
        return baseMapper.queryNotButtonList();
    }

    @Override
    public List<SysMenuEntity> getList(Map<String, Object> params) {
        String clientType = (String) params.get("clientType");
        List<SysMenuEntity> menuList = list(new QueryWrapper<SysMenuEntity>()
                .eq(StrUtil.isNotBlank(clientType), "client_type", clientType)
                .orderByAsc("sort"));
        for (SysMenuEntity sysMenuEntity : menuList) {
            SysMenuEntity parentMenuEntity = getById(sysMenuEntity.getParentId());
            if (parentMenuEntity != null) {
                sysMenuEntity.setParentName(parentMenuEntity.getName());
            }
        }
        return menuList;
    }

    @Override
    public List<SysMenuEntity> getUserMenuList(Long userId) {
        //系统管理员，拥有最高权限
        if (userId == 1) {
            return getAllMenuList(null);
        }

        //用户菜单列表
        List<Long> menuIdList = baseMapper.queryAllMenuId(userId);
        return getAllMenuList(menuIdList);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    @CacheEvict(value = "menu_details", allEntries = true)
    public void delete(Long menuId) {
        //删除菜单
        this.removeById(menuId);
        //删除菜单与角色关联
        sysRoleMenuService.remove(new QueryWrapper<SysRoleMenuEntity>().eq("menu_id", menuId));
    }

    @Override
    @Cacheable(value = "menuIdList_details", key = "#roleId  + '_menu'")
    public List<MenuVO> getMenuByRoleId(Integer roleId) {
        return baseMapper.listMenusByRoleId(roleId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteMenu(long menuId) {
        SysMenuEntity sysMenu = getById(menuId);
        if (sysMenu == null) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(), "删除失败，菜单不存在");
        }
        if (MenuTypeEnum.SYS.getValue().equalsIgnoreCase(sysMenu.getIsSys())) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(), "系统菜单，不能删除");
        }

        //判断是否有子菜单或按钮
        List<SysMenuEntity> menuList = queryListParentId(menuId);
        if (menuList.size() > 0) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(), "请先删除子菜单或按钮");
        }
        delete(menuId);
    }

    /**
     * 获取所有菜单列表
     */
    private List<SysMenuEntity> getAllMenuList(List<Long> menuIdList) {
        //查询根菜单列表
        List<SysMenuEntity> menuList = queryListParentId(-1L, menuIdList);
        //递归获取子菜单
        getMenuTreeList(menuList, menuIdList);

        return menuList;
    }

    /**
     * 递归
     */
    private List<SysMenuEntity> getMenuTreeList(List<SysMenuEntity> menuList, List<Long> menuIdList) {
        List<SysMenuEntity> subMenuList = new ArrayList<SysMenuEntity>();

        for (SysMenuEntity entity : menuList) {
            //目录
            if (MenuTypeEnum.CATALOG.getValue().equalsIgnoreCase(entity.getType())) {
                entity.setList(getMenuTreeList(queryListParentId(entity.getMenuId(), menuIdList), menuIdList));
            }
            subMenuList.add(entity);
        }

        return subMenuList;
    }
}
