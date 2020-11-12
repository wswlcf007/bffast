package com.lcf.fast.module.sys.model.dto;

import lombok.Getter;
import lombok.Setter;

/**
 * 第三方 QQ账户
 *
 * @author lcf
 * @date 2020/7/20
 */
@Getter
@Setter
public class QQUserDTO {

    /**
     * 返回码
     */
    private Integer ret;
    /**
     * 如果ret<0，会有相应的错误信息提示，返回数据全部用UTF-8编码。
     */
    private String msg;
    /**
     * 性别。 如果获取不到则默认返回”男”
     */
    private String gender;
    /**
     * 大小为30×30像素的QQ空间头像URL。
     */
    private String figureurl;
    /**
     * 大小为50×50像素的QQ空间头像URL。
     */
    private String figureurl_1;
    /**
     * 大小为100×100像素的QQ空间头像URL。
     */
    private String figureurl_2;
    /**
     * 大小为40×40像素的QQ头像URL。
     */
    private String figureurl_qq_1;
    /**
     * 大小为100×100像素的QQ头像URL。需要注意，不是所有的用户都拥有QQ的100×100的头像，但40×40像素则是一定会有。
     */
    private String figureurl_qq_2;
}
