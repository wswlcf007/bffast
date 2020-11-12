package com.lcf.fast.module.sys.service.impl;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lcf.fast.common.constant.CommonEnum;
import com.lcf.fast.common.constant.RoleTypeEnum;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.common.util.PasswordUtils;
import com.lcf.fast.module.sys.dao.SysUserDao;
import com.lcf.fast.module.sys.model.dto.*;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.model.entity.SysUserRoleEntity;
import com.lcf.fast.module.sys.model.entity.SysUserSocialEntity;
import com.lcf.fast.module.sys.model.vo.MenuVO;
import com.lcf.fast.module.sys.service.*;
import com.vdurmont.emoji.EmojiParser;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;


/**
 * 系统用户
 *
 * @author lcf
 */
@Slf4j
@Service("sysUserService")
@AllArgsConstructor
public class SysUserServiceImpl extends ServiceImpl<SysUserDao, SysUserEntity> implements SysUserService {
    private SysUserRoleService sysUserRoleService;
    private SysMenuService sysMenuService;
    private SysRoleService sysRoleService;
    private SysUserSocialService sysUserSocialService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String current = (String) params.get("current");
        String size = (String) params.get("size");
        Page<SysUserEntity> page = new Page<>(StrUtil.isBlank(current) ? 1L : Integer.parseInt(current), StrUtil.isBlank(size) ? 10L : Integer.parseInt(size));

        SysUserEntity userEntity = (SysUserEntity) SecurityUtils.getSubject().getPrincipal();
        params.put("userId", userEntity.getUserId());
        IPage<SysUserEntity> iPage = baseMapper.selectPage(page, new QueryWrapper<SysUserEntity>());
        return new PageUtils(iPage);
    }

    @Override
    public List<SysUserEntity> queryList(Map<String, Object> params) {
        String username = (String) params.get("username");
        String name = (String) params.get("name");
        String mobile = (String) params.get("mobile");
        String status = (String) params.get("status");
        Long createUserId = (Long) params.get("createUserId");
        return baseMapper.selectList(new QueryWrapper<SysUserEntity>()
                .like(StrUtil.isNotBlank(name), "name", name)
                .like(StrUtil.isNotBlank(mobile), "mobile", mobile)
                .eq(StrUtil.isNotBlank(status), "status", status)
                .eq(createUserId != null, "create_user_id", createUserId));
    }


    @Override
    public List<String> queryAllPerms(Long userId) {
        return baseMapper.queryAllPerms(userId);
    }

    @Override
    public SysUserEntity queryByUserName(String username) {
        return baseMapper.queryByUserName(username);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long saveUser(SysUserDTO user) {
        String username = user.getUsername();
        SysUserEntity userEntity = baseMapper.selectOne(new QueryWrapper<SysUserEntity>().eq("username", username));
        if (userEntity != null) {
            throw new BFRuntimeException("当前账号已存在，请重新输入");
        }
        String password = user.getPassword();
        String roleCode = user.getRoleCode();
        SysRoleEntity roleEntity = sysRoleService.getOne(new QueryWrapper<SysRoleEntity>().eq("role_code", roleCode));
        if (roleEntity == null) {
            throw new BFRuntimeException("当前角色code不存在，请稍候重试");
        }
        Integer roleId = roleEntity.getRoleId();

        SysUserEntity sysUserEntity = new SysUserEntity();
        BeanUtils.copyProperties(user, sysUserEntity);
        SysUserEntity curUser = (SysUserEntity) SecurityUtils.getSubject().getPrincipal();
        if (curUser != null) {
            sysUserEntity.setCreateUserId(curUser.getUserId());
        }
        if (StrUtil.isNotBlank(password)) {
            String salt = RandomUtil.randomNumbers(20);
            password = PasswordUtils.decryptAES(password, CommonEnum.Security_Encode_Key.getValue());
            sysUserEntity.setPassword(new Sha256Hash(password, salt).toHex());
            sysUserEntity.setSalt(salt);
        }
        sysUserEntity.setCreateTime(new Date());
        this.save(sysUserEntity);

        Long userId = sysUserEntity.getUserId();
        //判断角色
        if (RoleTypeEnum.PHONE_USER.getValue().equalsIgnoreCase(roleCode) || RoleTypeEnum.SOCIAL_USER.getValue().equalsIgnoreCase(roleCode)) {
            //三方用户
            String providerId = user.getProviderId();
            SysUserSocialEntity socialEntity = new SysUserSocialEntity();
            socialEntity.setUserId(userId);
            socialEntity.setProviderId(providerId);
            socialEntity.setProviderUserId(user.getUsername());
            socialEntity.setDisplayName(user.getName());
            socialEntity.setAccessToken(user.getAccessToken());
            socialEntity.setImageUrl(user.getImageUrl());
            sysUserSocialService.save(socialEntity);
        }

        //检查角色是否越权
//        checkRole(sysUserEntity);
        //保存用户与角色关系
        sysUserRoleService.saveOrUpdate(userId, roleId);
        return userId;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(SysUserDTO user) {
        Integer roleId = user.getRoleId();
        String roleCode = user.getRoleCode();

        SysUserEntity sysUserEntity = new SysUserEntity();
        BeanUtils.copyProperties(user, sysUserEntity);
        //判断角色
        if (RoleTypeEnum.SOCIAL_USER.getValue().equalsIgnoreCase(roleCode)) {
            //三方用户
            SysUserSocialEntity socialEntity = new SysUserSocialEntity();
            socialEntity.setUserId(user.getUserId());
            socialEntity.setDisplayName(user.getName());
            socialEntity.setImageUrl(user.getImageUrl());
            sysUserSocialService.updateById(socialEntity);
        }
        sysUserEntity.setUpdateTime(new Date());
        this.updateById(sysUserEntity);

        //检查角色是否越权
//        checkRole(sysUserEntity);

        //保存用户与角色关系
//        sysUserRoleService.saveOrUpdate(user.getUserId(), user.getRoleId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteUser(Long[] userIds) {
        //删除用户
        this.removeByIds(Arrays.asList(userIds));
        //删除用户角色表
        sysUserRoleService.remove(new QueryWrapper<SysUserRoleEntity>().in("user_id", Arrays.asList(userIds)));
    }

    @Override
    public void updatePassword(PasswordDTO passwordDTO) {
        SysUserEntity user = (SysUserEntity) SecurityUtils.getSubject().getPrincipal();
        String password = passwordDTO.getPassword();
        String newPassword = passwordDTO.getNewPassword();
        if (user == null || StrUtil.isBlank(password) || StrUtil.isBlank(password)) {
            throw new BFRuntimeException("系统异常，请稍候重试");
        }
        password = PasswordUtils.decryptAES(password, CommonEnum.Security_Encode_Key.getValue());
        newPassword = PasswordUtils.decryptAES(newPassword, CommonEnum.Security_Encode_Key.getValue());
        //sha256加密
        password = new Sha256Hash(password, user.getSalt()).toHex();
        if (!password.equalsIgnoreCase(user.getPassword())) {
            throw new BFRuntimeException("旧密码输入错误");
        }
        //sha256加密
        newPassword = new Sha256Hash(newPassword, user.getSalt()).toHex();
        SysUserEntity userEntity = new SysUserEntity();
        userEntity.setPassword(newPassword);
        try {
            this.update(userEntity,
                    new QueryWrapper<SysUserEntity>().eq("user_id", user.getUserId()).eq("password", password));
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试", e.getMessage());
        }
    }

    @Override
    public void resetPassword(Long id) {
        SysUserEntity userEntity = baseMapper.selectById(id);
        if (userEntity == null) {
            throw new BFRuntimeException("数据不存在，操作失败");
        }
        //sha256加密
        String salt = RandomUtil.randomNumbers(20);
//        userEntity.setPassword(new Sha256Hash(CommonEnum.Reset_Password.getValue(), salt).toHex());
        String password = PasswordUtils.decryptAES(CommonEnum.Reset_Password_default.getValue(), CommonEnum.Security_Encode_Key.getValue());
        userEntity.setPassword(new Sha256Hash(password, salt).toHex());
        userEntity.setSalt(salt);
        try {
            updateById(userEntity);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试", e.getMessage());
        }
    }

    @Override
    @CacheEvict(value = "user_details", key = "#dto.username")
    public void updateUserLockStatus(SysUserLockDTO dto) {
        try {
            baseMapper.updateUserLockStatus(dto);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试", e.getMessage());
        }
    }

    @Override
    public void updateUserLastTime(SysUserLastTimeDTO dto) {
        try {
            baseMapper.updateUserLastTime(dto);
        } catch (Exception e) {
            throw new BFRuntimeException("系统异常，请稍候重试", e.getMessage());
        }
    }

    @Override
    public UserInfoDTO getInfo() {
        UserInfoDTO userInfoDTO = new UserInfoDTO();
        SysUserEntity sysUser = (SysUserEntity) SecurityUtils.getSubject().getPrincipal();
        sysUser.setName(EmojiParser.parseToUnicode(sysUser.getName()));
        Long userId = sysUser.getUserId();
        Integer roleId = sysUser.getRoleId();
        String roleCode = sysUser.getRoleCode();

        List<String> permissionList = sysMenuService.getMenuByRoleId(roleId)
                .stream()
                .filter(menuVo -> StrUtil.isNotEmpty(menuVo.getPermission()))
                .map(MenuVO::getPermission)
                .collect(Collectors.toList());
        Set<String> permissions = new HashSet<>(permissionList);

        userInfoDTO.setPermissions(ArrayUtil.toArray(permissions, String.class));
        userInfoDTO.setSysUser(sysUser);
        return userInfoDTO;
    }


    @Override
    public SysUserDTO getUserById(Long userId) {
        //获取用户所属的角色
        SysRoleEntity sysRoleEntity = sysUserRoleService.queryRole(userId);
        if (sysRoleEntity == null || StrUtil.isBlank(sysRoleEntity.getRoleCode())) {
            return baseMapper.queryUserById(userId);
        }
        SysUserDTO sysUserDTO = baseMapper.queryUserById(userId);
        sysUserDTO.setRoleId(sysRoleEntity.getRoleId());
        sysUserDTO.setRoleCode(sysRoleEntity.getRoleCode());
        sysUserDTO.setRoleName(sysRoleEntity.getRoleName());
        return sysUserDTO;
    }

    /**
     * 检查角色是否越权
     */
    private void checkRole(SysUserEntity user) {
        if (user.getRoleId() == null) {
            return;
        }
        //如果不是超级管理员，则需要判断用户的角色是否自己创建
        if (user.getCreateUserId() == 1) {
            return;
        }

        //查询用户创建的角色列表
        List<Long> roleIdList = sysRoleService.queryRoleIdList(user.getCreateUserId());

        //判断是否越权
        if (!roleIdList.contains(user.getRoleId())) {
            throw new BFRuntimeException("新增用户所选角色，不是本人创建");
        }
    }
}