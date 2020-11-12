package com.lcf.fast.module.sys.model.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * token vo
 *
 * @author lcf
 * @date 2020/7/20
 */
@Getter
@Setter
public class TokenVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * token
     */
    private String token;

    /**
     * 菜单ID
     */
    private Integer expire;

}
