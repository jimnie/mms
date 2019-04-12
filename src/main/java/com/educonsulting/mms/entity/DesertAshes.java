package com.educonsulting.mms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "mms_inf_desert_ashes")
public class DesertAshes extends BaseEntity {

    private static final long serialVersionUID = -4500655313722547353L;
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
    // 逝者住址
    private String dpAddr;
    // 承办人姓名
    private String utName;
    // 承办人证件类型
    private Integer utCertType;
    // 承办人证件号
    private String utCertNo;
    // 承办人电话
    private String phone;
    // 备注
    private String memo;
    // 存放经办人
    private String createdBy;
    // 签字图片名称
    private String signPic;

    @NotNull
    @Column(name = "service_no", nullable = false, unique = true, length = 11)
    public String getServiceNo() {
        return serviceNo;
    }

    public void setServiceNo(String serviceNo) {
        this.serviceNo = serviceNo;
    }

    @NotNull
    @Column(name = "dp_name", nullable = false, length = 50)
    public String getDpName() {
        return dpName;
    }

    public void setDpName(String dpName) {
        this.dpName = dpName;
    }

    @NotNull
    @Column(name = "dp_sex")
    public Integer getDpSex() {
        return dpSex;
    }

    public void setDpSex(Integer dpSex) {
        this.dpSex = dpSex;
    }

    @NotNull
    @Column(name = "dp_age")
    public Integer getDpAge() {
        return dpAge;
    }

    public void setDpAge(Integer dpAge) {
        this.dpAge = dpAge;
    }

    @NotNull
    @Column(name = "dp_cert_type")
    public Integer getDpCertType() {
        return dpCertType;
    }

    public void setDpCertType(Integer dpCertType) {
        this.dpCertType = dpCertType;
    }

    @NotNull
    @Column(name = "dp_cert_no", nullable = false, length = 18)
    public String getDpCertNo() {
        return dpCertNo;
    }

    public void setDpCertNo(String dpCertNo) {
        this.dpCertNo = dpCertNo;
    }

    @NotNull
    @Column(name = "dp_addr", nullable = false, length = 255)
    public String getDpAddr() {
        return dpAddr;
    }

    public void setDpAddr(String dpAddr) {
        this.dpAddr = dpAddr;
    }

    @NotNull
    @Column(name = "ut_name", nullable = false, length = 20)
    public String getUtName() {
        return utName;
    }

    public void setUtName(String utName) {
        this.utName = utName;
    }

    @NotNull
    @Column(name = "ut_cert_type")
    public Integer getUtCertType() {
        return utCertType;
    }

    public void setUtCertType(Integer utCertType) {
        this.utCertType = utCertType;
    }

    @NotNull
    @Column(name = "ut_cert_no", nullable = false, length = 18)
    public String getUtCertNo() {
        return utCertNo;
    }

    public void setUtCertNo(String utCertNo) {
        this.utCertNo = utCertNo;
    }

    @NotNull
    @Column(name = "phone", nullable = false, length = 20)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "memo", columnDefinition = "text")
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @NotNull
    @Column(name = "created_by", nullable = false, length = 20)
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @NotNull
    @Column(name = "sign_pic", nullable = false, length = 50)
    public String getSignPic() {
        return signPic;
    }

    public void setSignPic(String signPic) {
        this.signPic = signPic;
    }
}
