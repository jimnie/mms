package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Bag;

import java.util.List;

public interface BagService extends BaseService<Bag, Long> {

    List<Bag> findBagByDpCertNoAndStatus(String dpCertNo, Integer status);

    List<Bag> findBagByDpCertNo(String dpCertNo);

    List<Bag> findBagByServiceNo(String serviceNo);
}
