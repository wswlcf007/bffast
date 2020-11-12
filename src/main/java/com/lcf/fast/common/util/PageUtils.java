package com.lcf.fast.common.util;

import com.baomidou.mybatisplus.core.metadata.IPage;

import java.io.Serializable;
import java.util.List;

/**
 * 分页工具类
 *
 * @author lcf
 * @date 2019-07-04 12:59:00
 */
public class PageUtils implements Serializable {
    private static final long serialVersionUID = 1L;
    //总记录数
    private long total;
    //每页记录数
    private long size;
    //总页数
    private int totalPage;
    //当前页数
    private long current;
    //列表数据
    private List<?> list;

    public PageUtils() {
    }

    /**
     * 分页
     *
     * @param list    列表数据
     * @param total   总记录数
     * @param size    每页记录数
     * @param current 当前页数
     */
    public PageUtils(List<?> list, long total, long size, long current) {
        this.list = list;
        this.total = total;
        this.size = size;
        this.current = current;
        this.totalPage = (int) Math.ceil((double) total / size);
    }

    /**
     * 分页
     */
    public PageUtils(IPage<?> page) {
        this.list = page.getRecords();
        this.total = page.getTotal();
        this.size = page.getSize();
        this.current = page.getCurrent();
        this.totalPage = (int) page.getPages();
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public long getCurrent() {
        return current;
    }

    public void setCurrent(long current) {
        this.current = current;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }
}
