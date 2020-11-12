package com.lcf.fast.module.sys.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.module.sys.model.entity.SysMenuEntity;
import com.lcf.fast.module.sys.model.vo.MenuVO;

import java.util.List;
import java.util.Map;


/**
 * 菜单管理
 *
 * @author lcf
 * @date 2020/4/7 15:45
 */
public interface SysMenuService extends IService<SysMenuEntity> {

    /**
     * 根据父菜单，查询子菜单
     *
     * @param parentId   父菜单ID
     * @param menuIdList 用户菜单ID
     */
    List<SysMenuEntity> queryListParentId(Long parentId, List<Long> menuIdList);

    /**
     * 根据父菜单，查询子菜单
     *
     * @param parentId 父菜单ID
     */
    List<SysMenuEntity> queryListParentId(Long parentId);

    /**
     * 获取不包含按钮的菜单列表
     */
    List<SysMenuEntity> queryNotButtonList();

    /**
     * 获取所有菜单列表
     */
    List<SysMenuEntity> getList(Map<String, Object> params);

    /**
     * 获取用户菜单列表
     */
    List<SysMenuEntity> getUserMenuList(Long userId);

    /**
     * 删除
     */
    void delete(Long menuId);

    /**
     * 通过角色编号查询URL 权限
     *
     * @param roleId 角色ID
     * @return 菜单列表
     */
    List<MenuVO> getMenuByRoleId(Integer roleId);

    /**
     * 根据id删除菜单
     *
     * @param menuId
     */
    void deleteMenu(long menuId);
}
