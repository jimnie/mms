package com.educonsulting.mms.agv;

import org.bouncycastle.util.Arrays;

public class AGVStatus {

    public static final int STATUS_ADDR_AT_256 = 4;

    public static final int STATUS_ADDR_AT_257 = 6;

    public static final int CURRENT_POSITION_IND = 0;

    public static final int CURRENT_CONTROL_AREA_IND = 2;

    public static final int BATTERY_BALANCE_IND = 4;

    public static final int FAULT_INF_CODE_IND = 6;

    public static final int CURRENT_SPEED_IND = 10;

    public static final int QUERY_INF_BEGIN_IND = 3;

    public static final int QUERY_INF_END_IND = 17;

    public static final int QUERY_STATUS_RES_LEN = 9;

    public static final int QUERY_INF_RES_LEN = 19;

    /**
     * 以下状态地址为0x0100
     */
    private boolean isFaultInf; // 故障信息 7

    private boolean isMissingStat; // 失联状态 6

    private boolean isCtrlRelease; // 管制放行 5

    private boolean isTrafficCtrl; // 交通管制 4

    private boolean isTaskLocking; // 任务锁定 3

    private boolean isTaskNull; // 任务空 2

    private boolean isMovingOrNot; // 运动或静止 1

    private boolean isStartUpOrAwait; // 启动或待机 0

    /**
     * 以下状态地址为0x0101
     */
    private boolean isCharging; // 正在充电 7

    private boolean isTaskExecuting; // 任务执行中 6

    private boolean isStopByObstacle; // 障碍停止 5

    private boolean isPauseByMainCtrl; // 主控暂停 4

    private boolean isPauseByExternalCtrl; // 外控暂停 3

    private boolean isStraightOrOblique; // 直行或侧向 2

    private boolean isLateralOrTurning; // 平移或转向 1

    private boolean isForwardOrBack; // 前进或后退 0

    private Integer currPosition; // 0x1000 当前位置

    private Integer controlArea; // 0x1001 当前管制区域

    private Integer batteryBalance; // 0x1002 剩余电量

    private Integer faultCode; // 0x1003 故障信息编码

    private Integer currSpeed; // 0x1005 当前速度

    public boolean isFaultInf() {
        return isFaultInf;
    }

    public void setFaultInf(boolean faultInf) {
        isFaultInf = faultInf;
    }

    public boolean isMissingStat() {
        return isMissingStat;
    }

    public void setMissingStat(boolean missingStat) {
        isMissingStat = missingStat;
    }

    public boolean isCtrlRelease() {
        return isCtrlRelease;
    }

    public void setCtrlRelease(boolean ctrlRelease) {
        isCtrlRelease = ctrlRelease;
    }

    public boolean isTrafficCtrl() {
        return isTrafficCtrl;
    }

    public void setTrafficCtrl(boolean trafficCtrl) {
        isTrafficCtrl = trafficCtrl;
    }

    public boolean isTaskLocking() {
        return isTaskLocking;
    }

    public void setTaskLocking(boolean taskLocking) {
        isTaskLocking = taskLocking;
    }

    public boolean isTaskNull() {
        return isTaskNull;
    }

    public void setTaskNull(boolean taskNull) {
        isTaskNull = taskNull;
    }

    public boolean isMovingOrNot() {
        return isMovingOrNot;
    }

    public void setMovingOrNot(boolean movingOrNot) {
        isMovingOrNot = movingOrNot;
    }

    public boolean isStartUpOrAwait() {
        return isStartUpOrAwait;
    }

    public void setStartUpOrAwait(boolean startUpOrAwait) {
        isStartUpOrAwait = startUpOrAwait;
    }

    public boolean isCharging() {
        return isCharging;
    }

    public void setCharging(boolean charging) {
        isCharging = charging;
    }

    public boolean isTaskExecuting() {
        return isTaskExecuting;
    }

    public void setTaskExecuting(boolean taskExecuting) {
        isTaskExecuting = taskExecuting;
    }

    public boolean isStopByObstacle() {
        return isStopByObstacle;
    }

    public void setStopByObstacle(boolean stopByObstacle) {
        isStopByObstacle = stopByObstacle;
    }

    public boolean isPauseByMainCtrl() {
        return isPauseByMainCtrl;
    }

    public void setPauseByMainCtrl(boolean pauseByMainCtrl) {
        isPauseByMainCtrl = pauseByMainCtrl;
    }

    public boolean isPauseByExternalCtrl() {
        return isPauseByExternalCtrl;
    }

    public void setPauseByExternalCtrl(boolean pauseByExternalCtrl) {
        isPauseByExternalCtrl = pauseByExternalCtrl;
    }

    public boolean isStraightOrOblique() {
        return isStraightOrOblique;
    }

    public void setStraightOrOblique(boolean straightOrOblique) {
        isStraightOrOblique = straightOrOblique;
    }

    public boolean isLateralOrTurning() {
        return isLateralOrTurning;
    }

    public void setLateralOrTurning(boolean lateralOrTurning) {
        isLateralOrTurning = lateralOrTurning;
    }

    public boolean isForwardOrBack() {
        return isForwardOrBack;
    }

    public void setForwardOrBack(boolean forwardOrBack) {
        isForwardOrBack = forwardOrBack;
    }

    public Integer getCurrPosition() {
        return currPosition;
    }

    public void setCurrPosition(Integer currPosition) {
        this.currPosition = currPosition;
    }

    public Integer getControlArea() {
        return controlArea;
    }

    public void setControlArea(Integer controlArea) {
        this.controlArea = controlArea;
    }

    public Integer getBatteryBalance() {
        return batteryBalance;
    }

    public void setBatteryBalance(Integer batteryBalance) {
        this.batteryBalance = batteryBalance;
    }

    public Integer getFaultCode() {
        return faultCode;
    }

    public void setFaultCode(Integer faultCode) {
        this.faultCode = faultCode;
    }

    public Integer getCurrSpeed() {
        return currSpeed;
    }

    public void setCurrSpeed(Integer currSpeed) {
        this.currSpeed = currSpeed;
    }

    /**
     * 状态查询结果转为状态
     *
     * @param bytes
     */
    public void parseQueryStatus(byte[] bytes) {
        String status = Integer.toBinaryString((bytes[STATUS_ADDR_AT_256] & 0xFF) + 0x100).substring(1);
        char[] arr = status.toCharArray();
        this.setFaultInf(Integer.parseInt(String.valueOf(arr[0])) == 1);
        this.setMissingStat(Integer.parseInt(String.valueOf(arr[1])) == 1);
        this.setCtrlRelease(Integer.parseInt(String.valueOf(arr[2])) == 1);
        this.setTrafficCtrl(Integer.parseInt(String.valueOf(arr[3])) == 1);
        this.setTaskLocking(Integer.parseInt(String.valueOf(arr[4])) == 1);
        this.setTaskNull(Integer.parseInt(String.valueOf(arr[5])) == 1);
        this.setMovingOrNot(Integer.parseInt(String.valueOf(arr[6])) == 1);
        this.setStartUpOrAwait(Integer.parseInt(String.valueOf(arr[7])) == 1);

        status = Integer.toBinaryString((bytes[STATUS_ADDR_AT_257] & 0xFF) + 0x100).substring(1);
        arr = status.toCharArray();
        this.setCharging(Integer.parseInt(String.valueOf(arr[0])) == 1);
        this.setTaskExecuting(Integer.parseInt(String.valueOf(arr[1])) == 1);
        this.setStopByObstacle(Integer.parseInt(String.valueOf(arr[2])) == 1);
        this.setPauseByMainCtrl(Integer.parseInt(String.valueOf(arr[3])) == 1);
        this.setPauseByExternalCtrl(Integer.parseInt(String.valueOf(arr[4])) == 1);
        this.setStraightOrOblique(Integer.parseInt(String.valueOf(arr[5])) == 1);
        this.setLateralOrTurning(Integer.parseInt(String.valueOf(arr[6])) == 1);
        this.setForwardOrBack(Integer.parseInt(String.valueOf(arr[7])) == 1);
    }

    /**
     * 信息寄存器数据转为状态
     *
     * @param bytes
     */
    public void parseQueryInf(byte[] bytes) {
        this.setCurrPosition(Integer.parseInt(AGVUtil.binary(Arrays.copyOfRange(bytes, CURRENT_POSITION_IND, CURRENT_POSITION_IND + 2), 10)));
        this.setControlArea(Integer.parseInt(AGVUtil.binary(Arrays.copyOfRange(bytes, CURRENT_CONTROL_AREA_IND, CURRENT_CONTROL_AREA_IND + 2), 10)));
        this.setBatteryBalance(Integer.parseInt(AGVUtil.binary(Arrays.copyOfRange(bytes, BATTERY_BALANCE_IND, BATTERY_BALANCE_IND + 2), 10)));
        this.setFaultCode(Integer.parseInt(AGVUtil.binary(Arrays.copyOfRange(bytes, FAULT_INF_CODE_IND, FAULT_INF_CODE_IND + 2), 10)));
        this.setCurrSpeed(Integer.parseInt(AGVUtil.binary(Arrays.copyOfRange(bytes, CURRENT_SPEED_IND, CURRENT_SPEED_IND + 2), 10)));
    }

    public static void main(String[] args) {
//        byte[] bytes = new byte[]{0x01, 0x03, 0x04, 0x00, 0x61, 0x00, 0x40, (byte) 0xAA, 0x1D};
//        System.out.println(Integer.toBinaryString((bytes[AGVUtil.STATUS_ADDR_AT_256] & 0xFF) + 0x100).substring(1));
//        System.out.println(Integer.toBinaryString((bytes[AGVUtil.STATUS_ADDR_AT_257] & 0xFF) + 0x100).substring(1));

       /* byte[] bytes = new byte[]{0x01, 0x03, 0x0E, 0x03, (byte) 0xE8, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, (byte) 0x8D, 0x3F};
        byte[] copyOfRange = Arrays.copyOfRange(bytes, 3, 17);
        System.out.println(AGVUtil.binary(Arrays.copyOfRange(copyOfRange, CURRENT_POSITION_IND, CURRENT_POSITION_IND + 2), 10));
        System.out.println(AGVUtil.binary(Arrays.copyOfRange(copyOfRange, CURRENT_CONTROL_AREA_IND, CURRENT_CONTROL_AREA_IND  + 2), 10));
        System.out.println(AGVUtil.binary(Arrays.copyOfRange(copyOfRange, BATTERY_BALANCE_IND, BATTERY_BALANCE_IND  + 2), 10));
        System.out.println(AGVUtil.binary(Arrays.copyOfRange(copyOfRange, FAULT_INF_CODE_IND, FAULT_INF_CODE_IND  + 2), 10));
        System.out.println(AGVUtil.binary(Arrays.copyOfRange(copyOfRange, CURRENT_SPEED_IND, CURRENT_SPEED_IND  + 2), 10));*/
        char a = 1;
        System.out.println((char) 1);
        System.out.println((char) 0);
    }
}