package com.educonsulting.mms.entity;

import com.educonsulting.mms.JsonDateSerializer;
import com.educonsulting.mms.listener.EntityListener;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import javax.persistence.*;
import javax.validation.groups.Default;
import java.io.Serializable;
import java.util.Date;

@EntityListeners(EntityListener.class)
@MappedSuperclass
public abstract class BaseEntity implements Serializable {

    private static final long serialVersionUID = -67188388306700736L;

    public static final String ID_PROPERTY_NAME = "id";

    public static final String CREATE_DATE_PROPERTY_NAME = "createDate";

    public static final String MODIFY_DATE_PROPERTY_NAME = "modifyDate";

    public interface Save extends Default {

    }

    public interface Update extends Default {

    }

    private Long id;

    private Date createDate;

    private Date modifyDate;

    @Id
    @JsonProperty
    @GeneratedValue(strategy = GenerationType.AUTO)
    /*@Column(length = 32, nullable = false)
    @GeneratedValue(generator = "uuidGenerator") //指定生成器名称
    @GenericGenerator(name = "uuidGenerator", strategy = "uuid") //生成器名称，uuid生成类*/
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @JsonProperty
    @JsonSerialize(using = JsonDateSerializer.class)
    @Column(nullable = false, updatable = false)
    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    @JsonProperty
    @JsonSerialize(using = JsonDateSerializer.class)
    @Column(nullable = false)
    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        if (!BaseEntity.class.isAssignableFrom(obj.getClass())) {
            return false;
        }
        BaseEntity other = (BaseEntity) obj;
        return getId() != null ? getId().equals(other.getId()) : false;
    }

    @Override
    public int hashCode() {
        int hashCode = 17;
        hashCode += null == getId() ? 0 : getId().hashCode() * 31;
        return hashCode;
    }
}