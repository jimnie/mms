package com.rcbank.mms.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang.builder.CompareToBuilder;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.Min;

@MappedSuperclass
public abstract class OrderEntity extends BaseEntity implements Comparable<OrderEntity> {

    private static final long serialVersionUID = 5995013015967525827L;

    public static final String ORDER_PROPERTY_NAME = "order";

    private Integer order;

    @JsonProperty
    @Min(0)
    @Column(name = "orders")
    public Integer getOrder() {
        return order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

    public int compareTo(OrderEntity orderEntity) {
        return new CompareToBuilder().append(getOrder(), orderEntity.getOrder()).append(getId(),
                orderEntity.getId()).toComparison();
    }

}