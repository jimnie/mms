package com.rcbank.mms.service;

import com.rcbank.mms.entity.Group;

/**
 * Created by Wayne on 2015/7/7.
 */
public interface GroupService extends BaseService<Group, Long> {

    Object getTree();

    Group findRoot();

    Group findGroup(Long id);

    boolean isTagNameExists(String tag);
}
