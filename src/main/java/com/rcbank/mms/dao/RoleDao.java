package com.rcbank.mms.dao;

import com.rcbank.mms.entity.Role;

public interface RoleDao extends BaseDao<Role, Long> {
    boolean isTagNameExists(String tag);
}