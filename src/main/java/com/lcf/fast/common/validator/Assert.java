package com.lcf.fast.common.validator;


import cn.hutool.core.util.StrUtil;
import com.lcf.fast.common.exception.BFRuntimeException;

/**
 * 数据校验
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
public abstract class Assert {

    public static void isBlank(String str, String message) {
        if (StrUtil.isBlank(str)) {
            throw new BFRuntimeException(message);
        }
    }

    public static void isNull(Object object, String message) {
        if (object == null) {
            throw new BFRuntimeException(message);
        }
    }
}
