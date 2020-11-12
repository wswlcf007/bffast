package com.lcf.fast.module.sys.model.dto;

import lombok.Data;

/**
 * 修改密码 DTO
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@Data
public class PasswordDTO {
    /**
     * 原密码
     */
    private String password;
    /**
     * 新密码
     */
    private String newPassword;

}
