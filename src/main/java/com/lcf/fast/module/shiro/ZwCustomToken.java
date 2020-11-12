package com.lcf.fast.module.shiro;

import lombok.AllArgsConstructor;
import org.apache.shiro.authc.AuthenticationToken;

/**
 * 自定义token
 *
 * @author lcf
 * @date 2020/4/7 16:03
 */
@AllArgsConstructor
public class ZwCustomToken implements AuthenticationToken {
    private String token;

    @Override
    public Object getPrincipal() {
        return token;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}
