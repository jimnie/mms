package com.rcbank.mms.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Wayne on 2016/3/3.
 */
@Entity
@Table(name = "mms_inf_member")
public class Member extends BaseEntity {

    private static final long serialVersionUID = 5621491392638387378L;
    // 积分
    private Long point;
    // 累计充值金额
    private BigDecimal amount;
    // 当前余额
    private BigDecimal balance;

    private BigDecimal rechargeAmount;

    private String cardNo;

    private Date registerDate;

    private String cnName;

    private String enName;

    private Date birth;

    private String sex;

    private String mobile;

    private String eduDegree;

    private String email;

    private String weixin;

    private String industry;

    private String address;

    private String job;

    private String relation;

    private String firstKidCnName;

    private String firstKidEnName;

    private Date firstKidBirth;

    private String firstKidSex;

    private String secondKidCnName;

    private String secondKidEnName;

    private Date secondKidBirth;

    private String secondKidSex;

    private String thirdKidCnName;

    private String thirdKidEnName;

    private Date thirdKidBirth;

    private String thirdKidSex;

    private MemberRank memberRank;

    private String state;

    private String city;

    private String district;

    private String street;

    private Set<ThemeCategory> categories = new HashSet<>();

    private Set<Theme> themes = new HashSet<>();

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "mms_inf_member_category",
            joinColumns = {@JoinColumn(name = "m_id")},
            inverseJoinColumns = {@JoinColumn(name = "c_id")})
    public Set<ThemeCategory> getCategories() {
        return categories;
    }

    public void setCategories(Set<ThemeCategory> categories) {
        this.categories = categories;
    }

    @JsonIgnore
    @ManyToMany(fetch = FetchType.LAZY, mappedBy = "members")
    public Set<Theme> getThemes() {
        return themes;
    }

    public void setThemes(Set<Theme> themes) {
        this.themes = themes;
    }

    @NotNull
    @Column(nullable = false, length = 50)
    public String getCnName() {
        return cnName;
    }

    public void setCnName(String cnName) {
        this.cnName = cnName;
    }

    @Column(nullable = true, length = 50)
    public String getEnName() {
        return enName;
    }

    public void setEnName(String enName) {
        this.enName = enName;
    }

    @NotNull
    @Temporal(TemporalType.DATE)
    @Column(length = 10)
    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    @NotNull
    @Column(nullable = false)
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @NotNull
    @Column(nullable = false, length = 11)
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @NotNull
    @Column(nullable = false)
    public String getEduDegree() {
        return eduDegree;
    }

    public void setEduDegree(String eduDegree) {
        this.eduDegree = eduDegree;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWeixin() {
        return weixin;
    }

    public void setWeixin(String weixin) {
        this.weixin = weixin;
    }

    @NotNull
    @Column(nullable = false)
    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    @NotNull
    @Column(nullable = false)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @NotNull
    @Column(nullable = false)
    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    @NotNull
    @Column(nullable = false, length = 20)
    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

    @NotNull
    @Column(nullable = false, length = 50)
    public String getFirstKidCnName() {
        return firstKidCnName;
    }

    public void setFirstKidCnName(String firstKidCnName) {
        this.firstKidCnName = firstKidCnName;
    }

    public String getFirstKidEnName() {
        return firstKidEnName;
    }

    public void setFirstKidEnName(String firstKidEnName) {
        this.firstKidEnName = firstKidEnName;
    }

    @NotNull
    @Temporal(TemporalType.DATE)
    @Column(nullable = false, length = 10)
    public Date getFirstKidBirth() {
        return firstKidBirth;
    }

    public void setFirstKidBirth(Date firstKidBirth) {
        this.firstKidBirth = firstKidBirth;
    }

    public String getSecondKidCnName() {
        return secondKidCnName;
    }

    public void setSecondKidCnName(String secondKidCnName) {
        this.secondKidCnName = secondKidCnName;
    }

    public String getSecondKidEnName() {
        return secondKidEnName;
    }

    public void setSecondKidEnName(String secondKidEnName) {
        this.secondKidEnName = secondKidEnName;
    }

    @Temporal(TemporalType.DATE)
    @Column(length = 10)
    public Date getSecondKidBirth() {
        return secondKidBirth;
    }

    public void setSecondKidBirth(Date secondKidBirth) {
        this.secondKidBirth = secondKidBirth;
    }

    public String getThirdKidCnName() {
        return thirdKidCnName;
    }

    public void setThirdKidCnName(String thirdKidCnName) {
        this.thirdKidCnName = thirdKidCnName;
    }

    public String getThirdKidEnName() {
        return thirdKidEnName;
    }

    public void setThirdKidEnName(String thirdKidEnName) {
        this.thirdKidEnName = thirdKidEnName;
    }

    @Temporal(TemporalType.DATE)
    @Column(length = 10)
    public Date getThirdKidBirth() {
        return thirdKidBirth;
    }

    public void setThirdKidBirth(Date thirdKidBirth) {
        this.thirdKidBirth = thirdKidBirth;
    }

    @Column
    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    @NotNull(groups = Save.class)
    @Min(0)
    @Column(nullable = false)
    public Long getPoint() {
        return point;
    }

    public void setPoint(Long point) {
        this.point = point;
    }

    @Column(nullable = false, precision = 12, scale = 2)
    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    @Column(nullable = false, precision = 12, scale = 2)
    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    @NotNull
    @Temporal(TemporalType.DATE)
    @Column(nullable = false, length = 10)
    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(nullable = false)
    public MemberRank getMemberRank() {
        return memberRank;
    }

    public void setMemberRank(MemberRank memberRank) {
        this.memberRank = memberRank;
    }

    @NotNull
    @Column(nullable = false, length = 20)
    public String getFirstKidSex() {
        return firstKidSex;
    }

    public void setFirstKidSex(String firstKidSex) {
        this.firstKidSex = firstKidSex;
    }

    @Column(length = 20)
    public String getSecondKidSex() {
        return secondKidSex;
    }

    public void setSecondKidSex(String secondKidSex) {
        this.secondKidSex = secondKidSex;
    }

    @Column(length = 20)
    public String getThirdKidSex() {
        return thirdKidSex;
    }

    public void setThirdKidSex(String thirdKidSex) {
        this.thirdKidSex = thirdKidSex;
    }

    @Column(length = 5)
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Column(length = 5)
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Column(length = 5)
    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    @Transient
    public BigDecimal getRechargeAmount() {
        return rechargeAmount;
    }

    public void setRechargeAmount(BigDecimal rechargeAmount) {
        this.rechargeAmount = rechargeAmount;
    }
}
