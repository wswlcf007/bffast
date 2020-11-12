package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.dao.SysDictDao;
import com.lcf.fast.module.sys.model.entity.SysDict;
import com.lcf.fast.module.sys.service.SysDictService;
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
public class SysDictServiceImpl extends ServiceImpl<SysDictDao, SysDict> implements SysDictService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");//每页记录数
        String size = (String) params.get("size");//当前页
        Page<SysDict> pagination = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));

        //自定义分页查询
        List<SysDict> list = baseMapper.selectPageList(pagination, params);
        return new PageUtils(list, pagination.getTotal(), pagination.getSize(), pagination.getCurrent());
    }

    @Override
    public List<SysDict> queryList(Map<String, Object> params) {
        String type = (String) params.get("type");
        return baseMapper.selectList(
                new QueryWrapper<SysDict>()
                        .eq(StrUtil.isNotBlank(type), "type", type)
        );
    }
}
