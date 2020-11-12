package com.lcf.fast.common.aspect;

import com.alibaba.fastjson.JSONObject;
import com.lcf.fast.common.util.HttpContextUtils;
import com.lcf.fast.common.util.IPUtils;
import com.lcf.fast.common.annotation.SysLog;
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
 * 系统操作日志，切面处理类
 *
 * @author lcf
 * @date 2020/4/7 14:57
 */
@Aspect
@Component
@AllArgsConstructor
public class SysLogAspect {
    private SysLogService sysLogService;

    @Pointcut("@annotation(com.lcf.fast.common.annotation.SysLog)")
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
        saveSysLog(point, time);

        return result;
    }

    private void saveSysLog(ProceedingJoinPoint joinPoint, long time) {
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();

        SysLogEntity sysLog = new SysLogEntity();
        SysLog syslog = method.getAnnotation(SysLog.class);
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
            String params = JSONObject.toJSONString(args);
            sysLog.setParams(params);
        } catch (Exception e) {

        }

        //获取request
        HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
        //设置IP地址
        sysLog.setRemoteAddr(IPUtils.getIpAddr(request));

        //用户名
        String username = ((SysUserEntity) SecurityUtils.getSubject().getPrincipal()).getUsername();
        sysLog.setCreateBy(username);
        String clientType = ((SysUserEntity) SecurityUtils.getSubject().getPrincipal()).getClientType();
        sysLog.setPlatform(clientType);

        sysLog.setTime(time);
        sysLog.setCreateTime(new Date());
        sysLog.setType("1");
        //保存系统日志
        sysLogService.save(sysLog);
    }
}
