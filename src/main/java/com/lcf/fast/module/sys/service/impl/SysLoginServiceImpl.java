package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.code.kaptcha.Producer;
import com.lcf.fast.common.constant.*;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.common.util.PasswordUtils;
import com.lcf.fast.common.util.SmsUtils;
import com.lcf.fast.module.redis.RedisService;
import com.lcf.fast.module.sys.model.dto.*;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.model.entity.SysUserSocialEntity;
import com.lcf.fast.module.sys.model.vo.TokenVO;
import com.lcf.fast.module.sys.service.SysLoginService;
import com.lcf.fast.module.sys.service.SysUserService;
import com.lcf.fast.module.sys.service.SysUserSocialService;
import com.lcf.fast.module.sys.service.SysUserTokenService;
import com.vdurmont.emoji.EmojiParser;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.awt.image.BufferedImage;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

/**
 * 登录
 *
 * @author lcf
 * @date 2020-07-17 17:28
 */
@Service("sysLoginService")
@AllArgsConstructor
@Slf4j
public class SysLoginServiceImpl implements SysLoginService {
    private SysUserService sysUserService;
    private SysUserSocialService sysUserSocialService;
    private SysUserTokenService sysUserTokenService;
    private Producer producer;
    private RedisService redisService;
    private RestTemplate restTemplate;

    @Override
    public BufferedImage getCaptcha(String uuid) {
        if (StrUtil.isBlank(uuid)) {
            throw new BFRuntimeException("uuid不能为空");
        }
        //生成文字验证码
        String code = producer.createText();
        BufferedImage image = producer.createImage(code);

        redisService.set(RedisKeyEnum.Captcha_Code.getValue() + uuid, code, 120);
        return image;
    }

    @Override
    public boolean validate(String uuid, String code) {
        String key = RedisKeyEnum.Captcha_Code.getValue() + uuid;
        if (!redisService.hasKey(key)) {
            return false;
        }
        String redisCode = redisService.get(key);
        if (StrUtil.isBlank(redisCode)) {
            redisService.del(key);
        }
        if (!StrUtil.equalsIgnoreCase(redisCode, code)) {
            redisService.del(key);
            return false;
        }
        redisService.del(key);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public TokenVO login(SysLoginDTO sysLoginDTO) {
        String client = sysLoginDTO.getClient();
        //用户信息
        SysUserEntity user = sysUserService.queryByUserName(sysLoginDTO.getUsername());
        if (user == null) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(), "账号或密码不正确");
        }
        String roleCode = user.getRoleCode();
        String password = sysLoginDTO.getPassword();
        if (StrUtil.isBlank(password) || StrUtil.isBlank(roleCode)) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(), "账号或密码不正确");
        }
        if (!ClientTypeEnum.APP.getValue().equalsIgnoreCase(client)) {
            boolean validate = validate(sysLoginDTO.getUuid(), sysLoginDTO.getCaptcha());
            if (!validate) {
                throw new BFRuntimeException("验证码不合法");
            }
        }

        String decryptStr = PasswordUtils.decryptAES(password, CommonEnum.Security_Encode_Key.getValue());
        //账号不存在、密码错误
        if (!user.getPassword().equals(new Sha256Hash(decryptStr, user.getSalt()).toHex())) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(), "账号或密码不正确");
        }

        //账号锁定
        if (CommonEnum.Lock_Status.getValue().equals(user.getLockFlag())) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(), "账号已被锁定,请联系管理员");
        }

        //登录成功，更新上次登录时间
        SysUserLastTimeDTO sysUserLastTimeDTO = new SysUserLastTimeDTO();
        sysUserLastTimeDTO.setId(user.getUserId());
        sysUserLastTimeDTO.setLastTime(System.currentTimeMillis() / 1000);
        sysUserService.updateUserLastTime(sysUserLastTimeDTO);

        return sysUserTokenService.createToken(user.getUserId());
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    public TokenVO socialLogin(SysLoginSocialDTO sysLoginDTO) {
        String openId = sysLoginDTO.getOpenId();
        String accessToken = sysLoginDTO.getAccessToken();
        String providerId = sysLoginDTO.getProviderId();
        String name = "";
        String imgUrl = "";
        //微信拉取用户信息
        if (SocialTypeEnum.WEI_XIN.getValue().equalsIgnoreCase(providerId)) {
            String url = SocialLoginEnum.Wei_Xin_User_Info.getValue() + "?access_token=" + accessToken + "&openid=" + openId;
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);
            if (responseEntity.getStatusCodeValue() != 200) {
                throw new BFRuntimeException("无法获取微信用户信息");
            }
            String body = responseEntity.getBody();
            if (StrUtil.isBlank(body)) {
                throw new BFRuntimeException("无法获取微信用户信息");
            }
            JSONObject jsonObject = JSONObject.parseObject(body);
            if (jsonObject == null || jsonObject.get("errcode") != null) {
                throw new BFRuntimeException("无法获取微信用户信息");
            }
            name = (String) jsonObject.get("nickname");
            name = new String(name.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            name = EmojiParser.parseToHtmlDecimal(name);
            imgUrl = (String) jsonObject.get("headimgurl");
        } else if (SocialTypeEnum.QQ.getValue().equalsIgnoreCase(providerId)) {
            //QQ用户信息
            String url = SocialLoginEnum.QQ_User_Info.getValue() + "?access_token={accessToken}&openid={openId}&oauth_consumer_key={oauth_consumer_key}";
            Map<String, Object> params = new HashMap<>();
            params.put("accessToken", accessToken);
            params.put("openId", openId);
            params.put("oauth_consumer_key", SocialLoginEnum.QQ_App_Id.getValue());
            //QQ返回的用户信息
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class, params);
            if (responseEntity.getStatusCodeValue() != 200) {
                throw new BFRuntimeException("无法获取QQ用户信息");
            }
            String body = responseEntity.getBody();
            if (StrUtil.isBlank(body)) {
                throw new BFRuntimeException("无法获取QQ用户信息");
            }
            JSONObject jsonObject = JSONObject.parseObject(body);
            if (jsonObject == null || (int) jsonObject.get("ret") != 0) {
                throw new BFRuntimeException("无法获取QQ用户信息");
            }
            name = (String) jsonObject.get("nickname");
            name = new String(name.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            name = EmojiParser.parseToHtmlDecimal(name);
            imgUrl = (String) jsonObject.get("figureurl");
        } else if (SocialTypeEnum.WEI_BO.getValue().equalsIgnoreCase(providerId)) {
            //微博拉取用户信息
            String url = SocialLoginEnum.WEI_BO_User_Info.getValue() + "?access_token=" + accessToken + "&uid=" + openId;
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);
            if (responseEntity.getStatusCodeValue() != 200) {
                throw new BFRuntimeException("无法获取微博用户信息");
            }
            String body = responseEntity.getBody();
            if (StrUtil.isBlank(body)) {
                throw new BFRuntimeException("无法获取微博用户信息");
            }
            JSONObject jsonObject = JSONObject.parseObject(body);
            if (jsonObject == null) {
                throw new BFRuntimeException("无法获取微博用户信息");
            }
            name = (String) jsonObject.get("screen_name");
            imgUrl = (String) jsonObject.get("profile_image_url");
        } else if (SocialTypeEnum.Apple.getValue().equalsIgnoreCase(providerId)) {
            //苹果账号
            name = "AppleID" + openId.substring(openId.length() - 4);
        }

        //根据userId(openId) 判断账号是否可用
        SysUserSocialEntity socialEntity = sysUserSocialService.getOne(new QueryWrapper<SysUserSocialEntity>()
                .eq("provider_user_id", openId)
                .eq("provider_id", providerId));
        if (socialEntity == null) {
            //未注册过则注册
            SysUserDTO sysUserDTO = new SysUserDTO();
            sysUserDTO.setRoleCode(RoleTypeEnum.SOCIAL_USER.getValue());
            sysUserDTO.setUsername(openId);
            sysUserDTO.setProviderId(providerId);
            sysUserDTO.setName(name);
            sysUserDTO.setImageUrl(imgUrl);
            sysUserDTO.setAccessToken(accessToken);
            Long userId = sysUserService.saveUser(sysUserDTO);

            return sysUserTokenService.createToken(userId);
        } else {
            Long userId = socialEntity.getUserId();
            SysUserDTO userDTO = sysUserService.getUserById(userId);
            if (CommonEnum.Lock_Status.getValue().equalsIgnoreCase(userDTO.getLockFlag())) {
                //锁定状态
                throw new BFRuntimeException("当前账号已被锁定，请联系管理员");
            }

            SysUserLastTimeDTO sysUserLastTimeDTO = new SysUserLastTimeDTO();
            sysUserLastTimeDTO.setId(userId);
            sysUserLastTimeDTO.setLastTime(System.currentTimeMillis() / 1000);
            sysUserService.updateUserLastTime(sysUserLastTimeDTO);
            if (!userDTO.getName().equalsIgnoreCase(name)) {
                SysUserDTO sysUserDTO = new SysUserDTO();
                sysUserDTO.setUserId(userId);
                sysUserDTO.setRoleCode(RoleTypeEnum.SOCIAL_USER.getValue());
                sysUserDTO.setName(name);
                sysUserDTO.setImageUrl(imgUrl);
                sysUserService.update(sysUserDTO);
            }
            return sysUserTokenService.createToken(userId);
        }
    }

    @Override
    public TokenVO mobileLogin(SysLoginMobileDTO sysLoginDTO) {
        String appKey = sysLoginDTO.getAppKey();
        String mobile = sysLoginDTO.getMobile();
        String zone = sysLoginDTO.getZone();
        String smsCode = sysLoginDTO.getSmsCode();

        String smsSend = "appkey=" + appKey + "&amp;phone=" + mobile + "&amp;zone=" + zone + "&amp;code=" + smsCode;
        String result = SmsUtils.requestData(SocialLoginEnum.Mobile_Url.getValue(), smsSend);
        String status = JSON.parseObject(result).get("status").toString();

        //验证码验证成功
        if ("200".equalsIgnoreCase(status)) {
            //判断账号是否存在
            //根据userId(openId) 判断账号是否可用
            SysUserSocialEntity socialEntity = sysUserSocialService.getOne(new QueryWrapper<SysUserSocialEntity>()
                    .eq("provider_user_id", mobile)
                    .eq("provider_id", SocialTypeEnum.Mobile.getValue()));
            if (socialEntity == null) {
                //未注册过则注册
                SysUserDTO sysUserDTO = new SysUserDTO();
                sysUserDTO.setRoleCode(RoleTypeEnum.PHONE_USER.getValue());
                sysUserDTO.setUsername(mobile);
                sysUserDTO.setProviderId(SocialTypeEnum.Mobile.getValue());
                sysUserDTO.setName("手机用户" + mobile.substring(mobile.length() - 4));
                Long userId = sysUserService.saveUser(sysUserDTO);

                SysUserLastTimeDTO sysUserLastTimeDTO = new SysUserLastTimeDTO();
                sysUserLastTimeDTO.setId(userId);
                sysUserLastTimeDTO.setLastTime(System.currentTimeMillis() / 1000);
                sysUserService.updateUserLastTime(sysUserLastTimeDTO);
                //创建消息队列 todo
                return sysUserTokenService.createToken(userId);
            } else {
                Long userId = socialEntity.getUserId();
                SysUserDTO userDTO = sysUserService.getUserById(userId);
                if (CommonEnum.Lock_Status.getValue().equalsIgnoreCase(userDTO.getLockFlag())) {
                    //锁定状态
                    throw new BFRuntimeException("当前账号已被锁定，请联系管理员");
                }
                SysUserLastTimeDTO sysUserLastTimeDTO = new SysUserLastTimeDTO();
                sysUserLastTimeDTO.setId(userId);
                sysUserLastTimeDTO.setLastTime(System.currentTimeMillis() / 1000);
                sysUserService.updateUserLastTime(sysUserLastTimeDTO);
                return sysUserTokenService.createToken(userId);
            }
            //创建消息队列 todo

        } else {
            throw new BFRuntimeException("验证码认证失败");
        }
    }

    @Override
    public void logout(Long userId) {
        sysUserTokenService.logout(userId);
    }
}
