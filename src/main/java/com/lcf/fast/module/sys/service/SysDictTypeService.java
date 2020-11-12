package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.entity.SysDictType;

import java.util.List;
import java.util.Map;

/**
 * 字典表类型 服务类
 *
 * @author lcf
 * @date 2019/2/1
 */
public interface SysDictTypeService extends IService<SysDictType> {
    /**
     * 分页查询
     *
     * @param params
     * @return
     */
    PageUtils queryPage(Map<String, Object> params);

    List<SysDictType> queryList(Map<String, Object> params);
}
