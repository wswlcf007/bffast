package com.lcf.fast.module.ftp.controller;

import com.lcf.fast.common.model.ResultDTO;
import com.lcf.fast.module.ftp.service.FileService;
import com.lcf.fast.module.sys.model.entity.SysUserEntity;
import com.lcf.fast.module.sys.service.SysUserService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


/**
 * 上传文件
 */
@RestController
@RequestMapping("/file")
@AllArgsConstructor
public class UploadFileController {
    private FileService fileService;
    private SysUserService sysUserService;

    /**
     * 文件上传
     */
    @PostMapping("/upload")
    public ResultDTO list(@RequestParam("file") MultipartFile file) {
        return ResultDTO.ok(fileService.uploadFile(file));
    }

    /**
     * 头像 (app)
     */
    @PostMapping("/upload/user/head/img/{userId}")
    public ResultDTO list(@PathVariable(value = "userId") Long userId, @RequestParam("file") MultipartFile file) {
        String imgUrl = fileService.uploadFile(file);
        SysUserEntity sysUser = sysUserService.getById(userId);
        sysUser.setImageUrl(imgUrl);
        sysUserService.updateById(sysUser);
        return ResultDTO.ok(imgUrl);
    }

}
