package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Shelf;

import java.util.List;

public interface ShelfDao extends BaseDao<Shelf, Long> {

    List<Shelf> findIdelShelf(Integer status);

    Shelf findShelfByCode(String code);

}
