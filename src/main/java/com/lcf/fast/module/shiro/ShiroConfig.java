package com.lcf.fast.module.shiro;

import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import javax.servlet.Filter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * shiro配置类
 *
 * @author lcf
 * @date 2020/4/7 15:45
 */
@Configuration
public class ShiroConfig {

    /**
     * 安全认证管理器
     *
     * @param ZWCustomRealm
     * @return
     */
    @Bean("securityManager")
    public SecurityManager securityManager(ZWCustomRealm ZWCustomRealm) {
        DefaultWebSecurityManager defaultWebSecurityManager = new DefaultWebSecurityManager();
        //自定义Realm
        defaultWebSecurityManager.setRealm(ZWCustomRealm);
        //记住登录
        defaultWebSecurityManager.setRememberMeManager(null);
        return defaultWebSecurityManager;
    }

    /**
     * shiro 过滤器
     *
     * @param securityManager
     * @return
     */
    @Bean("shiroFilter")
    public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(securityManager);
//        shiroFilterFactoryBean.setLoginUrl("/login");
//        shiroFilterFactoryBean.setUnauthorizedUrl("/notRole");

        // 使用oauth2过滤
        Map<String, Filter> filters = new HashMap<>();
        filters.put("oauth2", new ZWCustomAuthenticatingFilter());
        shiroFilterFactoryBean.setFilters(filters);

        Map<String, String> filterMap = new LinkedHashMap<>();
        filterMap.put("/webjars/**", "anon");
        filterMap.put("/ws/**", "anon");
        filterMap.put("/druid/**", "anon");
        filterMap.put("/sys/login/**", "anon");
        filterMap.put("/open/**", "anon");
        //线上打包注释以下4项
        filterMap.put("/swagger/**", "anon");
        filterMap.put("/v2/api-docs", "anon");
        filterMap.put("/swagger-ui.html", "anon");
        filterMap.put("/swagger-resources/**", "anon");
        filterMap.put("/captcha.jpg", "anon");
        filterMap.put("/**", "oauth2");
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterMap);

        return shiroFilterFactoryBean;
    }

    /**
     * @return
     */
    @Bean("lifecycleBeanPostProcessor")
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    /**
     * 开启Shiro的注解(如@RequiresRoles,@RequiresPermissions)
     * DefaultAdvisorAutoProxyCreator(可选)
     *
     * @return
     */
    @Bean
    @DependsOn({"lifecycleBeanPostProcessor"})
    public DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator() {
        DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
        advisorAutoProxyCreator.setProxyTargetClass(true);
        return advisorAutoProxyCreator;
    }

    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager) {
        AuthorizationAttributeSourceAdvisor advisor = new AuthorizationAttributeSourceAdvisor();
        advisor.setSecurityManager(securityManager);
        return advisor;
    }
}
