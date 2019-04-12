package com.educonsulting.mms.service;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Draw;

import java.util.List;

public interface DrawService extends BaseService<Draw, Long> {

    boolean isServiceNoExist(String serviceNo);

    Page<Draw> findpage(Pageable pageable);

    String buildPdf(String serviceNo, String fileName, String type);

    public List<Draw> findDepositByServiceNo(String serviceNo);
}
