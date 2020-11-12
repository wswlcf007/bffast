package com.lcf.fast.common.annotation;

import java.lang.annotation.*;

/**
 * 系统操作日志注解
 *
 * @author lcf
 * @date 2020/4/7 14:55
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SysLog {
    String value() default "";
}
