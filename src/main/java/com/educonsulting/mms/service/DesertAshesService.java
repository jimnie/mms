package com.educonsulting.mms.service;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.DesertAshes;

import java.util.List;

public interface DesertAshesService extends BaseService<DesertAshes, Long> {

    boolean isServiceNoExist(String serviceNo);

    Page<DesertAshes> findpage(Pageable pageable);

    String buildPdf(String serviceNo);

    List<DesertAshes> findDesertAshesByServiceNo(String serviceNo);

}
