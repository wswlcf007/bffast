package com.lcf.fast.common.model;

import com.lcf.fast.common.constant.CommonEnum;
import com.lcf.fast.common.constant.RCodeEnum;
import lombok.Getter;
import lombok.Setter;

/**
 * 公共返回格式DTO
 *
 * @author lcf
 * @date 2020/4/7 15:25
 */
@Getter
@Setter
public class ResultDTO<T> {
    private int code;
    private String msg;
    private T data;

    public ResultDTO() {
    }

    public ResultDTO(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public ResultDTO(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static ResultDTO ok() {
        return new ResultDTO(RCodeEnum.Success_Code.getCode(), CommonEnum.Success_Msg.getValue());
    }

    public static <T> ResultDTO ok(T data) {
        return new ResultDTO(RCodeEnum.Success_Code.getCode(), CommonEnum.Success_Msg.getValue(), data);
    }

    public static ResultDTO error(int code, String msg) {
        return new ResultDTO(code, msg);
    }
}
