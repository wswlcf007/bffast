package com.lcf.fast.common.annotation;

import java.lang.annotation.*;

/**
 * 系统登录日志注解
 *
 * @author lcf
 * @date 2020/4/7 14:55
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SysLoginLog {
    String value() default "";
}
