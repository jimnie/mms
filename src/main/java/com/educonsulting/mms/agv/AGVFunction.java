package com.educonsulting.mms.agv;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Arrays;

public class AGVFunction {

    /**
     * 查询AGV状态指令
     *
     * @param ip
     * @param port
     * @return 返回的响应报文应从索引3开始截取到索引7
     * @throws IOException
     */
    public static byte[] queryStatus(String ip, Integer port) throws Exception {
        System.out.println("查询AGV状态");
        byte[] order = new byte[]{0x01, 0x03, 0x01, 0x00, 0x00, 0x02};
        return sendRequest(ip, port, AGVUtil.generateBytesWithCRC(order));
    }

    /**
     * 查询AGV信息寄存器
     *
     * @param ip
     * @param port
     * @return 返回的响应报文应从索引3开始截取到索引17
     * @throws IOException
     */
    public static byte[] queryInf(String ip, Integer port) throws Exception {
        System.out.println("查询AGV信息");
        byte[] order = new byte[]{0x01, 0x03, 0x10, 0x00, 0x00, 0x07};
        return sendRequest(ip, port, AGVUtil.generateBytesWithCRC(order));
    }

    /**
     * 设置AGV任务完成
     *
     * @param ip
     * @param port
     * @throws IOException
     */
    public static byte[] setTaskCompletion(String ip, Integer port) throws Exception {
        System.out.println("设置AGV任务完成");
        byte[] order = new byte[]{0x01, 0x10, 0x02, 0x01, 0x00, 0x01, 0x02, 0x00, 0x02};
        return sendRequest(ip, port, AGVUtil.generateBytesWithCRC(order));
    }

    /**
     * 启动AGV指令
     *
     * @param ip
     * @param port
     * @throws IOException
     */
    public static byte[] start(String ip, Integer port) throws Exception {
        System.out.println("启动AGV");
        byte[] order = new byte[]{0x01, 0x06, 0x02, 0x00, 0x00, 0x11}; // 启动指令
        return sendRequest(ip, port, AGVUtil.generateBytesWithCRC(order));
    }

    /**
     * 设置AGV导入任务数量
     *
     * @param ip
     * @param port
     * @throws IOException
     */
    public static byte[] setTaskQuantity(String ip, Integer port) throws Exception {
        System.out.println("设置AGV导入任务数量");
        byte[] order = new byte[]{0x01, 0x10, 0x23, (byte) 0xE8, 0x00, 0x01, 0x02, 0x00, 0x01};
        return sendRequest(ip, port, AGVUtil.generateBytesWithCRC(order));
    }

    /**
     * 设置AGV任务从站点2到站点1
     *
     * @param ip
     * @param port
     * @throws IOException
     */
    public static byte[] toStationNo1(String ip, Integer port) throws Exception {
        System.out.println("设置AGV到站点1");
        byte[] order = new byte[]{0x01, 0x10, 0x20, 0x00, 0x00, 0x01, 0x02, 0x00, 0x01};
        return sendRequest(ip, port, AGVUtil.generateBytesWithCRC(order));
    }

    /**
     * 设置AGV任务从站点1到站点2
     *
     * @param ip
     * @param port
     * @throws IOException
     */
    public static byte[] toStationNo2(String ip, Integer port) throws Exception {
        System.out.println("设置AGV到站点2");
        byte[] order = new byte[]{0x01, 0x10, 0x20, 0x00, 0x00, 0x01, 0x02, 0x00, 0x02};
        return sendRequest(ip, port, AGVUtil.generateBytesWithCRC(order));
    }

    /**
     * 执行请求发送
     *
     * @param ip
     * @param port
     * @param bytes
     * @throws IOException
     */
    public static byte[] sendRequest(String ip, Integer port, byte[] bytes) throws Exception {
        System.out.print("Tx:");
        AGVUtil.printHexString(bytes);
        Socket socket = new Socket();
        socket.setSoTimeout(3000);
        socket.connect(new InetSocketAddress(ip, port), 3000);

        OutputStream os = socket.getOutputStream();
        os.write(bytes);
        os.flush();

        InputStream is = socket.getInputStream();
        byte[] revBytes = new byte[32];
        is.read(revBytes);

        int len = AGVUtil.getActualLength(revBytes);

        System.out.print("Rx:");
        AGVUtil.printHexString(Arrays.copyOfRange(revBytes, 0, len)); // 输出十六进制

        if (!socket.isInputShutdown()) {
            is.close();
        }
        if (!socket.isOutputShutdown()) {
            os.close();
        }
        if (socket.isConnected()) {
            socket.close();
        }
        return Arrays.copyOfRange(revBytes, 0, len); // 返回实际长度的响应报文
    }

}
