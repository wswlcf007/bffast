package com.lcf.fast.module.shiro;

import com.lcf.fast.common.constant.CommonEnum;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.model.entity.SysUserTokenEntity;
import com.lcf.fast.module.sys.service.ShiroService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;

import java.util.Set;

/**
 * shiro配置类
 *
 * @author lcf
 * @date 2020/4/7 15:45
 */
@Component
@AllArgsConstructor
public class ZWCustomRealm extends AuthorizingRealm {
    private ShiroService shiroService;

    @Override
    public boolean supports(AuthenticationToken token) {
        return token instanceof ZwCustomToken;
    }

    /**
     * 授权(验证权限时调用)
     * 登录成功后，返回权限列表
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SysUserEntity user = (SysUserEntity) principals.getPrimaryPrincipal();
        Long userId = user.getUserId();
        String userName = user.getUsername();

        //用户权限列表
        Set<String> permsSet = shiroService.getUserPermissions(userId);

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setStringPermissions(permsSet);
        return info;

    }

    /**
     * 认证(登录时调用)
     * 获取身份认证信息
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String accessToken = (String) token.getPrincipal();

        //根据accessToken，查询用户信息
        SysUserTokenEntity tokenEntity = shiroService.queryByToken(accessToken);
        //token失效
        if (tokenEntity == null || tokenEntity.getExpireTime().getTime() < System.currentTimeMillis()) {
            throw new AuthenticationException("token失效，请重新登录");
        }

        //查询用户信息
        SysUserEntity user = shiroService.queryUser(tokenEntity.getUserId());
        //账号锁定
        if (CommonEnum.Lock_Status.getValue().equals(user.getLockFlag())) {
            throw new AuthenticationException("账号已被锁定,请联系管理员");
        }

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, accessToken, getName());
        return info;
    }
}
