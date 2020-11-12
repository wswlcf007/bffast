package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.dao.SysLogDao;
import com.lcf.fast.module.sys.model.entity.SysLogEntity;
import com.lcf.fast.module.sys.service.SysLogService;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service("sysLogService")
public class SysLogServiceImpl extends ServiceImpl<SysLogDao, SysLogEntity> implements SysLogService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");
        String size = (String) params.get("size");
        String key = (String) params.get("key");
        String startTime = (String) params.get("startTime");
        String endTime = (String) params.get("endTime");
        String type = (String) params.get("type");
        Page<SysLogEntity> page = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));
        IPage<SysLogEntity> iPage = this.page(page, new QueryWrapper<SysLogEntity>()
                .like(StrUtil.isNotBlank(key), "create_by", key)
                .ge(StrUtil.isNotBlank(startTime), "create_time", startTime)
                .le(StrUtil.isNotBlank(endTime), "create_time", endTime)
                .eq(StrUtil.isNotBlank(type), "type", type)
                .orderByDesc("create_time")
        );

        return new PageUtils(iPage);
    }
}
