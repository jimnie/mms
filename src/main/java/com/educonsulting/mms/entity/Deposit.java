package com.educonsulting.mms.entity;

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
    private int dpSex;
    // 逝者年龄
    private int dpAge;
    // 逝者证件类型
    private int dpCertType;
    // 逝者证件号
    private String dpCertNo;
    // 承办人姓名
    private String utName;
    // 承办人证件类型
    private int utCertType;
    // 承办人证件号
    private String utCertNo;
    // 存入时间
    private Date depositDate;
    // 存放位置
    private String position;
    // 急取
    private int urgent;
    // 外观
    private int facade;
    // 取出时间
    private Date drawDate;
    // 备注
    private String memo;
    // 存放状态，0：存放 1：领取
    private int status;

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
    public int getDpSex() {
        return dpSex;
    }

    public void setDpSex(int dpSex) {
        this.dpSex = dpSex;
    }

    @NotNull
    @Column(nullable = false, length = 3)
    public int getDpAge() {
        return dpAge;
    }

    public void setDpAge(int dpAge) {
        this.dpAge = dpAge;
    }

    @NotNull
    @Column(nullable = false, length = 1)
    public int getDpCertType() {
        return dpCertType;
    }

    public void setDpCertType(int dpCertType) {
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
    public int getUtCertType() {
        return utCertType;
    }

    public void setUtCertType(int utCertType) {
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
    public int getUrgent() {
        return urgent;
    }

    public void setUrgent(int urgent) {
        this.urgent = urgent;
    }

    @NotNull
    @Column(nullable = false, length = 1)
    public int getFacade() {
        return facade;
    }

    public void setFacade(int facade) {
        this.facade = facade;
    }

    @NotNull
    @Column(nullable = false)
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
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
