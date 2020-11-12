package com.lcf.fast.module.sys.model.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 菜单权限 VO
 *
 * @author lcf
 * @date 2019/2/1
 */
@Data
public class MenuVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 菜单ID
     */
    private Integer menuId;
    /**
     * 菜单名称
     */
    private String name;
    /**
     * 菜单权限标识
     */
    private String permission;
    /**
     * 父菜单ID
     */
    private Integer parentId;
    /**
     * 图标
     */
    private String icon;
    /**
     * 一个路径
     */
    private String path;
    /**
     * VUE页面
     */
    private String component;
    /**
     * 排序值
     */
    private Integer sort;
    /**
     * 菜单类型 （0菜单 1按钮）
     */
    private String type;
    /**
     * 是否缓冲
     */
    private String keepAlive;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 更新时间
     */
    private Date updateTime;
    /**
     * 0--正常 1--删除
     */
    private String delFlag;


    @Override
    public int hashCode() {
        return menuId.hashCode();
    }

    /**
     * menuId 相同则相同
     *
     * @param obj
     * @return
     */
    @Override
    public boolean equals(Object obj) {
        if (obj instanceof MenuVO) {
            Integer targetMenuId = ((MenuVO) obj).getMenuId();
            return menuId.equals(targetMenuId);
        }
        return super.equals(obj);
    }
}
