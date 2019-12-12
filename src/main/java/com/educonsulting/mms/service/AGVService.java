package com.educonsulting.mms.service;

import com.educonsulting.mms.agv.AGVStatus;

public interface AGVService {

    AGVStatus queryAgvStatusInf();

    void callAgvToStation1();

    void callAgvToStation2();

}
