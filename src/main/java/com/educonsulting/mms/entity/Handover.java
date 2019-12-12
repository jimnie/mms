package com.educonsulting.mms.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Entity
@Table(name = "mms_inf_handover")
public class Handover extends BaseEntity {

    private static final long serialVersionUID = 7817195853770472844L;
    // 业务编号
    private String serviceNo;
    // 逝者姓名
    private String dpName;
    // 逝者性别
    private Integer dpSex;
    // 逝者年龄
    private Integer dpAge;
    // 接收状态
    private Integer status;
    // 交接经办人
    private String rcpAgent;
    // 交接经办日期
    private Date rcpDate;
    // 领取经办人
    private String drawAgent;
    // 领取经办日期
    private Date drawDate;
    // 存放位置
    private String position;
    // rfid
    private String rfid;

    @NotNull
    @Column(name = "service_no", nullable = false, unique = true, length = 16)
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
    @Column(name = "status")
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @NotNull
    @Column(name = "rcp_agent", nullable = false, length = 20)
    public String getRcpAgent() {
        return rcpAgent;
    }

    public void setRcpAgent(String rcpAgent) {
        this.rcpAgent = rcpAgent;
    }

    @NotNull
    @Column(name = "rcp_date", nullable = false, columnDefinition = "datetime")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", locale = "zh", timezone = "GMT+8")
    public Date getRcpDate() {
        return rcpDate;
    }

    public void setRcpDate(Date rcpDate) {
        this.rcpDate = rcpDate;
    }

    @Column(name = "draw_agent", length = 20)
    public String getDrawAgent() {
        return drawAgent;
    }

    public void setDrawAgent(String drawAgent) {
        this.drawAgent = drawAgent;
    }

    @Column(name = "draw_date", columnDefinition = "datetime")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", locale = "zh", timezone = "GMT+8")
    public Date getDrawDate() {
        return drawDate;
    }

    public void setDrawDate(Date drawDate) {
        this.drawDate = drawDate;
    }

    @NotNull
    @Column(name = "position", nullable = false, length = 20)
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    @NotNull
    @Column(name = "rfid", nullable = false, length = 50)
    public String getRfid() {
        return rfid;
    }

    public void setRfid(String rfid) {
        this.rfid = rfid;
    }
}
