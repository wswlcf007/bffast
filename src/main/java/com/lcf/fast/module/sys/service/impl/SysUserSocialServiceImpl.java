package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.constant.RCodeEnum;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.dao.SysUserSocialDao;
import com.lcf.fast.module.sys.model.dto.SysUserSocialDTO;
import com.lcf.fast.module.sys.model.entity.SysUserSocialEntity;
import com.lcf.fast.module.sys.service.SysUserSocialService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service("sysUserSocialService")
@AllArgsConstructor
public class SysUserSocialServiceImpl extends ServiceImpl<SysUserSocialDao, SysUserSocialEntity> implements SysUserSocialService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");
        String size = (String) params.get("size");
        Page<SysUserSocialEntity> query = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));
        try {
            List<SysUserSocialDTO> list = baseMapper.getSocialPage(query, params);
            return new PageUtils(list, query.getTotal(), query.getSize(), query.getCurrent());
        } catch (Exception e) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(),
                    "系统异常，请稍候重试");
        }
    }

    @Override
    public List<SysUserSocialEntity> queryList(Map<String, Object> params) {
        try {
            return baseMapper.selectList(new QueryWrapper<>());
        } catch (Exception e) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(),
                    "系统异常，请稍候重试");
        }
    }

}
