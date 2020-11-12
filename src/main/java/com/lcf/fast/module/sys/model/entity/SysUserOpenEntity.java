package com.lcf.fast.module.sys.model.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * 三方接口开放用户表
 *
 * @author lcf
 * @date 2020-10-30 17:31:52
 */
@TableName("sys_user_open")
@Getter
@Setter
public class SysUserOpenEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键id
	 */
	@TableId
	private Long id;
	/**
	 * 开放账户key
	 */
	private String openKey;
	/**
	 * 开放账户secret
	 */
	private String openSecret;
	/**
	 * 开放账户id集
	 */
	private String openIp;
	/**
	 * 公司名称
	 */
	private String companyName;
	/**
	 * 联系人
	 */
	private String contact;
	/**
	 * 联系电话
	 */
	private String contactNumber;
	/**
	 * 商务对接人
	 */
	private String businessMan;
	/**
	 * 是否锁定 0-否 1-是
	 */
	private String isLock;
	/**
	 * 是否删除 0-否 1-是
	 */
	private String isDel;
	/**
	 * 创建时间
	 */
	private Date createTime;

}
