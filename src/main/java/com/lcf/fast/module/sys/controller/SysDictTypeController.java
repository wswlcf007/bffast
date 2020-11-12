package com.lcf.fast.module.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.module.sys.model.entity.SysDictType;
import com.lcf.fast.module.sys.service.SysDictTypeService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * 字典类型接口
 *
 * @author lcf
 * @date 2019/2/1
 */
@RestController
@AllArgsConstructor
@RequestMapping("/sys/dict/type")
public class SysDictTypeController {
    private final SysDictTypeService sysDictTypeService;

    /**
     * 分页查询
     *
     * @param params
     * @return 分页对象
     */
    @GetMapping("/page")
    @RequiresPermissions("sys:dict:type:list")
    public ResultDTO getDictPage(@RequestParam Map<String, Object> params) {
        return ResultDTO.ok(sysDictTypeService.queryPage(params));
    }

    /**
     * 不分页
     *
     * @return
     */
    @GetMapping("/list")
    @RequiresPermissions("sys:dict:type:list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        List<SysDictType> list = sysDictTypeService.queryList(params);
        return ResultDTO.ok(list);
    }

    /**
     * 添加字典类型
     *
     * @param sysDictType 字典信息
     * @return success、false
     */
    @PostMapping("/save")
    @RequiresPermissions("sys:dict:type:save")
    public ResultDTO save(@Valid @RequestBody SysDictType sysDictType) {
        return ResultDTO.ok(sysDictTypeService.save(sysDictType));
    }

    /**
     * 删除类型
     *
     * @param type
     * @return R
     */
    @PostMapping("/delete/{type}")
    @RequiresPermissions("sys:dict:type:delete")
    public ResultDTO remove(@PathVariable String type) {
        return ResultDTO.ok(sysDictTypeService.remove(new QueryWrapper<SysDictType>().eq("type_value", type)));
    }

    /**
     * 修改字典类型
     *
     * @param sysDictType 字典类型信息
     * @return success/false
     */
    @PostMapping("/update")
    @RequiresPermissions("sys:dict:type:update")
    public ResultDTO update(@RequestBody SysDictType sysDictType) {
        return ResultDTO.ok(sysDictTypeService.update(sysDictType, new QueryWrapper<SysDictType>()
                .eq("type_value", sysDictType.getTypeValue())));
    }
}
