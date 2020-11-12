package com.lcf.fast.module.sys.model.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * 列表页面展示用户信息VO
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@Getter
@Setter
public class SysUserVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 登录帐号
     */
    private String username;
    /**
     * 用户真实姓名
     */
    private String name;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 部门ID
     */
    private Integer deptId;

    /**
     * 角色id
     */
    private Integer roleId;

    /**
     * 角色code
     */
    private String roleCode;

    /**
     * 角色名称
     */
    private String roleName;

    /**
     * 创建者ID
     */
    private Long createUserId;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;

    /**
     * 0-正常，9-锁定
     */
    private String lockFlag;

    /**
     * 0-正常，1-删除
     */
    private String delFlag;

    /**
     * 头像
     */
    private String imageUrl;

    /**
     * 最后一次登录时间
     */
    private Long lastTime;
    /**
     * 地图x轴
     */
    private String mapX;
    /**
     * 地图y轴
     */
    private String mapY;
    /**
     * 地图地址
     */
    private String areaMap;
    /**
     * 联系人
     */
    private String linkMan;

    /**
     * 地区代码
     */
    private String area;
    /**
     * 地区名称
     */
    private String areaName;
}
