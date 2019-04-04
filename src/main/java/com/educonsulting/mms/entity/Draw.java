package com.educonsulting.mms.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "mms_inf_draw")
public class Draw extends BaseEntity {

    private static final long serialVersionUID = 6396453961861884792L;

    private String serivceNo;

    private String utName;

    private Integer utCertType;

    private String phone;

    private String utCertNo;

    private Date drawDate;
    // 收回；丢失；
    private Integer invoiceState;
    // 收回；丢失；损坏
    private Integer magcardState;

    private String memo;

    private Handover handover;

    private Deposit deposit;

    public String getSerivceNo() {
        return serivceNo;
    }

    public void setSerivceNo(String serivceNo) {
        this.serivceNo = serivceNo;
    }

    public String getUtName() {
        return utName;
    }

    public void setUtName(String utName) {
        this.utName = utName;
    }

    public Integer getUtCertType() {
        return utCertType;
    }

    public void setUtCertType(Integer utCertType) {
        this.utCertType = utCertType;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUtCertNo() {
        return utCertNo;
    }

    public void setUtCertNo(String utCertNo) {
        this.utCertNo = utCertNo;
    }

    public Date getDrawDate() {
        return drawDate;
    }

    public void setDrawDate(Date drawDate) {
        this.drawDate = drawDate;
    }

    public Integer getInvoiceState() {
        return invoiceState;
    }

    public void setInvoiceState(Integer invoiceState) {
        this.invoiceState = invoiceState;
    }

    public Integer getMagcardState() {
        return magcardState;
    }

    public void setMagcardState(Integer magcardState) {
        this.magcardState = magcardState;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public Handover getHandover() {
        return handover;
    }

    public void setHandover(Handover handover) {
        this.handover = handover;
    }

    public Deposit getDeposit() {
        return deposit;
    }

    public void setDeposit(Deposit deposit) {
        this.deposit = deposit;
    }
}
