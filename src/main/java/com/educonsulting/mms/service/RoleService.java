package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Role;

public interface RoleService extends BaseService<Role, String> {
    boolean isTagNameExists(String tag);
}