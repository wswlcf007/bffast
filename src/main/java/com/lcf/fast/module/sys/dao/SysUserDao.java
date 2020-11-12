package com.lcf.fast.module.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lcf.fast.module.sys.model.dto.SysUserDTO;
import com.lcf.fast.module.sys.model.dto.SysUserLastTimeDTO;
import com.lcf.fast.module.sys.model.dto.SysUserLockDTO;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.model.vo.SysUserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 系统用户
 *
 * @author lcf
 */
@Mapper
public interface SysUserDao extends BaseMapper<SysUserEntity> {

    /**
     * 分页查询所有
     *
     * @param page
     * @param params
     * @return
     */
    List<SysUserVO> selectAllPageList(Page page, @Param("params") Map<String, Object> params);


    /**
     * 查询用户的所有权限
     *
     * @param userId 用户ID
     */
    List<String> queryAllPerms(Long userId);

    /**
     * 根据用户名，查询系统用户
     */
    SysUserEntity queryByUserName(String username);

    /**
     * 更新用户锁定状态
     *
     * @param dto
     */
    void updateUserLockStatus(SysUserLockDTO dto);

    /**
     * 更新用户上次登录时间
     *
     * @param dto
     */
    void updateUserLastTime(SysUserLastTimeDTO dto);

    /**
     * 根据id查询
     *
     * @param userId
     * @return
     */
    SysUserDTO queryUserById(Long userId);


    /**
     * 三方用户
     *
     * @param userId
     * @return
     */
    SysUserDTO querySocialUserById(Long userId);
}
