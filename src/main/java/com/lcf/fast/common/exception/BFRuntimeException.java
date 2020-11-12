package com.lcf.fast.common.exception;

import com.lcf.fast.common.constant.RCodeEnum;
import lombok.Getter;

/**
 * 自定义运行时异常
 *
 * @author lcf
 * @date 2020/4/7 15:05
 */
@Getter
public class BFRuntimeException extends RuntimeException {
    /**
     * 自定义错误码
     */
    private int code;
    /**
     * 自定义debug信息，控制台打印，协助定位异常
     */
    private String debugMsg;

    public BFRuntimeException(String message) {
        super(message);
        this.code = RCodeEnum.Error.getCode();
    }

    public BFRuntimeException(int code, String message) {
        super(message);
        this.code = code;
        this.debugMsg = message;
    }

    public BFRuntimeException(String message, String debugMsg) {
        super(message);
        this.code = RCodeEnum.Error.getCode();
        this.debugMsg = debugMsg;
    }

    public BFRuntimeException(int code, String message, String debugMsg) {
        super(message);
        this.code = code;
        this.debugMsg = debugMsg;
    }
}
