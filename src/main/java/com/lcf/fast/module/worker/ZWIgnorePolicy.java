package com.lcf.fast.module.worker;

import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.RejectedExecutionHandler;
import java.util.concurrent.ThreadPoolExecutor;

/**
 * 描述: 拒绝策略
 *
 * @author lcf
 * @date 2020-10-29 10:57
 */
@Slf4j
public class ZWIgnorePolicy implements RejectedExecutionHandler {
    @Override
    public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
        log.error("执行线程[{}],异常rejected", r.toString());
    }
}
