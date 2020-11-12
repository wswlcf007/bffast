package com.lcf.fast.module.sys.model.dto;

import com.lcf.fast.module.sys.model.vo.MenuVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 菜单树DTO
 *
 * @author lcf
 * @date 2019/9/12 23:33:27
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class MenuTreeDTO extends TreeNodeDTO {
    private String icon;
    private String name;
    private boolean spread = false;
    private String path;
    private String component;
    private String authority;
    private String redirect;
    private String keepAlive;
    private String code;
    private String type;
    private String label;
    private Integer sort;

    public MenuTreeDTO() {
    }

    public MenuTreeDTO(int id, String name, int parentId) {
        this.id = id;
        this.parentId = parentId;
        this.name = name;
        this.label = name;
    }

    public MenuTreeDTO(int id, String name, MenuTreeDTO parent) {
        this.id = id;
        this.parentId = parent.getId();
        this.name = name;
        this.label = name;
    }

    public MenuTreeDTO(MenuVO menuVo) {
        this.id = menuVo.getMenuId();
        this.parentId = menuVo.getParentId();
        this.icon = menuVo.getIcon();
        this.name = menuVo.getName();
        this.path = menuVo.getPath();
        this.component = menuVo.getComponent();
        this.type = menuVo.getType();
        this.label = menuVo.getName();
        this.sort = menuVo.getSort();
        this.keepAlive = menuVo.getKeepAlive();
    }
}
