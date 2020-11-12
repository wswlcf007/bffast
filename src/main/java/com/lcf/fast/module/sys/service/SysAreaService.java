package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.entity.SysAreaEntity;

import java.util.List;
import java.util.Map;

/**
 * 系统_中国行政区划
 *
 * @author lcf
 * @date 2019-06-20 16:49:42
 */
public interface SysAreaService extends IService<SysAreaEntity> {
    /**
     * 分页查询
     *
     * @param params
     * @return
     */
    PageUtils queryPage(Map<String, Object> params);

    /**
     * 不分页查询
     *
     * @param params
     * @return
     */
    List<SysAreaEntity> queryList(Map<String, Object> params);
}
