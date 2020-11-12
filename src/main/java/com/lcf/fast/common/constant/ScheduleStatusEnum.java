package com.lcf.fast.common.constant;

/**
 * 定时任务状态
 *
 * @author lcf
 * @date 2020-06-22 14:17
 */
public enum ScheduleStatusEnum {
    /**
     * 正常
     */
    NORMAL(0),
    /**
     * 暂停
     */
    PAUSE(1);

    private int value;

    ScheduleStatusEnum(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
