package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Bag;

import java.util.List;

public interface BagDao extends BaseDao<Bag, Long> {

    List<Bag> findBagByDpCertNoAndStatus(String dpCertNo, Integer status);

    List<Bag> findBagByDpCertNo(String dpCertNo);

    List<Bag> findBagByServiceNo(String serviceNo);
}
