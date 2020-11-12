package com.lcf.fast.common.exception;

import com.lcf.fast.common.constant.RCodeEnum;
import com.lcf.fast.common.model.ResultDTO;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.AuthorizationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.NoHandlerFoundException;

/**
 * 异常处理器
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@RestControllerAdvice
@Slf4j
public class BFExceptionHandler {
    /**
     * 处理自定义异常
     */
    @ExceptionHandler(BFRuntimeException.class)
    public ResultDTO handleRRException(BFRuntimeException e) {
        log.error("自定义异常信息ex=[{}]", e.getDebugMsg());
        return ResultDTO.error(e.getCode(), e.getMessage());
    }

    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ResultDTO handlerRequestMethodNotSupportedException(Exception e) {
        log.error(e.getMessage(), e);
        return ResultDTO.error(RCodeEnum.Method_Not_Supported.getCode(), e.getMessage());
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    public ResultDTO handlerNoFoundException(Exception e) {
        log.error(e.getMessage(), e);
        return ResultDTO.error(RCodeEnum.Path_Not_Found.getCode(), "路径不存在，请检查路径是否正确");
    }

    @ExceptionHandler(DuplicateKeyException.class)
    public ResultDTO handleDuplicateKeyException(DuplicateKeyException e) {
        log.error(e.getMessage(), e);
        return ResultDTO.error(RCodeEnum.Data_Duplicate_Key.getCode(), "数据库中已存在该记录");
    }

    @ExceptionHandler(AuthorizationException.class)
    public ResultDTO handleAuthorizationException(AuthorizationException e) {
        log.error(e.getMessage(), e);
        return ResultDTO.error(RCodeEnum.Permission_Denied.getCode(), "没有权限，请联系管理员授权");
    }

    @ExceptionHandler(Exception.class)
    public ResultDTO handleException(Exception e) {
        log.error(e.getMessage(), e);
        return ResultDTO.error(RCodeEnum.Error.getCode(), "服务异常,请稍候重试");
    }
}
