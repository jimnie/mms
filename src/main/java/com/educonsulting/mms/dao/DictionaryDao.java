package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Dictionary;

import java.util.List;

/**
 * Created by Wayne on 2015/7/4.
 */
public interface DictionaryDao extends BaseDao<Dictionary, Long> {

    List<Dictionary> findDict(String fieldName);
}
