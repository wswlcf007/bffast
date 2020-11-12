package com.lcf.fast.module.sys.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * 社交账户表
 *
 * @author nyn
 * @email @
 * @date 2019-09-20 09:43:52
 */
@TableName("sys_user_social")
@Data
public class SysUserSocialEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @TableId(type = IdType.INPUT)
    private Long userId;
    /**
     *
     */
    private String providerId;
    /**
     *
     */
    private String providerUserId;
    /**
     *
     */
    private Integer rank;
    /**
     *
     */
    private Integer eqpNumber;
    /**
     *
     */
    private String displayName;
    /**
     *
     */
    private String profileUrl;
    /**
     *
     */
    private String imageUrl;
    /**
     *
     */
    private String accessToken;
    /**
     *
     */
    private String secret;
    /**
     *
     */
    private String refreshToken;
    /**
     *
     */
    private Long expireTime;

    /**
     *
     */
    @TableField(exist = false)
    private String logType;
    /**
     *
     */
    @TableField(exist = false)
    private String phone;
    /**
     * 账户状态,0-正常，9-锁定
     */
    @TableField(exist = false)
    private String lockFlag;
}
