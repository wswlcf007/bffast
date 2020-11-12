package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.dao.SysVersionDao;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.model.entity.SysVersionEntity;
import com.lcf.fast.module.sys.service.SysVersionService;
import lombok.AllArgsConstructor;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service("sysVersionService")
@AllArgsConstructor
public class SysVersionServiceImpl extends ServiceImpl<SysVersionDao, SysVersionEntity> implements SysVersionService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");
        String size = (String) params.get("size");
        String clientType = (String) params.get("clientType");
        String versionName = (String) params.get("versionName");
        Page<SysVersionEntity> query = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));
        IPage<SysVersionEntity> pagination = baseMapper.selectPage(query,
                new QueryWrapper<SysVersionEntity>()
                        .eq(StrUtil.isNotBlank(versionName), "version_name", versionName)
                        .eq(StrUtil.isNotBlank(clientType), "client_type", clientType)
                        .orderByDesc("create_time")
        );
        return new PageUtils(pagination);
    }

    @Override
    public List<SysVersionEntity> queryList(Map<String, Object> params) {
        return baseMapper.selectList(new QueryWrapper<>());
    }

    @Override
    public Boolean codeVersion(Map<String, Object> params) {
        String version = (String) params.get("version");
        if (StrUtil.isBlank(version)) {
            return false;
        }
        //客户端使用的版本
        Integer clientVersion = Integer.parseInt(version);
        SysVersionEntity currentEntity = baseMapper.selectOne(new QueryWrapper<SysVersionEntity>()
                .eq("is_current", "1"));
        if (currentEntity == null) {
            return false;
        } else {
            Long curVersion = currentEntity.getVersion();
            return curVersion > clientVersion;
        }
    }

    @Override
    public void saveVersion(SysVersionEntity versionEntity) {
        try {
            //验证版本名称是否已存在
            int count = baseMapper.selectCount(new QueryWrapper<SysVersionEntity>().eq("version_name", versionEntity.getVersionName()));
            if (count > 0) {
                throw new BFRuntimeException("当前版本名称已存在");
            }
            //当前最新版本
            String clientType = versionEntity.getClientType();
            baseMapper.updateCurrent(clientType);
            versionEntity.setCreateTime(System.currentTimeMillis() / 1000);
            SysUserEntity user = (SysUserEntity) SecurityUtils.getSubject().getPrincipal();
            String name = user.getName();
            Long id = user.getUserId();
            versionEntity.setCreateUser(id);
            versionEntity.setCreateUserName(name);
            versionEntity.setIsCurrent("1");
            baseMapper.insert(versionEntity);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试");
        }
    }

    @Override
    public SysVersionEntity getCurrentVersion(String clientType) {
        try {
            return baseMapper.selectCurrentVersion(clientType);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试");
        }
    }
}
