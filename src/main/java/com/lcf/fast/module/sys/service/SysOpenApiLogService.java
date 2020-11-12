package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.entity.SysOpenApiLogEntity;

import java.util.Map;

/**
 * 系统日志-开放接口三方调用记录
 *
 * @author lcf
 * @date 2020-08-14 11:25:54
 */
public interface SysOpenApiLogService extends IService<SysOpenApiLogEntity> {

    /**
     * 自定义分页查询
     *
     * @param params
     * @return
     */
    PageUtils queryPage(Map<String, Object> params);

}

