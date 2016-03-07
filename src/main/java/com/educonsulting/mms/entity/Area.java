/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.educonsulting.mms.entity;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "mms_sys_area")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "sys_area_sequence")
public class Area extends OrderEntity {

    private static final long serialVersionUID = -2158109459123036967L;

    private static final String TREE_PATH_SEPARATOR = ",";

    private String name;

    private String fullName;

    private String treePath;

    private Area parent;

    private Set<Area> children = new HashSet<Area>();

    @NotEmpty
    @Length(max = 100)
    @Column(nullable = false, length = 100)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(nullable = false, length = 500)
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    @Column(nullable = false, updatable = false)
    public String getTreePath() {
        return treePath;
    }

    public void setTreePath(String treePath) {
        this.treePath = treePath;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    public Area getParent() {
        return parent;
    }

    public void setParent(Area parent) {
        this.parent = parent;
    }

    @OneToMany(mappedBy = "parent", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    @OrderBy("order asc")
    public Set<Area> getChildren() {
        return children;
    }

    public void setChildren(Set<Area> children) {
        this.children = children;
    }

    @PrePersist
    public void prePersist() {
        Area parent = getParent();
        if (parent != null) {
            setFullName(parent.getFullName() + getName());
            setTreePath(parent.getTreePath() + parent.getId() + TREE_PATH_SEPARATOR);
        } else {
            setFullName(getName());
            setTreePath(TREE_PATH_SEPARATOR);
        }
    }

    @PreUpdate
    public void preUpdate() {
        Area parent = getParent();
        if (parent != null) {
            setFullName(parent.getFullName() + getName());
        } else {
            setFullName(getName());
        }
    }

    @Override
    public String toString() {
        return getFullName();
    }

}