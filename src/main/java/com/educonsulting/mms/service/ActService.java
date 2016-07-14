package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Act;

/**
 * Created by Wayne on 2015/7/16.
 */
public interface ActService extends BaseService<Act, Long> {
    boolean isAliasExists(String tag);

}
