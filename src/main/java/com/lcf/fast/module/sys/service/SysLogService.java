package com.lcf.fast.module.sys.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.entity.SysLogEntity;

import java.util.Map;


/**
 * 系统日志
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
public interface SysLogService extends IService<SysLogEntity> {

    PageUtils queryPage(Map<String, Object> params);

}
