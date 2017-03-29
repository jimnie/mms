package com.rcbank.mms.dao;

import com.rcbank.mms.entity.Act;

/**
 * Created by Wayne on 2015/7/16.
 */
public interface ActDao extends BaseDao<Act, Long> {

    boolean isAliasExists(String tag);

}
