package com.lcf.fast.module.open.controller;

import cn.hutool.core.codec.Base64;
import com.lcf.fast.common.constant.CommonEnum;
import com.lcf.fast.common.util.HttpContextUtils;

/**
 * 开放平台基础接口
 *
 * @author lcf
 * @date 2020-11-03 14:51
 */
public class OpenApiBaseController {
    protected String getOpenKey() {
        //获取 authorization
        String authorization = HttpContextUtils.getAuthorization();
        String[] split = authorization.split(CommonEnum.Open_Api_Sign.getValue());
        String basic = split[0].split(CommonEnum.Open_Api_Basic.getValue())[1];
        basic = Base64.decodeStr(basic);
        String[] basicSplit = basic.split(":");
        String openKey = basicSplit[0];
        return openKey;
    }
}
