package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;

import java.util.List;
import java.util.Map;


/**
 * 角色
 *
 * @author lcf
 * @date 2020/4/7 15:45
 */
public interface SysRoleService extends IService<SysRoleEntity> {

	/**
	 * 分页查询
	 * @param params
	 * @return
	 */
	PageUtils queryPage(Map<String, Object> params);

	/**
	 * 不分页查询
	 * @param params
	 * @return
	 */
	List<SysRoleEntity> queryList(Map<String, Object> params);

	void saveRole(SysRoleEntity role);

	void update(SysRoleEntity role);

	void deleteBatch(Long[] roleIds);

	
	/**
	 * 查询用户创建的角色ID列表
	 */
	List<Long> queryRoleIdList(Long createUserId);
}
