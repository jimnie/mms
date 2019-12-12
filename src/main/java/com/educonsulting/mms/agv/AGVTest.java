package com.educonsulting.mms.agv;

public class AGVTest {

    public static void main(String[] args) throws Exception {
        String ip = "192.168.18.83";
        Integer port = 502;
        int time = 200;
        AGVFunction agv = new AGVFunction();
//        agv.queryStatus(ip, port); // 查询agv状态

        agv.setTaskCompletion(ip, port);
//        Thread.sleep(time);
//
//        agv.toStationNo2(ip, port); // 到站点2
        agv.toStationNo1(ip, port); // 到站点1
//
//        Thread.sleep(time);
        agv.setTaskQuantity(ip, port);
//        Thread.sleep(time);
        agv.start(ip, port);
    }
}
