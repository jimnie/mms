package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.agv.AGVFunction;
import com.educonsulting.mms.agv.AGVStatus;
import com.educonsulting.mms.agv.AGVUtil;
import com.educonsulting.mms.service.AGVService;
import org.springframework.stereotype.Service;

import java.util.Arrays;

@Service("agvServiceImpl")
public class AGVServiceImpl implements AGVService {

    @Override
    public AGVStatus queryAgvStatusInf() {
        return queryStatusAndInf();
    }

    @Override
    public void callAgvToStation1() {
        try {
//        AGVFunction.queryStatus(ip, port); // 查询agv状态
            AGVFunction.setTaskCompletion(AGVUtil.AGV_IP, AGVUtil.AGV_PORT);
            AGVFunction.toStationNo1(AGVUtil.AGV_IP, AGVUtil.AGV_PORT); // 到站点1
            AGVFunction.setTaskQuantity(AGVUtil.AGV_IP, AGVUtil.AGV_PORT);
            AGVFunction.start(AGVUtil.AGV_IP, AGVUtil.AGV_PORT);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void callAgvToStation2() {
        try {
//        AGVFunction.queryStatus(ip, port); // 查询agv状态
            AGVFunction.setTaskCompletion(AGVUtil.AGV_IP, AGVUtil.AGV_PORT);
            AGVFunction.toStationNo2(AGVUtil.AGV_IP, AGVUtil.AGV_PORT); // 到站点2
            AGVFunction.setTaskQuantity(AGVUtil.AGV_IP, AGVUtil.AGV_PORT);
            AGVFunction.start(AGVUtil.AGV_IP, AGVUtil.AGV_PORT);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private AGVStatus queryStatusAndInf() {
        AGVStatus status = null;
        try {
            byte[] stBytes = AGVFunction.queryStatus(AGVUtil.AGV_IP, AGVUtil.AGV_PORT);
            Thread.sleep(300);
            byte[] infBytes = AGVFunction.queryInf(AGVUtil.AGV_IP, AGVUtil.AGV_PORT);
            if (stBytes.length == AGVStatus.QUERY_STATUS_RES_LEN
                    && infBytes.length == AGVStatus.QUERY_INF_RES_LEN) {
                status = new AGVStatus();
                status.parseQueryStatus(stBytes);
                status.parseQueryInf(Arrays.copyOfRange(infBytes, AGVStatus.QUERY_INF_BEGIN_IND, AGVStatus.QUERY_INF_END_IND));
            }
        } catch (Exception e) {
            e.printStackTrace();
            status = null;
        }
        return status;
    }
}
