package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Role;

public interface RoleService extends BaseService<Role, Long> {
    boolean isTagNameExists(String tag);
}