package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Act;

/**
 * Created by Wayne on 2015/7/16.
 */
public interface ActDao extends BaseDao<Act, String> {

    boolean isAliasExists(String tag);

}
