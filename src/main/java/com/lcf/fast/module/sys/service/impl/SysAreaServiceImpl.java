package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.dao.SysAreaDao;
import com.lcf.fast.module.sys.model.entity.SysAreaEntity;
import com.lcf.fast.module.sys.service.SysAreaService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 系统_中国行政区划
 *
 * @author lcf
 * @date 2019-06-20 16:49:42
 */
@Service("sysAreaService")
public class SysAreaServiceImpl extends ServiceImpl<SysAreaDao, SysAreaEntity> implements SysAreaService {


    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");
        String size = (String) params.get("size");
        Page<SysAreaEntity> query = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));
        IPage<SysAreaEntity> pagination = baseMapper.selectPage(query,
                new QueryWrapper<>()
        );
        return new PageUtils(pagination.getRecords(), pagination.getTotal(), pagination.getSize(), pagination.getCurrent());
    }

    @Override
    public List<SysAreaEntity> queryList(Map<String, Object> params) {
        String id = (String) params.get("id");

        return baseMapper.selectList(
                new QueryWrapper<SysAreaEntity>()
                        .eq(StringUtils.isBlank(id), "pid", -1)
                        .eq(StringUtils.isNotBlank(id), "pid", id)

        );
    }
}
