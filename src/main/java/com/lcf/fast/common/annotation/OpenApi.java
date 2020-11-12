package com.lcf.fast.common.annotation;

import java.lang.annotation.*;

/**
 * 三方平台接口
 *
 * @author lcf
 * @date 2020-08-14 15:07
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface OpenApi {
    String value() default "";
}
