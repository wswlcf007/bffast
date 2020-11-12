package com.lcf.fast.module.sys.controller;

import cn.hutool.core.io.IoUtil;
import com.lcf.fast.common.annotation.SysLoginLog;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.module.sys.model.dto.SysLoginDTO;
import com.lcf.fast.module.sys.model.dto.SysLoginMobileDTO;
import com.lcf.fast.module.sys.model.dto.SysLoginSocialDTO;
import com.lcf.fast.module.sys.service.SysLoginService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * 登录登出
 *
 * @author lcf
 * @date 2019/11/8 15:51:48
 */
@Slf4j
@RestController
@AllArgsConstructor
public class SysLoginController extends BaseController {
    private SysLoginService sysLoginService;

    /**
     * 验证码
     */
    @GetMapping("captcha.jpg")
    public void captcha(HttpServletResponse response, String uuid) {
        response.setHeader("Cache-Control", "no-store, no-cache");
        response.setContentType("image/jpeg");

        //获取图片验证码
        BufferedImage image = sysLoginService.getCaptcha(uuid);

        ServletOutputStream out = null;
        try {
            out = response.getOutputStream();
            ImageIO.write(image, "jpg", out);
        } catch (IOException e) {
            log.error("输出文件流异常：" + e.getMessage());
        } finally {
            IoUtil.close(out);
        }
    }

    /**
     * 登录
     */
    @SysLoginLog("登录")
    @PostMapping("/sys/login")
    public ResultDTO login(@RequestBody SysLoginDTO sysLoginDTO) {
        return ResultDTO.ok(sysLoginService.login(sysLoginDTO));
    }

    /**
     * 三方登录
     */
    @SysLoginLog("登录")
    @PostMapping("/sys/login/social")
    public ResultDTO socialLogin(@RequestBody SysLoginSocialDTO sysLoginDTO) {
        return ResultDTO.ok(sysLoginService.socialLogin(sysLoginDTO));
    }

    /**
     * 手机号登录
     */
    @SysLoginLog("登录")
    @PostMapping("/sys/login/mobile")
    public ResultDTO mobileLogin(@RequestBody SysLoginMobileDTO sysLoginDTO) {
        return ResultDTO.ok(sysLoginService.mobileLogin(sysLoginDTO));
    }

    /**
     * 退出
     */
    @SysLoginLog("退出")
    @PostMapping("/sys/logout")
    public ResultDTO logout() {
        sysLoginService.logout(getUserId());
        return ResultDTO.ok();
    }

}
