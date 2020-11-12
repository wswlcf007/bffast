package com.lcf.fast.module.sys.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;

/**
 * 字典表
 *
 * @author lcf
 * @date 2020-06-28
 */
@Data
@TableName("sys_dict")
public class SysDict implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 数据值
     */
    @NotBlank(message = "字典项数据值不能为空")
    private String value;
    /**
     * 标签名
     */
    @NotBlank(message = "字典项标签不能为空")
    private String label;
    /**
     * 类型
     */
    @NotBlank(message = "字典项数据类型不能为空")
    private String type;
    /**
     * 类型名称
     */
    @TableField(exist = false)
    private String typeName;
    /**
     * 描述
     */
    private String description;
    /**
     * 排序（升序）
     */
    private Integer sort;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 更新时间
     */
    private Date updateTime;
    /**
     * 备注信息
     */
    private String remarks;
    /**
     * 删除标记
     */
    private String delFlag;
}
