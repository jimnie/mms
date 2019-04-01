package com.educonsulting.mms.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Entity
@Table(name = "mms_inf_deposit")
public class Deposit extends BaseEntity {

    private static final long serialVersionUID = 4787322019100459743L;
    // 服务编号
    private String serviceNo;
    // 逝者姓名
    private String dpName;
    // 逝者性别
    private Integer dpSex;
    // 逝者年龄
    private Integer dpAge;
    // 逝者证件类型
    private Integer dpCertType;
    // 逝者证件号
    private String dpCertNo;
    // 承办人姓名
    private String utName;
    // 承办人证件类型
    private Integer utCertType;
    // 承办人证件号
    private String utCertNo;
    // 存入时间
    private Date depositDate;
    // 存放位置
    private String position;
    // 急取
    private Integer urgent;
    // 外观
    private Integer facade;
    // 取出时间
    private Date drawDate;
    // 备注
    private String memo;
    // 存放状态，0：存放 1：领取
    private Integer status;

    @NotNull
    @Column(nullable = false, length = 11)
    public String getServiceNo() {
        return serviceNo;
    }

    public void setServiceNo(String serviceNo) {
        this.serviceNo = serviceNo;
    }

    @NotNull
    @Column(nullable = false, length = 20)
    public String getDpName() {
        return dpName;
    }

    public void setDpName(String dpName) {
        this.dpName = dpName;
    }

    @NotNull
    @Column(nullable = false, length = 1)
    public Integer getDpSex() {
        return dpSex;
    }

    public void setDpSex(Integer dpSex) {
        this.dpSex = dpSex;
    }

    @NotNull
    @Column(nullable = false)
    public Integer getDpAge() {
        return dpAge;
    }

    public void setDpAge(Integer dpAge) {
        this.dpAge = dpAge;
    }

    @NotNull
    @Column(nullable = false, length = 1)
    public Integer getDpCertType() {
        return dpCertType;
    }

    public void setDpCertType(Integer dpCertType) {
        this.dpCertType = dpCertType;
    }

    @NotNull
    @Column(nullable = false, length = 18)
    public String getDpCertNo() {
        return dpCertNo;
    }

    public void setDpCertNo(String dpCertNo) {
        this.dpCertNo = dpCertNo;
    }

    @NotNull
    @Column(nullable = false, length = 20)
    public String getUtName() {
        return utName;
    }

    public void setUtName(String utName) {
        this.utName = utName;
    }

    @NotNull
    @Column(nullable = false, length = 1)
    public Integer getUtCertType() {
        return utCertType;
    }

    public void setUtCertType(Integer utCertType) {
        this.utCertType = utCertType;
    }

    @NotNull
    @Column(nullable = false, length = 18)
    public String getUtCertNo() {
        return utCertNo;
    }

    public void setUtCertNo(String utCertNo) {
        this.utCertNo = utCertNo;
    }

    @NotNull
    @Column(nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getDepositDate() {
        return depositDate;
    }

    public void setDepositDate(Date depositDate) {
        this.depositDate = depositDate;
    }

    @NotNull
    @Column(nullable = false, length = 20)
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    @NotNull
    @Column(nullable = false, length = 1)
    public Integer getUrgent() {
        return urgent;
    }

    public void setUrgent(Integer urgent) {
        this.urgent = urgent;
    }

    @NotNull
    @Column(nullable = false, length = 1)
    public Integer getFacade() {
        return facade;
    }

    public void setFacade(Integer facade) {
        this.facade = facade;
    }

    @NotNull
    @Column(nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getDrawDate() {
        return drawDate;
    }

    public void setDrawDate(Date drawDate) {
        this.drawDate = drawDate;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @NotNull
    @Column(nullable = false, length = 1)
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
