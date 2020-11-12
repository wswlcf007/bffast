package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lcf.fast.module.sys.model.dto.SysUserSocialDTO;
import com.lcf.fast.module.sys.model.entity.SysUserSocialEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * 社交账户表
 *
 * @author lcf
 * @date 2019-09-20 09:43:52
 */
@Mapper
public interface SysUserSocialDao extends BaseMapper<SysUserSocialEntity> {

    List<SysUserSocialDTO> getSocialPage(Page<SysUserSocialEntity> query, Map<String, Object> params);
}
