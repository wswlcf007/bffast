package com.lcf.fast.module.shiro;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSONObject;
import com.lcf.fast.common.constant.RCodeEnum;
import com.lcf.fast.common.util.HttpContextUtils;
import com.lcf.fast.common.model.ResultDTO;
import lombok.SneakyThrows;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 自定义过滤器
 *
 * @author lcf
 * @date 2020/4/7 16:06
 */
public class ZWCustomAuthenticatingFilter extends AuthenticatingFilter {
    @Override
    protected AuthenticationToken createToken(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        //获取请求token
        String token = getRequestToken((HttpServletRequest) servletRequest);

        if (StrUtil.isBlank(token)) {
            return null;
        }

        return new ZwCustomToken(token);
    }

    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        //获取请求token，如果token不存在，直接返回401
        String token = getRequestToken((HttpServletRequest) servletRequest);
        if (StrUtil.isBlank(token)) {
            HttpServletResponse httpResponse = (HttpServletResponse) servletResponse;
            httpResponse.setHeader("Access-Control-Allow-Credentials", "true");
            httpResponse.setHeader("Access-Control-Allow-Origin", HttpContextUtils.getOrigin());

            String string = JSONObject.toJSONString(ResultDTO.error(RCodeEnum.Unauthorized.getCode(), "invalid token"));
            httpResponse.getWriter().print(string);
            return false;
        }
        return executeLogin(servletRequest, servletResponse);
    }

    @SneakyThrows
    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response){
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        httpResponse.setHeader("Access-Control-Allow-Credentials", "true");
        httpResponse.setHeader("Access-Control-Allow-Origin", HttpContextUtils.getOrigin());
        httpResponse.setHeader("Content-Type","application/json;charset=UTF-8");

        String string = JSONObject.toJSONString(ResultDTO.error(RCodeEnum.Unauthorized.getCode(), e.getMessage()));
        httpResponse.getWriter().print(string);
        return false;
    }
    /**
     * 获取请求的token
     */
    private String getRequestToken(HttpServletRequest httpRequest) {
        //从header中获取token
        String token = httpRequest.getHeader("token");

        //如果header中不存在token，则从参数中获取token
        if (StrUtil.isBlank(token)) {
            token = httpRequest.getParameter("token");
        }

        return token;
    }
}
