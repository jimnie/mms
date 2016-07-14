package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Dictionary;

import java.util.List;

/**
 * Created by Wayne on 2015/7/4.
 */
public interface DictionaryService extends BaseService<Dictionary, Long> {

    List<Dictionary> findDict(String fieldName);
}
