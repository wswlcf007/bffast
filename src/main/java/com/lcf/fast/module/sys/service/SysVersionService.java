package com.lcf.fast.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lcf.fast.common.util.PageUtils;
import com.lcf.fast.module.sys.model.entity.SysVersionEntity;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

/**
 * app版本管理
 *
 * @author nyn
 * @email @
 * @date 2019-10-09 14:14:20
 */
public interface SysVersionService extends IService<SysVersionEntity> {

    //分页查询列表
    PageUtils queryPage(Map<String, Object> params);

    //不分页查询列表
    List<SysVersionEntity> queryList(Map<String, Object> params);

    /**
     * 版本号验证
     *
     * @return
     */
    Boolean codeVersion(@RequestParam Map<String, Object> params);


    /**
     * 新增版本
     *
     * @param versionEntity
     */
    void saveVersion(SysVersionEntity versionEntity);

    /**
     * 查询最新版本号
     *
     * @param clientType
     */
    SysVersionEntity getCurrentVersion(String clientType);
}

