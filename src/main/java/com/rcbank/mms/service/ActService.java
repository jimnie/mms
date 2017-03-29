package com.rcbank.mms.service;

import com.rcbank.mms.entity.Act;

/**
 * Created by Wayne on 2015/7/16.
 */
public interface ActService extends BaseService<Act, Long> {
    boolean isAliasExists(String tag);

}
