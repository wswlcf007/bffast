package com.lcf.fast.module.sys.model.entity;


import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * 版本管理
 *
 * @author lcf
 * @date 2020-01-18 15:45:11
 */
@TableName("sys_version")
@Data
public class SysVersionEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @TableId
    private Long id;
    /**
     * 客户端类型 0-安卓 1-苹果
     */
    private String clientType;
    /**
     * 版本名称
     */
    private String versionName;
    /**
     * 版本号
     */
    private Long version;
    /**
     * 是否最新
     */
    private String isCurrent;
    /**
     * 描述
     */
    private String content;
    /**
     * 0-不强制,1-强制升级
     */
    private String upgrade;
    /**
     * 安装路径
     */
    private String installUrl;
    /**
     * 更新时间
     */
    private Long createTime;
    /**
     * 更新人
     */
    private Long createUser;
    /**
     * 更新人名称
     */
    private String createUserName;
}
