package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.DHMatch;

import java.util.List;

public interface DHMatchService {

    List<DHMatch> findDHMatch(String serviceNo, String dpName);
}
