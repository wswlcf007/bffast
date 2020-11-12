package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;
import com.lcf.fast.module.sys.model.entity.SysUserRoleEntity;

import java.util.List;


/**
 * 用户与角色对应关系
 *
 * @author lcf
 * @date 2020/4/7 15:45
 */
public interface SysUserRoleService extends IService<SysUserRoleEntity> {
	
	void saveOrUpdate(Long userId, Integer roleId);
	
	/**
	 * 根据用户ID，获取角色ID列表
	 */
	List<Integer> queryRoleIdList(Long userId);

	/**
	 * 根据用户ID，获取角色ID列表
	 */
	SysRoleEntity queryRole(Long userId);

	/**
	 * 根据角色ID数组，批量删除
	 */
	int deleteBatch(Long[] roleIds);

	/**
	 * 根据用户Id删除该用户的角色关系
	 *
	 * @param userId 用户ID
	 * @return boolean
	 * @author 寻欢·李
	 * @date 2017年12月7日 16:31:38
	 */
	Boolean removeRoleByUserId(Long userId);
}
