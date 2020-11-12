package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lcf.fast.module.sys.model.entity.SysDict;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 字典表
 *
 * @author lcf
 * @date 2019/2/1
 */
@Mapper
public interface SysDictDao extends BaseMapper<SysDict> {

    /**
     * 自定义分页查询
     *
     * @param page
     * @param params
     * @return
     */
    List<SysDict> selectPageList(Page page, @Param("params") Map<String, Object> params);
}
