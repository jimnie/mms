package com.rcbank.mms.dao;

import com.rcbank.mms.entity.Dictionary;

import java.util.List;

/**
 * Created by Wayne on 2015/7/4.
 */
public interface DictionaryDao extends BaseDao<Dictionary, Long> {

    List<Dictionary> findDict(String fieldName);
}
