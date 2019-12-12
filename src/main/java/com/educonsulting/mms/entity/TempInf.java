package com.educonsulting.mms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "mms_temp_inf")
public class TempInf extends BaseEntity {

    private static final long serialVersionUID = 5901966216475155623L;

    /**
     * 业务编号
     */
    private String serviceNo;

    /**
     * RFID号
     */
    private String rfid;

    /**
     * 逝者姓名
     */
    private String dsName;

    /**
     * 逝者性别
     */
    private Integer dsSex;

    /**
     * 逝者年龄
     */
    private Integer dsAge;

    /**
     * 逝者证件号
     */
    private String dsCertNo;

    /**
     * 逝者住址（即身份证）
     */
    private String dsAddr;

    /**
     * 代办人姓名
     */
    private String name;

    /**
     * 代办人证件号
     */
    private String agentCertNo;

    /**
     * 代办人地址
     */
    private String agentAddr;

    /**
     * 代办人电话
     */
    private String phone;

    @NotNull
    @Column(name = "service_no", nullable = false, unique = true, length = 16)
    public String getServiceNo() {
        return serviceNo;
    }

    public void setServiceNo(String serviceNo) {
        this.serviceNo = serviceNo;
    }

    @NotNull
    @Column(name = "rfid", nullable = false, length = 50)
    public String getRfid() {
        return rfid;
    }

    public void setRfid(String rfid) {
        this.rfid = rfid;
    }

    @NotNull
    @Column(name = "ds_name", nullable = false, length = 50)
    public String getDsName() {
        return dsName;
    }

    public void setDsName(String dsName) {
        this.dsName = dsName;
    }

    public Integer getDsSex() {
        return dsSex;
    }

    public void setDsSex(Integer dsSex) {
        this.dsSex = dsSex;
    }

    public Integer getDsAge() {
        return dsAge;
    }

    public void setDsAge(Integer dsAge) {
        this.dsAge = dsAge;
    }

    @NotNull
    @Column(name = "ds_cert_no", nullable = false, length = 18)
    public String getDsCertNo() {
        return dsCertNo;
    }

    public void setDsCertNo(String dsCertNo) {
        this.dsCertNo = dsCertNo;
    }

    @NotNull
    @Column(name = "ds_addr", length = 255)
    public String getDsAddr() {
        return dsAddr;
    }

    public void setDsAddr(String dsAddr) {
        this.dsAddr = dsAddr;
    }

    @NotNull
    @Column(name = "name", nullable = false, length = 50)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @NotNull
    @Column(name = "agent_cert_no", nullable = false, length = 18)
    public String getAgentCertNo() {
        return agentCertNo;
    }

    public void setAgentCertNo(String agentCertNo) {
        this.agentCertNo = agentCertNo;
    }

    @NotNull
    @Column(name = "agent_addr", length = 255)
    public String getAgentAddr() {
        return agentAddr;
    }

    public void setAgentAddr(String agentAddr) {
        this.agentAddr = agentAddr;
    }

    @NotNull
    @Column(name = "phone", nullable = false, length = 20)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
