package com.educonsulting.mms.entity;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Wayne on 2016/3/10.
 */
@Entity
@Table(name = "mms_inf_theme")
public class Theme extends BaseEntity {

    private static final long serialVersionUID = -3145074501834975970L;

    // 标题
    private String title;

    // 摘要
    private String summary;

    // 最大参加人数
    private Integer maxCount;

    // 实际参加人数
    private Integer count;

    // 主讲人
    private String compere;

    // 价格
    private BigDecimal price;

    // 评分
    private Integer grade;

    // 开始时间
    private Date beginTime;

    // 时长
    private Integer duration;

    // 所属主题分类
    private ThemeCategory category;

    private Set<Member> members = new HashSet<>();

    @NotNull
    @Column(nullable = false, length = 50)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @NotNull
    @Column(nullable = false)
    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    @NotNull
    @Column(nullable = false, scale = 3)
    public Integer getMaxCount() {
        return maxCount;
    }

    public void setMaxCount(Integer maxCount) {
        this.maxCount = maxCount;
    }

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getCompere() {
        return compere;
    }

    public void setCompere(String compere) {
        this.compere = compere;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    public ThemeCategory getCategory() {
        return category;
    }

    public void setCategory(ThemeCategory category) {
        this.category = category;
    }

    @ManyToMany
    @JoinTable(name = "mms_inf_theme_member",
            joinColumns = {@JoinColumn(name = "t_id")},
            inverseJoinColumns = {@JoinColumn(name = "m_id")})
    public Set<Member> getMembers() {
        return members;
    }

    public void setMembers(Set<Member> members) {
        this.members = members;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
