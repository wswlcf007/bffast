package com.lcf.fast.module.sys.controller;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONObject;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.lcf.fast.common.annotation.SysLog;
import com.lcf.fast.common.constant.MenuTypeEnum;
import com.lcf.fast.common.exception.BFRuntimeException;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.common.util.TreeUtil;
import com.lcf.fast.module.sys.model.dto.MenuTreeDTO;
import com.lcf.fast.module.sys.model.entity.SysMenuEntity;
import com.lcf.fast.module.sys.model.entity.SysRoleEntity;
import com.lcf.fast.module.sys.model.vo.MenuVO;
import com.lcf.fast.module.sys.service.ShiroService;
import com.lcf.fast.module.sys.service.SysMenuService;
import com.lcf.fast.module.sys.service.SysUserRoleService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 系统菜单
 *
 * @author lcf
 * @date 2019/11/12 9:46:21
 */
@RestController
@RequestMapping("/sys/menu")
@AllArgsConstructor
public class SysMenuController extends BaseController {
    private SysMenuService sysMenuService;
    private ShiroService shiroService;
    private SysUserRoleService sysUserRoleService;

    @GetMapping
    public ResultDTO getUserMenu() {
        // 获取符合条件的菜单
        SysRoleEntity sysRoleEntity = sysUserRoleService.queryRole(getUserId());
        if (sysRoleEntity == null) {
            return ResultDTO.ok();
        }
        Set<MenuVO> all = new HashSet<>(sysMenuService.getMenuByRoleId(sysRoleEntity.getRoleId()));
        //剔除按钮
        List<MenuTreeDTO> menuTreeDTOList = all.stream()
                .filter(menuVo -> !MenuTypeEnum.BUTTON.getValue().equals(menuVo.getType()))
                .map(MenuTreeDTO::new)
                .sorted(Comparator.comparingInt(MenuTreeDTO::getSort))
                .collect(Collectors.toList());
        return ResultDTO.ok(TreeUtil.buildByLoop(menuTreeDTOList, -1));
    }

    /**
     * 导航菜单
     */
    @GetMapping("/nav")
    public ResultDTO nav() {
        List<SysMenuEntity> menuList = sysMenuService.getUserMenuList(getUserId());
        Set<String> permissions = shiroService.getUserPermissions(getUserId());

        return ResultDTO.ok(new JSONObject().put("menuList", menuList).put("permissions", permissions));
    }

    /**
     * 所有菜单列表
     */
    @GetMapping("/list")
    @RequiresPermissions("sys:menu:list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        List<SysMenuEntity> list = sysMenuService.getList(params);
        return ResultDTO.ok(list);
    }

    /**
     * 选择菜单(添加、修改菜单)
     */
    @GetMapping("/select")
    @RequiresPermissions("sys:menu:select")
    public ResultDTO select() {
        //查询列表数据
        List<SysMenuEntity> menuList = sysMenuService.queryNotButtonList();

        //添加顶级菜单
        SysMenuEntity root = new SysMenuEntity();
        root.setMenuId(0L);
        root.setName("一级菜单");
        root.setParentId(-1L);
        root.setOpen(true);
        menuList.add(root);

        return ResultDTO.ok(menuList);
    }

    /**
     * 菜单信息
     */
    @GetMapping("/info/{menuId}")
    @RequiresPermissions("sys:menu:info")
    public ResultDTO info(@PathVariable("menuId") Long menuId) {
        SysMenuEntity menu = sysMenuService.getById(menuId);
        return ResultDTO.ok(menu);
    }

    /**
     * 保存
     */
    @SysLog("保存菜单")
    @PostMapping("/save")
    @RequiresPermissions("sys:menu:save")
    public ResultDTO save(@RequestBody SysMenuEntity menu) {
        //数据校验
        verifyForm(menu);

        sysMenuService.save(menu);

        return ResultDTO.ok();
    }

    /**
     * 修改
     */
    @SysLog("修改菜单")
    @PostMapping("/update")
    @RequiresPermissions("sys:menu:update")
    public ResultDTO update(@RequestBody SysMenuEntity menu) {
        //数据校验
        verifyForm(menu);

        sysMenuService.updateById(menu);

        return ResultDTO.ok();
    }

    /**
     * 删除
     */
    @SysLog("删除菜单")
    @PostMapping("/delete/{menuId}")
    @RequiresPermissions("sys:menu:delete")
    public ResultDTO delete(@PathVariable("menuId") long menuId) {
        sysMenuService.deleteMenu(menuId);
        return ResultDTO.ok();
    }

    /**
     * 返回树形菜单集合
     *
     * @return 树形菜单
     */
    @GetMapping(value = "/tree")
    public ResultDTO getTree() {
        return ResultDTO.ok(TreeUtil.buildTree(sysMenuService.list(Wrappers.emptyWrapper()), -1));
    }

    /**
     * 返回角色的菜单集合
     *
     * @param roleId 角色ID
     * @return 属性集合
     */
    @GetMapping("/tree/{roleId}")
    public ResultDTO getRoleTree(@PathVariable Integer roleId) {
        List<Integer> collect = sysMenuService.getMenuByRoleId(roleId)
                .stream()
                .map(MenuVO::getMenuId)
                .collect(Collectors.toList());
        return ResultDTO.ok(collect);
    }

    /**
     * 验证参数是否正确
     */
    private void verifyForm(SysMenuEntity menu) {
        if (StrUtil.isBlank(menu.getName())) {
            throw new BFRuntimeException("菜单名称不能为空");
        }

        if (menu.getParentId() == null) {
            throw new BFRuntimeException("上级菜单不能为空");
        }

        //菜单
        if (MenuTypeEnum.MENU.getValue().equalsIgnoreCase(menu.getType())) {
            if (StrUtil.isBlank(menu.getPath())) {
                throw new BFRuntimeException("菜单URL不能为空");
            }
        }

        //上级菜单类型
        String parentType = MenuTypeEnum.CATALOG.getValue();
        if (menu.getParentId() != -1) {
            SysMenuEntity parentMenu = sysMenuService.getById(menu.getParentId());
            parentType = parentMenu.getType();
        }

        //目录、菜单
        if (MenuTypeEnum.CATALOG.getValue().equalsIgnoreCase(menu.getType()) ||
                MenuTypeEnum.MENU.getValue().equalsIgnoreCase(menu.getType())) {
            if (!MenuTypeEnum.CATALOG.getValue().equalsIgnoreCase(parentType)) {
                throw new BFRuntimeException("上级菜单只能为目录类型");
            }
            return;
        }

        //按钮
        if (MenuTypeEnum.BUTTON.getValue().equalsIgnoreCase(menu.getType())) {
            if (!MenuTypeEnum.MENU.getValue().equalsIgnoreCase(parentType)) {
                throw new BFRuntimeException("上级菜单只能为菜单类型");
            }
        }
    }
}
