package com.lcf.fast.module.sys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.module.shiro.TokenGenerator;
import com.lcf.fast.module.sys.dao.SysUserTokenDao;
import com.lcf.fast.module.sys.model.entity.SysUserTokenEntity;
import com.lcf.fast.module.sys.model.vo.TokenVO;
import com.lcf.fast.module.sys.service.SysUserTokenService;
import org.springframework.stereotype.Service;

import java.util.Date;


@Service("sysUserTokenService")
public class SysUserTokenServiceImpl extends ServiceImpl<SysUserTokenDao, SysUserTokenEntity> implements SysUserTokenService {
    //12小时后过期
    private final static int EXPIRE = 3600 * 12;


    @Override
    public TokenVO createToken(long userId) {
        //生成一个token
        String token = TokenGenerator.generateValue();

        //当前时间
        Date now = new Date();
        //过期时间
        Date expireTime = new Date(now.getTime() + EXPIRE * 1000);

        try {
            //判断是否生成过token
            SysUserTokenEntity tokenEntity = this.getById(userId);
            if (tokenEntity == null) {
                tokenEntity = new SysUserTokenEntity();
                tokenEntity.setUserId(userId);
                tokenEntity.setToken(token);
                tokenEntity.setUpdateTime(now);
                tokenEntity.setExpireTime(expireTime);

                //保存token
                this.save(tokenEntity);
            } else {
                tokenEntity.setToken(token);
                tokenEntity.setUpdateTime(now);
                tokenEntity.setExpireTime(expireTime);

                //更新token
                this.updateById(tokenEntity);
            }
        } catch (Exception e) {
            throw new BFRuntimeException("生成token失败", e.getMessage());
        }
        TokenVO tokenVO = new TokenVO();
        tokenVO.setToken(token);
        tokenVO.setExpire(EXPIRE);
        return tokenVO;
    }

    @Override
    public void logout(long userId) {
        //生成一个token
        String token = TokenGenerator.generateValue();

        //修改token
        SysUserTokenEntity tokenEntity = new SysUserTokenEntity();
        tokenEntity.setUserId(userId);
        tokenEntity.setToken(token);
        this.updateById(tokenEntity);
    }
}
