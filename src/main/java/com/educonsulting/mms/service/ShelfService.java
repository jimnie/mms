package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Shelf;

import java.util.List;

public interface ShelfService extends BaseService<Shelf, Long> {

    List<Shelf> findIdelShelf(Integer status);

    Shelf findShelfByCode(String code);
}
