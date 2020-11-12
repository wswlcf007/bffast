package com.lcf.fast.module.sys.model.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * 树节点
 *
 * @author lcf
 * @date 2019/8/3 23:33:45
 */
@Data
public class TreeNodeDTO {
    protected int id;
    protected int parentId;
    protected List<TreeNodeDTO> children = new ArrayList<TreeNodeDTO>();

    public void add(TreeNodeDTO node) {
        children.add(node);
    }
}
