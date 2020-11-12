package com.lcf.fast.module.sys.service;


import com.lcf.fast.module.sys.model.dto.SysLoginDTO;
import com.lcf.fast.module.sys.model.dto.SysLoginMobileDTO;
import com.lcf.fast.module.sys.model.dto.SysLoginSocialDTO;
import com.lcf.fast.module.sys.model.vo.TokenVO;

import java.awt.image.BufferedImage;


/**
 * 登录
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
public interface SysLoginService {
    /**
     * 获取图片验证码
     */
    BufferedImage getCaptcha(String uuid);

    /**
     * 验证码效验
     *
     * @param uuid uuid
     * @param code 验证码
     * @return true：成功  false：失败
     */
    boolean validate(String uuid, String code);

    /**
     * 登录
     *
     * @param sysLoginDTO
     */
    TokenVO login(SysLoginDTO sysLoginDTO);

    /**
     * 社交账户(三方)登录
     *
     * @param sysLoginDTO
     */
    TokenVO socialLogin(SysLoginSocialDTO sysLoginDTO);

    /**
     * 手机号登录
     *
     * @param sysLoginDTO
     */
    TokenVO mobileLogin(SysLoginMobileDTO sysLoginDTO);

    /**
     * 退出
     *
     * @param userId
     */
    void logout(Long userId);

}
