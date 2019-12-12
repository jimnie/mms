package com.educonsulting.mms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "mms_inf_bag")
public class Bag extends BaseEntity {

    private static final long serialVersionUID = 4645651153131458121L;

    private String serviceNo;
    // 逝者姓名
    private String dpName;
    // 逝者证件类型
    private Integer dpCertType;
    // 逝者证件号
    private String dpCertNo;
    // 经办人
    private String createdBy;
    // 领取登记状态
    private Integer status;

    @NotNull
    @Column(name = "service_no", nullable = false, length = 16)
    public String getServiceNo() {
        return serviceNo;
    }

    public void setServiceNo(String serviceNo) {
        this.serviceNo = serviceNo;
    }

    @NotNull
    @Column(name = "dp_name", nullable = false, length = 20)
    public String getDpName() {
        return dpName;
    }

    public void setDpName(String dpName) {
        this.dpName = dpName;
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
    @Column(name = "created_by", nullable = false, length = 20)
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @NotNull
    @Column(name = "status", nullable = false, length = 1)
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
