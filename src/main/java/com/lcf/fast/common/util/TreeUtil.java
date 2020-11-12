package com.lcf.fast.common.util;


import com.lcf.fast.module.sys.model.dto.MenuTreeDTO;
import com.lcf.fast.module.sys.model.dto.TreeNodeDTO;
import com.lcf.fast.module.sys.model.entity.SysMenuEntity;
import lombok.experimental.UtilityClass;

import java.util.ArrayList;
import java.util.List;

/**
 * 树工具类
 *
 * @author lcf
 * @date 2017年11月9日23:34:11
 */
@UtilityClass
public class TreeUtil {
    /**
     * 两层循环实现建树
     *
     * @param treeNodes 传入的树节点列表
     * @return
     */
    public <T extends TreeNodeDTO> List<T> buildByLoop(List<T> treeNodes, Object root) {

        List<T> trees = new ArrayList<>();

        for (T treeNode : treeNodes) {

            if (root.equals(treeNode.getParentId())) {
                trees.add(treeNode);
            }

            for (T it : treeNodes) {
                if (it.getParentId() == treeNode.getId()) {
                    if (treeNode.getChildren() == null) {
                        treeNode.setChildren(new ArrayList<>());
                    }
                    treeNode.add(it);
                }
            }
        }
        return trees;
    }

    /**
     * 使用递归方法建树
     *
     * @param treeNodes
     * @return
     */
    public <T extends TreeNodeDTO> List<T> buildByRecursive(List<T> treeNodes, Object root) {
        List<T> trees = new ArrayList<T>();
        for (T treeNode : treeNodes) {
            if (root.equals(treeNode.getParentId())) {
                trees.add(findChildren(treeNode, treeNodes));
            }
        }
        return trees;
    }

    /**
     * 递归查找子节点
     *
     * @param treeNodes
     * @return
     */
    public <T extends TreeNodeDTO> T findChildren(T treeNode, List<T> treeNodes) {
        for (T it : treeNodes) {
            if (treeNode.getId() == it.getParentId()) {
                if (treeNode.getChildren() == null) {
                    treeNode.setChildren(new ArrayList<>());
                }
                treeNode.add(findChildren(it, treeNodes));
            }
        }
        return treeNode;
    }

    /**
     * 通过sysMenu创建树形节点
     *
     * @param menus
     * @param root
     * @return
     */
    public List<MenuTreeDTO> buildTree(List<SysMenuEntity> menus, int root) {
        List<MenuTreeDTO> trees = new ArrayList<>();
        MenuTreeDTO node;
        for (SysMenuEntity menu : menus) {
            node = new MenuTreeDTO();
            node.setId(menu.getMenuId().intValue());
            node.setParentId(menu.getParentId().intValue());
            node.setName(menu.getName());
            node.setPath(menu.getPath());
            node.setCode(menu.getPermission());
            node.setLabel(menu.getName());
            node.setComponent(menu.getComponent());
            node.setIcon(menu.getIcon());
            node.setKeepAlive(menu.getKeepAlive());
            trees.add(node);
        }
        return TreeUtil.buildByLoop(trees, root);
    }
}
