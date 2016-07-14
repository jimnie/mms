package com.educonsulting.mms.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.math.BigDecimal;

/**
 * Created by Wayne on 2016/5/23.
 */
@Entity
@Table(name = "mms_inf_rechargelog")
public class RechargeLog extends BaseEntity {

    private static final long serialVersionUID = -349226521498067664L;

    public enum Type {

        recharge,

        hedging
    }

    private String cardNo;

    private String name;

    private String mobile;

    private Long memberid;

    private BigDecimal amount;

    private String operator;

    private Type type;

    private String memo;

    @JsonProperty
    @Column(nullable = false)
    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    @JsonProperty
    @Column(nullable = false)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @JsonProperty
    @Column(nullable = false)
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @JsonProperty
    @Column(nullable = false)
    public Long getMemberid() {
        return memberid;
    }

    public void setMemberid(Long memberid) {
        this.memberid = memberid;
    }

    @JsonProperty
    @Column(nullable = false)
    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    @JsonProperty
    @Column(nullable = false)
    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    @JsonProperty
    @Column(nullable = false, length = 1)
    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    @JsonProperty
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

}
