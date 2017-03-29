package com.rcbank.mms.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Wayne on 2016/3/8.
 */
@Entity
@Table(name = "mms_inf_theme_category")
public class ThemeCategory extends BaseEntity {

    private static final long serialVersionUID = 4984453852414544234L;

    // 类别名称
    private String name;

    // 类别描述
    private String memo;

    private Integer sortNo;

    private Set<Member> members = new HashSet<>();

    private Set<Theme> themes = new HashSet<>();

    @NotNull
    @Column(nullable = false, length = 50)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @NotNull
    @Column(nullable = false)
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public Integer getSortNo() {
        return sortNo;
    }

    public void setSortNo(Integer sortNo) {
        this.sortNo = sortNo;
    }

    @JsonIgnore
    @ManyToMany(fetch = FetchType.EAGER, mappedBy = "categories")
    public Set<Member> getMembers() {
        return members;
    }

    public void setMembers(Set<Member> members) {
        this.members = members;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "category")
    public Set<Theme> getThemes() {
        return themes;
    }

    public void setThemes(Set<Theme> themes) {
        this.themes = themes;
    }
}
