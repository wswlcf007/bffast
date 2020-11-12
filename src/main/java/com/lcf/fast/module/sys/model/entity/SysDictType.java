package com.lcf.fast.module.sys.model.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * 字典类型
 *
 * @author lcf
 * @date 2020-06-28
 */
@Data
@TableName("sys_dict_type")
public class SysDictType implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 类型值
     */
    private String typeValue;
    /**
     * 类型名称
     */
    private String typeName;
}
