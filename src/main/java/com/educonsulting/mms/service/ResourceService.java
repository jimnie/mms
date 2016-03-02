package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Resources;

/**
 * Created by Wayne on 2015/7/12.
 */
public interface ResourceService extends BaseService<Resources, String> {

    Object getTree();

    Resources findParents();

    Resources findSubnodes(String id);

    boolean isAliasNameExists(String aliasName);
}
