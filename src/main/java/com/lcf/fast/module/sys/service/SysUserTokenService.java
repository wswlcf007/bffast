package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.module.sys.model.entity.SysUserTokenEntity;
import com.lcf.fast.module.sys.model.vo.TokenVO;

/**
 * 用户Token
 *
 * @author lcf
 * @date 2020/4/7 15:45
 */
public interface SysUserTokenService extends IService<SysUserTokenEntity> {

    /**
     * 生成token
     *
     * @param userId 用户ID
     */
    TokenVO createToken(long userId);

    /**
     * 退出，修改token值
     *
     * @param userId 用户ID
     */
    void logout(long userId);

}
