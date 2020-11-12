package com.lcf.fast.module.sys.model.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 系统菜单
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@Data
@TableName("sys_menu")
public class SysMenuEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 菜单ID
     */
    @TableId
    private Long menuId;

    /**
     * 菜单名称
     */
    private String name;

    /**
     * 父菜单ID，一级菜单为0
     */
    private Long parentId;

    /**
     * 父菜单名称
     */
    @TableField(exist = false)
    private String parentName;

    /**
     * 菜单权限标识
     */
    private String permission;

    /**
     * 前端URL
     */
    private String path;

    /**
     * 菜单URL
     */
    //private String url;

    /**
     * 授权(多个用逗号分隔，如：user:list,user:create)
     */
    //private String perms;

    /**
     * 菜单类型 （0菜单 1按钮）
     */
    private String type;

    /**
     * 客户端类型 0-运管中心 1-数据中心
     */
    private String clientType;

    /**
     * 是否系统菜单  0-否 1-是
     */
    private String isSys;

    /**
     * 菜单图标
     */
    private String icon;

    /**
     * VUE页面
     */
    private String component;

    /**
     * 排序值
     */
    private Integer sort;

    /**
     * 排序
     */
//    private Integer orderNum;

    /**
     * 0-开启，1- 关闭
     */
    private String keepAlive;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;

    /**
     * 逻辑删除标记(0--正常 1--删除)
     */
    private String delFlag;

    /**
     * ztree属性
     */
    @TableField(exist = false)
    private Boolean open;

    @TableField(exist = false)
    private List<?> list;
}
