package com.lcf.fast.common.aspect;

import cn.hutool.core.codec.Base64;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.lcf.fast.common.annotation.OpenApi;
import com.lcf.fast.common.constant.CommonEnum;
import com.lcf.fast.common.constant.RCodeEnum;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.common.util.DateUtils;
import com.lcf.fast.common.util.HttpContextUtils;
import com.lcf.fast.common.util.IPUtils;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.module.sys.model.entity.SysOpenApiLogEntity;
import com.lcf.fast.module.sys.model.entity.SysUserOpenEntity;
import com.lcf.fast.module.sys.service.SysOpenApiLogService;
import com.lcf.fast.module.sys.service.SysUserOpenService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;

/**
 * 三方开放接口，切面处理类
 *
 * @author lcf
 * @date 2020-08-14 15:01
 */
@Aspect
@Component
@AllArgsConstructor
@Slf4j
public class OpenApiAspect {
    private SysUserOpenService sysUserOpenService;
    private SysOpenApiLogService sysOpenApiLogService;

    @Pointcut("@annotation(com.lcf.fast.common.annotation.OpenApi)")
    public void openApiPointCut() {

    }

    @Around("openApiPointCut()")
    public Object around(ProceedingJoinPoint joinPoint) {
        //1、执行方法之前 校验请求是否合法
        String openKey = checkSign(joinPoint);
        try {
            //2、执行方法
            Object result = joinPoint.proceed();
            //3、执行方法之后 记录日志
            String response = JSONObject.toJSONString(result);
            saveSysOpenApiLog(joinPoint, openKey, response, true);
            return result;
        } catch (BFRuntimeException e) {
            ResultDTO error = ResultDTO.error(e.getCode(), e.getMessage());
            String response = JSONObject.toJSONString(error);
            saveSysOpenApiLog(joinPoint, openKey, response, false);
            throw new BFRuntimeException(e.getCode(), e.getMessage(), e.getDebugMsg());
        } catch (Throwable throwable) {
            ResultDTO error = ResultDTO.error(RCodeEnum.Open_Error.getCode(), CommonEnum.Open_Api_Service_Err_Msg.getValue());
            String response = JSONObject.toJSONString(error);
            saveSysOpenApiLog(joinPoint, openKey, response, false);
            throw new BFRuntimeException(RCodeEnum.Open_Error.getCode(), throwable.getMessage(), throwable.getMessage());
        }
    }

    /**
     * 校验请求合法性 校验Authorization
     * ${Authorization}格式定义为：basic=${basic}&sign=${sign}
     * - 校验basic合法性 openKey 和 openSecret
     * - 校验sign合法性 参数签名有效性
     * <p>
     * 1.${basic}=base64(openKey:openSecret)，base64编码。
     * 2.${sign}=md5(params)，md5加密，32位大写。
     * (1)params为请求参数按key的ASCII码自然升序拼接，每个参数都采用key=value形式，参数之间使用'&'作为分隔符，
     * (2)若无入参，则传固定数值md5(zhuowen=electric)，即0155FB5B3C1D28EE3D1DC1A52B9ECE1C
     * (3)若为url path传参，则没有key，此时将key固定为“param”，即md5(param=${value})
     *
     * @param joinPoint
     * @return openKey
     */
    private String checkSign(ProceedingJoinPoint joinPoint) {
        //获取 authorization
        String authorization = HttpContextUtils.getAuthorization();
        if (StrUtil.isBlank(authorization)) {
            throw new BFRuntimeException(RCodeEnum.Open_Auth_Failed.getCode(), "auth failed");
        }
        if (!authorization.contains(CommonEnum.Open_Api_Basic.getValue()) || !authorization.contains(CommonEnum.Open_Api_Sign.getValue())) {
            throw new BFRuntimeException(RCodeEnum.Open_Auth_Failed.getCode(), "auth failed");
        }
        String[] split = authorization.split(CommonEnum.Open_Api_Sign.getValue());
        String basic = split[0].split(CommonEnum.Open_Api_Basic.getValue())[1];
        String sign = split[1];
        if (StrUtil.isBlank(basic) || StrUtil.isBlank(sign)) {
            throw new BFRuntimeException(RCodeEnum.Open_Auth_Failed.getCode(), "auth failed");
        }
        //1、校验 basic
        basic = Base64.decodeStr(basic);
        String[] basicSplit = basic.split(":");
        if (basicSplit.length == 0) {
            throw new BFRuntimeException(RCodeEnum.Open_Auth_Failed.getCode(), "invalid openKey or openSecret");
        }
        String openKey = basicSplit[0];
        String openSecret = basicSplit[1];
        SysUserOpenEntity openEntity = sysUserOpenService.getOne(new QueryWrapper<SysUserOpenEntity>()
                .eq("open_key", openKey)
                .eq("is_del", "0"));
        if (openEntity == null) {
            throw new BFRuntimeException(RCodeEnum.Open_Auth_Failed.getCode(), "invalid openKey or openSecret");
        }
        if ("1".equalsIgnoreCase(openEntity.getIsLock())) {
            throw new BFRuntimeException(RCodeEnum.Open_Auth_Failed.getCode(), "invalid openKey or openSecret");
        }
        if (!openSecret.equalsIgnoreCase(openEntity.getOpenSecret())) {
            throw new BFRuntimeException(RCodeEnum.Open_Auth_Failed.getCode(), "invalid openKey or openSecret");
        }
        //2、校验sign
        //请求的参数
        Object[] args = joinPoint.getArgs();
        if (args.length > 0) {
            if (args[0] instanceof Map) {
                Map map = (Map) args[0];
                if (map.size() == 0) {
                    throw new BFRuntimeException(RCodeEnum.Open_Parameter_Failed.getCode(), "invalid parameters");
                }
                StringBuilder sb = new StringBuilder();
                Map<String, Object> testMap = new TreeMap<String, Object>(map);
                for (String key : testMap.keySet()) {
                    sb.append(key).append("=").append(testMap.get(key)).append("&");
                }
                sb.deleteCharAt(sb.length() - 1);
                String checkedSign = DigestUtil.md5Hex(sb.toString()).toUpperCase();
                if (!sign.equalsIgnoreCase(checkedSign)) {
                    throw new BFRuntimeException(RCodeEnum.Open_Parameter_Failed.getCode(), "invalid sign");
                }
            } else if (args[0] instanceof String) {
                String param = (String) args[0];
                String checkedSign = DigestUtil.md5Hex("param" + "=" + param).toUpperCase();
                if (!sign.equalsIgnoreCase(checkedSign)) {
                    throw new BFRuntimeException(RCodeEnum.Open_Parameter_Failed.getCode(), "invalid sign");
                }
            }

        } else {
            //无传参
            if (!CommonEnum.Open_Api_Default_Sign.getValue().equalsIgnoreCase(sign)) {
                throw new BFRuntimeException(RCodeEnum.Open_Parameter_Failed.getCode(), "invalid sign");
            }
        }
        return openKey;
    }

    /**
     * 记录接口调用日志
     *
     * @param joinPoint
     * @param openKey
     * @param response
     * @param result
     */
    private void saveSysOpenApiLog(ProceedingJoinPoint joinPoint, String openKey, String response, boolean result) {
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        SysOpenApiLogEntity logEntity = new SysOpenApiLogEntity();

        OpenApi openApi = method.getAnnotation(OpenApi.class);
        if (openApi != null) {
            //注解上的描述
            logEntity.setApiUrl(openApi.value());
        }

        //请求的参数
        Object[] args = joinPoint.getArgs();
        if (args.length > 0) {
            String params = JSONObject.toJSONString(args[0]);
            logEntity.setRequestParams(params);
        }

        //获取request
        HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
        //设置IP地址
        logEntity.setIpAddress(IPUtils.getIpAddr(request));

        Date date = new Date();
        logEntity.setCreateTime(date);
        logEntity.setTimeDay(DateUtils.format(date, DateUtils.DATE_PATTERN));
        if (!result) {
            logEntity.setIsFail("1");
        }
        logEntity.setResponseParams(response);
        logEntity.setOpenKey(openKey);

        //保存日志
        sysOpenApiLogService.save(logEntity);
    }
}
