package com.lcf.fast.module.open.service.impl;

import com.lcf.fast.module.open.service.OpenApiService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 开放接口service实现类
 *
 * @author lcf
 * @date 2020-11-03 13:51
 */
@Service("openApiService")
@Slf4j
@AllArgsConstructor
public class OpenApiServiceImpl implements OpenApiService {


    @Override
    public void test(Map<String, Object> params) {

    }
}
