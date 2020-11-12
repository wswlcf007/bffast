package com.lcf.fast.module.sys.model.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统日志-开放接口三方调用记录
 *
 * @author lcf
 * @date 2020-08-14 11:25:54
 */
@TableName("sys_open_api_log")
@Getter
@Setter
public class SysOpenApiLogEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId
    private Long id;
    /**
     * 三方key
     */
    private String openKey;
    /**
     * 接口路径
     */
    private String apiUrl;
    /**
     * 调用请求参数
     */
    private String requestParams;
    /**
     * 调用方ip
     */
    private String ipAddress;
    /**
     * 调用是否失败 0-否 1-是
     */
    private String isFail;
    /**
     * 返回结果
     */
    private String responseParams;
    /**
     * 调用日期
     */
    private String timeDay;
    /**
     * 调用时间
     */
    private Date createTime;

}
