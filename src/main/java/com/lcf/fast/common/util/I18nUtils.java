package com.lcf.fast.common.util;

import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

/**
 * i18n 工具类
 *
 * @author lcf
 * @date 2020-07-08 14:26
 */
@Component
public class I18nUtils {
    private MessageSource messageSource;

    public I18nUtils(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    public String getMessage(String msgKey, Object[] args) {
        return messageSource.getMessage(msgKey, args, LocaleContextHolder.getLocale());
    }

    public String getMessage(String msgKey) {
        return messageSource.getMessage(msgKey, null, LocaleContextHolder.getLocale());
    }
}
