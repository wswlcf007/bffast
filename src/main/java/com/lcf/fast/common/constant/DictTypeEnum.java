package com.lcf.fast.common.constant;

import lombok.Getter;

/**
 * 字典类型 枚举
 *
 * @author lcf
 * @date 2018/8/15
 */
@Getter
public enum DictTypeEnum {
    /**
     * 字典类型1
     */
    Dict_Type_1("dictType1"),
    /**
     * 字典类型2
     */
    Dict_Type_2("dictType2");

    private String value;

    DictTypeEnum(String value) {
        this.value = value;
    }

    public static DictTypeEnum getDictType(String value) {
        DictTypeEnum[] enums = DictTypeEnum.values();
        for (DictTypeEnum eqpTypeEnum : enums) {
            if (eqpTypeEnum.value.equalsIgnoreCase(value)) {
                return eqpTypeEnum;
            }
        }
        return null;
    }
}
