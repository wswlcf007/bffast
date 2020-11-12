package com.lcf.fast.module.open.controller;

import com.lcf.fast.common.annotation.OpenApi;
import com.lcf.fast.common.model.ResultDTO;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 三方开放接口
 *
 * @author lcf
 * @date 2020-11-03 9:01
 */
@RestController
@RequestMapping("/open/v1")
@AllArgsConstructor
public class OpenApiApiV1Controller extends OpenApiBaseController {

    /**
     * 查询设备列表
     *
     * @return
     */
    @OpenApi("/test")
    @GetMapping("/test")
    public ResultDTO test() {
        return ResultDTO.ok();
    }

    /**
     * 添加设备
     *
     * @param params
     * @return
     */
    @OpenApi("/test2")
    @PostMapping("/test2")
    public ResultDTO test2(@RequestBody Map<String, Object> params) {
        return ResultDTO.ok(params);
    }
}
