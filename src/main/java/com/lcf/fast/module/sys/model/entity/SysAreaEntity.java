package com.lcf.fast.module.sys.model.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 系统_中国行政区划
 *
 * @author lcf
 * @date 2019-06-20 16:49:42
 */
@Data
@TableName("sys_area")
public class SysAreaEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id主键
     */
    @TableId
    private Integer id;
    /**
     * 父id
     */
    private Integer pid;
    /**
     * 行政区划代码
     */
    private String code;
    /**
     * 行政单位名称
     */
    private String name;
    /**
     * 层级 1-省级 2-市级 3-县级
     */
    private String level;

}
