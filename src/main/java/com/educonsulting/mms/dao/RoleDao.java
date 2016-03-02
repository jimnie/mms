package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Role;

public interface RoleDao extends BaseDao<Role, String> {
    boolean isTagNameExists(String tag);
}