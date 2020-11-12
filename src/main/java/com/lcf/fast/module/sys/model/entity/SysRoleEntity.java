package com.lcf.fast.module.sys.model.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 系统角色
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@Data
@TableName("sys_role")
public class SysRoleEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 角色ID
     */
    @TableId
    private Integer roleId;

    /**
     * 角色名称
     */
    @NotBlank(message = "角色名称不能为空")
    private String roleName;

    private String roleCode;

    private String roleDesc;

    /**
     * 客户端类型 0-运管中心 1-数据中心
     */
    private String clientType;

    /**
     * 备注
     */
//    private String remark;

    /**
     * 创建者ID
     */
    private Long createUserId;

    @TableField(exist = false)
    private List<Long> menuIdList;

    /**
     * 创建时间
     */
    private Date createTime;

    private Date updateTime;

    /**
     * 删除标识（0-正常,1-删除
     */
    private String delFlag;

}
