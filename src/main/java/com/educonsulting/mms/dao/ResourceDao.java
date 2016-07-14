package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Resources;

/**
 * Created by Wayne on 2015/7/12.
 */
public interface ResourceDao extends BaseDao<Resources, Long> {
    boolean isAliasNameExists(String aliasName);

    Resources findParents();

    Resources findSubnodes(String id);
}
