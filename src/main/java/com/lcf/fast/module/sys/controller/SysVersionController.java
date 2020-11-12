package com.lcf.fast.module.sys.controller;

import cn.hutool.core.util.StrUtil;
import com.lcf.fast.common.annotation.SysLog;
import com.lcf.fast.common.constant.RCodeEnum;
import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.ftp.service.FileService;
import com.lcf.fast.module.sys.model.entity.SysVersionEntity;
import com.lcf.fast.module.sys.service.SysVersionService;
import lombok.AllArgsConstructor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 版本管理
 *
 * @author lcf
 * @date 2019-10-09 14:14:20
 */
@RestController
@RequestMapping("/sys/version")
@AllArgsConstructor
public class SysVersionController {
    private FileService fileService;
    private SysVersionService sysVersionService;

    /**
     * 列表-分页
     *
     * @return
     */
    @GetMapping("/list/page")
    @RequiresPermissions("sys:version:list")
    public ResultDTO page(@RequestParam Map<String, Object> params) {
        PageUtils page = sysVersionService.queryPage(params);
        return ResultDTO.ok(page);
    }

    /**
     * 列表-不分页
     *
     * @return
     */
    @GetMapping("/list")
    @RequiresPermissions("sys:version:list")
    public ResultDTO list(@RequestParam Map<String, Object> params) {
        List<SysVersionEntity> list = sysVersionService.queryList(params);
        return ResultDTO.ok(list);
    }

    /**
     * 查询最新版本
     */
    @GetMapping("/current/{clientType}")
    public ResultDTO newestVersion(@PathVariable(value = "clientType") String clientType) {
        return ResultDTO.ok(sysVersionService.getCurrentVersion(clientType));
    }


    /**
     * 信息
     *
     * @return
     */
    @GetMapping("/info/{id}")
    @RequiresPermissions("sys:version:info")
    public ResultDTO info(@PathVariable("id") Long id) {
        SysVersionEntity noticeVersion = sysVersionService.getById(id);
        return ResultDTO.ok(noticeVersion);
    }

    /**
     * 保存
     */
    @SysLog("新增：app版本管理")
    @PostMapping("/save")
    @RequiresPermissions("sys:version:save")
    public ResultDTO save(@RequestBody SysVersionEntity versionEntity) {
        sysVersionService.saveVersion(versionEntity);
        return ResultDTO.ok();
    }

    /**
     * 修改
     */
    @SysLog("修改：app版本管理")
    @PostMapping("/update")
    @RequiresPermissions("sys:version:update")
    public ResultDTO update(@RequestBody SysVersionEntity noticeVersion) {
        sysVersionService.updateById(noticeVersion);
        return ResultDTO.ok();
    }

    /**
     * 删除
     */
    @SysLog("删除：app版本管理")
    @PostMapping("/delete")
    @RequiresPermissions("sys:version:delete")
    public ResultDTO delete(@RequestBody Long[] ids) {
        sysVersionService.removeByIds(Arrays.asList(ids));
        return ResultDTO.ok();
    }

    /**
     * 版本号验证
     *
     * @return
     */
    @GetMapping("/check-update")
    public ResultDTO codeVersion(@RequestParam Map<String, Object> params) {
        return ResultDTO.ok(sysVersionService.codeVersion(params));
    }

    /**
     * 下载
     *
     * @return
     */
    @GetMapping("/download")
    @RequiresPermissions("sys:version:download")
    public ResultDTO download(@RequestParam Map<String, Object> params) {
        return ResultDTO.ok();
    }

    /**
     * 上传
     *
     * @return
     */
    @PostMapping("/upload")
    public ResultDTO upload(@RequestParam("file") MultipartFile file) {
        Long size = file.getSize();//byte
        String originFileName = file.getOriginalFilename();
        if (StrUtil.isBlank(originFileName)) {
            return ResultDTO.error(RCodeEnum.Error.getCode(), "上传失败，上传文件名不正确");
        }

        return ResultDTO.ok(fileService.uploadFile(file));
    }
}
