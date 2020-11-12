package com.lcf.fast.common.constant;

/**
 * 社交账户登录信息 枚举
 *
 * @author lcf
 * @date 2020/7/20
 */
public enum SocialLoginEnum {

    /**
     * 微信 appId
     */
    Wei_Xin_App_Id("wx3f848a5523552edc"),
    /**
     * 微信 appSecret
     */
    Wei_Xin_App_Secret("1151a40ed4ba076166060e1d39f67ade"),
    /**
     * 获取微信用户url
     * GET https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
     */
    Wei_Xin_User_Info("https://api.weixin.qq.com/sns/userinfo"),
    /**
     * QQ appId
     */
    QQ_App_Id("101789263"),
    /**
     * QQ appKey
     */
    QQ_App_Key("dc4dfdac5fba398e14b87bcbe5aa2b7e"),
    /**
     * 获取qq用户url
     * https://graph.qq.com/user/get_user_info?access_token=sdfs&oauth_consumer_key=12345&openid=12312
     */
    QQ_User_Info("https://graph.qq.com/user/get_user_info"),
    /**
     * 获取微博用户url
     */
    WEI_BO_User_Info("https://api.weibo.com/2/users/show.json"),
    /**
     * mob短信url
     */
    Mobile_Url("https://webapi.sms.mob.com/sms/verify");


    private String value;

    SocialLoginEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
