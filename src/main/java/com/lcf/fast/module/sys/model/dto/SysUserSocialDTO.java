package com.lcf.fast.module.sys.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 社交账户
 *
 * @author lcf
 * @date 2019-09-20 09:43:52
 */
@Data
public class SysUserSocialDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    private Long userId;
    /**
     *
     */
    private String imageUrl;
    /**
     *
     */
    private String name;
    /**
     *
     */
    private String mobile;
    /**
     * 设备数量
     */
    private String username;
    /**
     *
     */
    private String lastTime;
    /**
     *
     */
    private String createTime;
    /**
     *
     */
    private String lockFlag;
    /**
     *
     */
    private String type;

}
