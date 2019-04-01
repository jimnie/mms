package com.educonsulting.mms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "mms_inf_shelf")
public class Shelf extends BaseEntity {

    private static final long serialVersionUID = -8997573542408995767L;
    // 货架编号
    private String code;
    // 货架占用状态，0：空闲；1：占用
    private Integer status;

    @NotNull
    @Column(nullable = false, length = 3, unique = true)
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @NotNull
    @Column(nullable = false)
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
