package com.lcf.fast.module.sys.controller;


import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.lcf.fast.common.annotation.SysLog;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.module.sys.model.entity.SysDict;
import com.lcf.fast.module.sys.service.SysDictService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * 字典接口
 *
 * @author lcf
 * @date 2019/2/1
 */
@RestController
@AllArgsConstructor
@RequestMapping("/sys/dict")
public class SysDictController {
    private final SysDictService sysDictService;

    /**
     * 分页查询字典信息
     *
     * @param params
     * @return 分页对象
     */
    @GetMapping("/page")
    @RequiresPermissions("sys:dict:list")
    public ResultDTO getDictPage(@RequestParam Map<String, Object> params) {
//        return ResultDTO.ok(sysDictService.page(page, Wrappers.query(sysDict)));
        return ResultDTO.ok(sysDictService.queryPage(params));
    }

    /**
     * 不分页
     *
     * @return
     */
    @GetMapping("/list")
//    @RequiresPermissions("sys:dict:list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        List<SysDict> list = sysDictService.queryList(params);
        return ResultDTO.ok(list);
    }

    /**
     * 通过ID查询字典信息
     *
     * @param dictId ID
     * @return 字典信息
     */
    @GetMapping("/{dictId}")
    @RequiresPermissions("sys:dict:info")
    public ResultDTO getById(@PathVariable Integer dictId) {
        SysDict sysDict = sysDictService.getById(dictId);
        return ResultDTO.ok(sysDict);
    }

    /**
     * 通过字典类型查找字典
     *
     * @param type 类型
     * @return 同类型字典
     */
    @GetMapping("/type/{type}")
//    @RequiresPermissions("sys:dict:type")
    public ResultDTO getDictByType(@PathVariable String type) {
        return ResultDTO.ok(sysDictService.list(Wrappers
                .<SysDict>query().lambda()
                .eq(SysDict::getType, type)));
    }

    /**
     * 添加字典
     *
     * @param sysDict 字典信息
     * @return success、false
     */
    @SysLog("添加字典")
    @PostMapping("/save")
    @RequiresPermissions("sys:dict:save")
    public ResultDTO save(@Valid @RequestBody SysDict sysDict) {
        return ResultDTO.ok(sysDictService.save(sysDict));
    }

    /**
     * 删除字典，并且清除字典缓存
     *
     * @param id ID
     * @return R
     */
    @SysLog("删除字典")
    @PostMapping("/delete/{id}")
    @RequiresPermissions("sys:dict:delete")
    public ResultDTO removeById(@PathVariable Integer id) {
        return ResultDTO.ok(sysDictService.removeById(id));
    }

    /**
     * 修改字典
     *
     * @param sysDict 字典信息
     * @return success/false
     */
    @SysLog("修改字典")
    @PostMapping("/update")
    @RequiresPermissions("sys:dict:update")
    public ResultDTO updateById(@Valid @RequestBody SysDict sysDict) {
        return ResultDTO.ok(sysDictService.updateById(sysDict));
    }
}
