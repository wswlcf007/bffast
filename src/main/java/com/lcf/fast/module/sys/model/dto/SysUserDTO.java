package com.lcf.fast.module.sys.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 客户端传参 用户DTO
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@Getter
@Setter
public class SysUserDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户id
     */
    private Long userId;
    /**
     * 登录帐号
     */
    private String username;
    /**
     * 密码
     */
    private String password;
    /**
     * 用户姓名
     */
    private String name;

    /**
     * 手机号
     */
    private String phone;

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
     * 联系人
     */
    private String linkMan;

    /**
     * 联系方式
     */
    private String linkPhone;

    /**
     * 地区code
     */
    private String area;
    /**
     * 地区名称
     */
    private String areaName;
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
     * 第三方
     */
    private String providerId;

    /**
     * 第三方accessToken
     */
    private String accessToken;

    /**
     * 创建时间
     */
    private String createTime;

}
