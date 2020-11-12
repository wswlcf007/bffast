package com.lcf.fast.module.sys.model.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.lcf.fast.common.validator.group.AddGroup;
import com.lcf.fast.common.validator.group.UpdateGroup;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;

/**
 * 系统用户
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@Data
@TableName("sys_user")
public class SysUserEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    @TableId
    private Long userId;

    /**
     * 登录帐号
     */
    @NotBlank(message = "用户名不能为空", groups = {AddGroup.class, UpdateGroup.class})
    private String username;
    /**
     * 用户真实姓名
     */
    private String name;

    /**
     * 密码
     */
    @NotBlank(message = "密码不能为空", groups = AddGroup.class)
    private String password;

    /**
     * 盐
     */
    private String salt;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 部门ID
     */
    private Integer deptId;

    /**
     * 角色ID
     */
    @TableField(exist = false)
    private Integer roleId;

    /**
     * 角色code
     */
    @TableField(exist = false)
    private String roleCode;

    /**
     * 角色客户端类型
     */
    @TableField(exist = false)
    private String clientType;

    /**
     * 项目id
     */
    @TableField(exist = false)
    private Long projectId;
    /**
     * 代理商id
     */
    @TableField(exist = false)
    private Long agentId;
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

}
