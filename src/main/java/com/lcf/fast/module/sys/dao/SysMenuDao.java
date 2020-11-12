package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.sys.model.vo.MenuVO;
import com.lcf.fast.module.sys.model.entity.SysMenuEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 菜单管理
 *
 * @author lcf
 */
@Mapper
public interface SysMenuDao extends BaseMapper<SysMenuEntity> {

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

    List<MenuVO> listMenusByRoleId(Integer roleId);

    /**
     * 查询用户的所有菜单ID
     */
    List<Long> queryAllMenuId(Long userId);
}
