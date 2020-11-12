package com.lcf.fast.common.aspect;

import com.alibaba.fastjson.JSONObject;
import com.lcf.fast.common.util.HttpContextUtils;
import com.lcf.fast.common.util.IPUtils;
import com.lcf.fast.common.annotation.SysLoginLog;
import com.lcf.fast.module.sys.model.dto.SysLoginDTO;
import com.lcf.fast.module.sys.model.dto.SysLoginMobileDTO;
import com.lcf.fast.module.sys.model.dto.SysLoginSocialDTO;
import com.lcf.fast.module.sys.model.entity.SysLogEntity;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.service.SysLogService;
import lombok.AllArgsConstructor;
import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;

/**
 * 系统登录日志，切面处理类
 *
 * @author lcf
 * @date 2020/4/7 14:57
 */
@Aspect
@Component
@AllArgsConstructor
public class SysLoginAspect {
    private SysLogService sysLogService;

    @Pointcut("@annotation(com.lcf.fast.common.annotation.SysLoginLog)")
    public void logPointCut() {

    }

    @Around("logPointCut()")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        long beginTime = System.currentTimeMillis();
        //执行方法
        Object result = point.proceed();
        //执行时长(毫秒)
        long time = System.currentTimeMillis() - beginTime;

        //保存日志
        saveSysLoginLog(point, time);

        return result;
    }

    private void saveSysLoginLog(ProceedingJoinPoint joinPoint, long time) {
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();

        SysLogEntity sysLog = new SysLogEntity();
        SysLoginLog syslog = method.getAnnotation(SysLoginLog.class);
        if (syslog != null) {
            //注解上的描述
            sysLog.setTitle(syslog.value());
        }

        //请求的方法名
        String className = joinPoint.getTarget().getClass().getName();
        String methodName = signature.getName();
        sysLog.setMethod(className + "." + methodName + "()");

        //请求的参数
        Object[] args = joinPoint.getArgs();
        try {
            if (args != null && args.length > 0) {
                String params = JSONObject.toJSONString(args[0]);
                if (args[0] != null) {
                    if (args[0] instanceof SysLoginDTO) {
                        SysLoginDTO sysLoginDTO = (SysLoginDTO) args[0];
                        sysLog.setCreateBy(sysLoginDTO.getUsername());
                        sysLog.setPlatform(sysLoginDTO.getClient());
                    } else if (args[0] instanceof SysLoginSocialDTO) {
                        SysLoginSocialDTO sysLoginSocialDTO = (SysLoginSocialDTO) args[0];
                        sysLog.setCreateBy(sysLoginSocialDTO.getOpenId());
                        sysLog.setPlatform("app");
                    } else if (args[0] instanceof SysLoginMobileDTO) {
                        SysLoginMobileDTO sysLoginMobileDTO = (SysLoginMobileDTO) args[0];
                        sysLog.setCreateBy(sysLoginMobileDTO.getMobile());
                        sysLog.setPlatform("app");
                    }
                }
                sysLog.setParams(params);
            } else {
                String username = ((SysUserEntity) SecurityUtils.getSubject().getPrincipal()).getUsername();
                sysLog.setCreateBy(username);
                sysLog.setPlatform(((SysUserEntity) SecurityUtils.getSubject().getPrincipal()).getClientType());
            }
        } catch (Exception e) {

        }

        //获取request
        HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
        //设置IP地址
        sysLog.setRemoteAddr(IPUtils.getIpAddr(request));

        sysLog.setType("0");
        sysLog.setTime(time);
        sysLog.setCreateTime(new Date());
        //保存系统日志
        sysLogService.save(sysLog);
    }
}
