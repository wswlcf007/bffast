package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.dao.SysDictTypeDao;
import com.lcf.fast.module.sys.model.entity.SysDictType;
import com.lcf.fast.module.sys.service.SysDictTypeService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 字典表 服务实现类
 *
 * @author lcf
 * @date 2019/2/1
 */
@Service
public class SysDictTypeServiceImpl extends ServiceImpl<SysDictTypeDao, SysDictType> implements SysDictTypeService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");//每页记录数
        String size = (String) params.get("size");//当前页
        Page<SysDictType> pagination = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));
        IPage<SysDictType> iPage = baseMapper.selectPage(
                pagination,
                new QueryWrapper<SysDictType>()
        );
        return new PageUtils(iPage);
    }

    @Override
    public List<SysDictType> queryList(Map<String, Object> params) {
        return baseMapper.selectList(
                new QueryWrapper<SysDictType>()
        );
    }
}
