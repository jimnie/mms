package com.educonsulting.mms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "mms_inf_rfid")
public class RfidTag extends BaseEntity {

    private String tid;

    private String epc;

    private int status; // 使用状态：0,未使用；1,已使用

    @NotNull
    @Column(name = "tid", nullable = false, length = 16)
    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    @NotNull
    @Column(name = "epc", nullable = false, length = 24)
    public String getEpc() {
        return epc;
    }

    public void setEpc(String epc) {
        this.epc = epc;
    }

    @NotNull
    @Column(name = "status", nullable = false)
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
