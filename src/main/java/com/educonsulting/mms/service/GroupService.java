package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Group;

/**
 * Created by Wayne on 2015/7/7.
 */
public interface GroupService extends BaseService<Group, String> {

    Object getTree();

    Group findRoot();

    Group findGroup(String id);

    boolean isTagNameExists(String tag);
}
