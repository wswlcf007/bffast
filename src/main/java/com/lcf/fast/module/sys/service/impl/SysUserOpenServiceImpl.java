package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.dao.SysUserOpenDao;
import com.lcf.fast.module.sys.model.entity.SysUserOpenEntity;
import com.lcf.fast.module.sys.service.SysUserOpenService;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;


@Service("sysUserOpenService")
public class SysUserOpenServiceImpl extends ServiceImpl<SysUserOpenDao, SysUserOpenEntity> implements SysUserOpenService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");
        String size = (String) params.get("size");
        String companyName = (String) params.get("companyName");
        String openKey = (String) params.get("openKey");
        String isLock = (String) params.get("isLock");
        Page<SysUserOpenEntity> page = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));
        try {
            IPage<SysUserOpenEntity> iPage = baseMapper.selectPage(page,
                    new QueryWrapper<SysUserOpenEntity>()
                            .like(StrUtil.isNotBlank(companyName), "company_name", companyName)
                            .like(StrUtil.isNotBlank(openKey), "open_key", openKey)
                            .eq(StrUtil.isNotBlank(isLock), "is_lock", isLock)
            );
            return new PageUtils(iPage);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试");
        }
    }

    @Override
    public List<SysUserOpenEntity> queryList(Map<String, Object> params) {
        try {
            return baseMapper.selectList(new QueryWrapper<SysUserOpenEntity>());
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试");
        }
    }

    @Override
    public SysUserOpenEntity getOneById(Long id) {
        try {
            return baseMapper.selectById(id);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试");
        }
    }

    @Override
    public void saveSysUserOpen(SysUserOpenEntity entity) {
        try {
            //生成openKey openSecret
            //openKey=random(6)
            //openSecret=MD5(openKey+timestamp)
            String openKey = RandomUtil.randomString(16);
            long timestamp = System.currentTimeMillis();
            String openSecret = SecureUtil.md5(openKey + timestamp);
            entity.setOpenKey(openKey);
            entity.setOpenSecret(openSecret);
            entity.setCreateTime(new Date());
            baseMapper.insert(entity);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试");
        }
    }

    @Override
    public void updateSysUserOpen(SysUserOpenEntity entity) {
        SysUserOpenEntity checkEntity = baseMapper.selectById(entity.getId());
        if (checkEntity == null) {
            throw new BFRuntimeException("当前数据不存在,更新失败");
        }
        try {
            baseMapper.updateById(entity);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常,请稍候重试");
        }
    }

    @Override
    public void removeSysUserOpen(Long[] ids) {
        try {
            baseMapper.deleteBatchIds(Arrays.asList(ids));
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试");
        }
    }
}
