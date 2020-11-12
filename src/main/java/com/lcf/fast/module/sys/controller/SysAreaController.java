package com.lcf.fast.module.sys.controller;

import com.lcf.fast.common.annotation.SysLog;
import com.lcf.fast.common.constant.RCodeEnum;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.module.sys.model.entity.SysAreaEntity;
import com.lcf.fast.module.sys.service.SysAreaService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;


/**
 * 系统_中国行政区划
 *
 * @author lcf
 * @date 2019-06-20 16:49:42
 */
@RestController
@AllArgsConstructor
@RequestMapping("/sys/area")
public class SysAreaController {
    private final SysAreaService sysAreaService;

    /**
     * 简单分页查询
     *
     * @param params
     * @return
     */
    @GetMapping("/page")
    public ResultDTO page(@RequestParam Map<String, Object> params) {
        PageUtils page = sysAreaService.queryPage(params);
        return ResultDTO.ok(page);
    }

    /**
     * 不分页
     *
     * @return
     */
    @GetMapping("/list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        List<SysAreaEntity> list = sysAreaService.queryList(params);
        return ResultDTO.ok(list);
    }


    /**
     * 通过id查询单条记录
     *
     * @param id
     * @return R
     */
    @GetMapping("/info/{id}")
    public ResultDTO getById(@PathVariable("id") Integer id) {
        SysAreaEntity sysAreaEntity = sysAreaService.getById(id);
        return ResultDTO.ok(sysAreaEntity);
    }

    /**
     * 新增记录
     *
     * @param sysAreaEntity
     * @return R
     */
    @SysLog("新增系统_中国行政区划")
    @PostMapping("/save")
    public ResultDTO save(@RequestBody SysAreaEntity sysAreaEntity) {
        boolean b = sysAreaService.save(sysAreaEntity);
        if (!b) {
            return ResultDTO.error(RCodeEnum.Error.getCode(), "保存失败");
        }
        return ResultDTO.ok();
    }

    /**
     * 修改记录
     *
     * @param sysAreaEntity
     * @return R
     */
    @SysLog("修改系统_中国行政区划")
    @PostMapping("/update")
    public ResultDTO update(@RequestBody SysAreaEntity sysAreaEntity) {
        boolean b = sysAreaService.updateById(sysAreaEntity);
        if (!b) {
            return ResultDTO.error(RCodeEnum.Error.getCode(), "更新失败");
        }
        return ResultDTO.ok();
    }

    /**
     * 通过id删除一条记录
     *
     * @param id
     * @return R
     */
    @SysLog("删除系统_中国行政区划")
    @PostMapping("/delete/{id}")
    public ResultDTO removeById(@PathVariable Integer id) {
        boolean b = sysAreaService.removeById(id);
        if (!b) {
            return ResultDTO.error(RCodeEnum.Error.getCode(), "删除失败");
        }
        return ResultDTO.ok();
    }

}
