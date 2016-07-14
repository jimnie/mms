package com.educonsulting.mms.entity;

import javax.persistence.*;

/**
 * Created by Wayne on 2015/7/3.
 */
@Entity
@Table(name = "mms_sys_authority")
public class Authority extends BaseEntity {

    private static final long serialVersionUID = -7266418510327333601L;

    private String perms;

    private Long roleId;

    private Long resourceId;

    private String resourceName;

    private String actName;

    private String actAlias;

    private Role role;

    private Resources resource;

    @Column(name = "perms")
    public String getPerms() {
        return perms;
    }

    public void setPerms(String perms) {
        this.perms = perms;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinTable(name = "mms_sys_resource_auth",
            joinColumns = {@JoinColumn(name = "auth_id")},
            inverseJoinColumns = {@JoinColumn(name = "resource_id")})
    public Resources getResource() {
        return resource;
    }

    public void setResource(Resources resource) {
        this.resource = resource;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinTable(name = "mms_sys_auth_role",
            joinColumns = {@JoinColumn(name = "auth_id")},
            inverseJoinColumns = {@JoinColumn(name = "role_id")})
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getResourceId() {
        return resourceId;
    }

    public void setResourceId(Long resourceId) {
        this.resourceId = resourceId;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public String getActName() {
        return actName;
    }

    public void setActName(String actName) {
        this.actName = actName;
    }

    public String getActAlias() {
        return actAlias;
    }

    public void setActAlias(String actAlias) {
        this.actAlias = actAlias;
    }
}
