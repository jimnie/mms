package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Group;

/**
 * Created by Wayne on 2015/7/7.
 */
public interface GroupDao extends BaseDao<Group, String> {
    Group findRoot();

    boolean isTagNameExists(String tag);
}
