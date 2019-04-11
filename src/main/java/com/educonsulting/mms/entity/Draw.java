package com.educonsulting.mms.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Entity
@Table(name = "mms_inf_draw")
public class Draw extends BaseEntity {

    private static final long serialVersionUID = 6396453961861884792L;

    private String serviceNo;

    private String dpName;

    private Integer dpSex;

    private Integer dpAge;

    private Integer dpCertType;

    private String dpCertNo;

    private String utName;

    private Integer utCertType;

    private String utCertNo;

    private String phone;

    private Integer drawType;

    private Date drawDate;
    // 收回；丢失；
    private Integer invoiceState;
    // 收回；丢失；损坏
    private Integer magcardState;

    private String memo;

    private Long hId;

    private Long dId;

    private String signPic;
    // 领取经办人
    private String createdBy;

    @NotNull
    @Column(name = "service_no", nullable = false, unique = true, length = 11)
    public String getServiceNo() {
        return serviceNo;
    }

    public void setServiceNo(String serviceNo) {
        this.serviceNo = serviceNo;
    }

    @NotNull
    @Column(name = "ut_name", nullable = false, length = 50)
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
    @Column(name = "phone", nullable = false, length = 20)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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
    @Column(name = "draw_date", nullable = false, columnDefinition = "date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", locale = "zh")
    public Date getDrawDate() {
        return drawDate;
    }

    public void setDrawDate(Date drawDate) {
        this.drawDate = drawDate;
    }

    @NotNull
    @Column(name = "invoice_state")
    public Integer getInvoiceState() {
        return invoiceState;
    }

    public void setInvoiceState(Integer invoiceState) {
        this.invoiceState = invoiceState;
    }

    @NotNull
    @Column(name = "magcard_state")
    public Integer getMagcardState() {
        return magcardState;
    }

    public void setMagcardState(Integer magcardState) {
        this.magcardState = magcardState;
    }

    @Column(name = "memo", columnDefinition = "text")
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Column(name = "h_id")
    public Long gethId() {
        return hId;
    }

    public void sethId(Long hId) {
        this.hId = hId;
    }

    @Column(name = "d_id")
    public Long getdId() {
        return dId;
    }

    public void setdId(Long dId) {
        this.dId = dId;
    }

    @NotNull
    @Column(name = "sign_pic", nullable = false, length = 50)
    public String getSignPic() {
        return signPic;
    }

    public void setSignPic(String signPic) {
        this.signPic = signPic;
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
    @Column(name = "dp_draw_type")
    public Integer getDrawType() {
        return drawType;
    }

    public void setDrawType(Integer drawType) {
        this.drawType = drawType;
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
    @Column(name = "created_by", nullable = false, length = 20)
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
}
