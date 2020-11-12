package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lcf.fast.module.sys.model.entity.SysVersionEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 版本管理
 *
 * @author lcf
 * @date 2019-10-09 14:14:20
 */
@Mapper
public interface SysVersionDao extends BaseMapper<SysVersionEntity> {

    /**
     * 将当前最新版本更新为历史版本
     *
     * @return
     */
    void updateCurrent(String clientType);

    /**
     * 查询最新版本
     *
     * @return
     */
    SysVersionEntity selectCurrentVersion(String clientType);
}
