package com.educonsulting.mms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "v_dh_match")
public class DHMatch implements Serializable {

    private static final long serialVersionUID = 6410406311551778462L;

    @Id
    @Column(name = "service_no")
    private String serviceNo;

    @Column(name = "dp_name")
    private String dpName;

    @Column(name = "dp_sex")
    private Integer dpSex;

    @Column(name = "dp_age")
    private Integer dpAge;

    @Column(name = "dp_cert_no")
    private String dpCertNo;

    @Column(name = "dp_cert_type")
    private Integer dpCertType;

    @Column(name = "ut_name")
    private String utName;

    @Column(name = "ut_cert_no")
    private String utCertNo;

    @Column(name = "ut_cert_type")
    private Integer utCertType;

    @Column(name = "d_id")
    private Integer dId;

    @Column(name = "d_position")
    private String dPosition;

    @Column(name = "d_status")
    private Integer dStatus;

    @Column(name = "h_id")
    private Integer hId;

    @Column(name = "h_position")
    private String hPosition;

    @Column(name = "h_status")
    private Integer hStatus;

    private String phone;

    public String getServiceNo() {
        return serviceNo;
    }

    public void setServiceNo(String serviceNo) {
        this.serviceNo = serviceNo;
    }

    public String getDpName() {
        return dpName;
    }

    public void setDpName(String dpName) {
        this.dpName = dpName;
    }

    public Integer getDpSex() {
        return dpSex;
    }

    public void setDpSex(Integer dpSex) {
        this.dpSex = dpSex;
    }

    public Integer getDpAge() {
        return dpAge;
    }

    public void setDpAge(Integer dpAge) {
        this.dpAge = dpAge;
    }

    public String getDpCertNo() {
        return dpCertNo;
    }

    public void setDpCertNo(String dpCertNo) {
        this.dpCertNo = dpCertNo;
    }

    public String getUtName() {
        return utName;
    }

    public void setUtName(String utName) {
        this.utName = utName;
    }

    public String getUtCertNo() {
        return utCertNo;
    }

    public void setUtCertNo(String utCertNo) {
        this.utCertNo = utCertNo;
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public String getdPosition() {
        return dPosition;
    }

    public void setdPosition(String dPosition) {
        this.dPosition = dPosition;
    }

    public Integer gethId() {
        return hId;
    }

    public void sethId(Integer hId) {
        this.hId = hId;
    }

    public String gethPosition() {
        return hPosition;
    }

    public void sethPosition(String hPosition) {
        this.hPosition = hPosition;
    }

    public Integer getDpCertType() {
        return dpCertType;
    }

    public void setDpCertType(Integer dpCertType) {
        this.dpCertType = dpCertType;
    }

    public Integer getUtCertType() {
        return utCertType;
    }

    public void setUtCertType(Integer utCertType) {
        this.utCertType = utCertType;
    }

    public Integer getdStatus() {
        return dStatus;
    }

    public void setdStatus(Integer dStatus) {
        this.dStatus = dStatus;
    }

    public Integer gethStatus() {
        return hStatus;
    }

    public void sethStatus(Integer hStatus) {
        this.hStatus = hStatus;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
