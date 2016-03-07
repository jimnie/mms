package com.educonsulting.mms.entity;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Wayne on 2016/3/3.
 */

@Entity
@Table(name = "mms_inf_member_rank")
public class MemberRank extends BaseEntity {

    private static final long serialVersionUID = -997054127954014690L;

    private String name;

    private Double scale;

    private BigDecimal amount;

    private Boolean isDefault;

    private Boolean isSpecial;

    private Set<Member> members = new HashSet<Member>();

    @NotEmpty
    @Length(max = 100)
    @Column(nullable = false, unique = true, length = 100)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @NotNull
    @Min(0)
    @Digits(integer = 3, fraction = 3)
    @Column(nullable = false, precision = 12, scale = 6)
    public Double getScale() {
        return scale;
    }

    public void setScale(Double scale) {
        this.scale = scale;
    }

    @Min(0)
    @Digits(integer = 12, fraction = 3)
    @Column(unique = true, precision = 21, scale = 6)
    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    @NotNull
    @Column(nullable = false)
    public Boolean getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(Boolean isDefault) {
        this.isDefault = isDefault;
    }

    @NotNull
    @Column(nullable = false)
    public Boolean getIsSpecial() {
        return isSpecial;
    }

    public void setIsSpecial(Boolean isSpecial) {
        this.isSpecial = isSpecial;
    }

    @OneToMany(mappedBy = "memberRank", fetch = FetchType.LAZY)
    public Set<Member> getMembers() {
        return members;
    }

    public void setMembers(Set<Member> members) {
        this.members = members;
    }

}
