package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.dao.SysOpenApiLogDao;
import com.lcf.fast.module.sys.model.entity.SysOpenApiLogEntity;
import com.lcf.fast.module.sys.service.SysOpenApiLogService;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service("sysOpenApiLogService")
public class SysOpenApiLogServiceImpl extends ServiceImpl<SysOpenApiLogDao, SysOpenApiLogEntity> implements SysOpenApiLogService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");
        String size = (String) params.get("size");
        String openKey = (String) params.get("openKey");
        String startTime = (String) params.get("startTime");
        String endTime = (String) params.get("endTime");
        if(StrUtil.isBlank(openKey)){
            throw new BFRuntimeException("参数错误，请检查输入参数");
        }
        Page<SysOpenApiLogEntity> page = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));
        try {
            IPage<SysOpenApiLogEntity> iPage = baseMapper.selectPage(page,
                    new QueryWrapper<SysOpenApiLogEntity>()
                            .eq("open_key",openKey)
                            .between(StrUtil.isNotBlank(startTime) && StrUtil.isNotBlank(endTime), "create_time", startTime, endTime)
            );
            return new PageUtils(iPage);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试");
        }
    }

}
