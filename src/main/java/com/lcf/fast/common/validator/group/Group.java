package com.lcf.fast.common.validator.group;

import javax.validation.GroupSequence;

/**
 * 定义校验顺序
 *
 * @author lcf
 * @date 2020/4/7 15:23
 */
@GroupSequence({AddGroup.class, UpdateGroup.class})
public interface Group {

}
