package com.educonsulting.mms.agv;

import java.math.BigInteger;
import java.util.Arrays;

public class AGVUtil {

    public static final String AGV_IP = "192.168.7.200";

    public static final int AGV_PORT = 502;

    /**
     * 字符转十六进制字节
     *
     * @param c char
     * @return byte
     */
    public static byte charToByte(char c) {
        return (byte) "0123456789ABCDEF".indexOf(c);
    }

    /**
     * 将指定byte数组以16进制的形式打印到控制台
     *
     * @param b
     * @return
     */
    public static String printHexString(byte[] b) {
        String a = "";
        for (int i = 0; i < b.length; i++) {
            String hex = Integer.toHexString(b[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }

            if (i != 0 || i != b.length - 2) {
                a = a + hex.toUpperCase() + " ";
            } else {
                a = a + hex.toUpperCase();
            }
        }
        System.out.println(a);
        return a;
    }

    /**
     * 字节数组转16进制字符串
     * 这里我们可以将byte转换成int，
     * 然后利用Integer.toHexString(int)来转换成16进制字符串。
     *
     * @param src byte[] data
     * @return hex string
     */
    public static String bytesToHexString(byte[] src) {
        StringBuilder stringBuilder = new StringBuilder("");
        if (src == null || src.length <= 0) {
            return null;
        }
        for (int i = 0; i < src.length; i++) {
            int v = src[i] & 0xFF;
            String hv = Integer.toHexString(v);
            if (hv.length() < 2) {
                stringBuilder.append(0);
            }
            stringBuilder.append(hv);
        }
        return stringBuilder.toString();
    }

    /**
     * 16进制字符串转字节数组
     *
     * @param hexString the hex string
     * @return byte[]
     */
    public static byte[] hexStringToBytes(String hexString) {
        if (hexString == null || hexString.equals("")) {
            return null;
        }
        hexString = hexString.toUpperCase();
        int length = hexString.length() / 2;
        char[] hexChars = hexString.toCharArray();
        byte[] d = new byte[length];
        for (int i = 0; i < length; i++) {
            int pos = i * 2;
            d[i] = (byte) (charToByte(hexChars[pos]) << 4 | charToByte(hexChars[pos + 1]));
        }
        return d;
    }

    /**
     * 合并字节数组操作
     *
     * @param values
     * @return
     */
    public static byte[] byteMergerAll(byte[]... values) {
        int length = 0;
        for (int i = 0; i < values.length; i++) {
            length += values[i].length;
        }
        byte[] allBytes = new byte[length];
        int countLength = 0;
        for (int i = 0; i < values.length; i++) {
            byte[] b = values[i];
            System.arraycopy(b, 0, allBytes, countLength, b.length);
            countLength += b.length;
        }
        return allBytes;
    }

    /**
     * 计算响应帧的字节长度
     *
     * @param data
     * @return
     */
    public static int getActualLength(byte[] data) {
        int len = 0;
        for (int i = data.length - 1; i > 0; i--) {
            if (data[i] != '\0') {
                len = i + 1;
                break;
            }
        }
        return len;
    }

    /**
     * 验证响应帧CRC
     *
     * @param data
     * @return
     */
    public static boolean isCrcPassed(byte[] data) {
        int len = getActualLength(data); // 获取响应帧长度
        byte[] orgiCrc = Arrays.copyOfRange(data, len - 2, len);
        String orgiCrcStr = AGVUtil.bytesToHexString(orgiCrc);
        System.out.println("响应帧CRC：" + orgiCrcStr);
        byte[] forCrc = Arrays.copyOfRange(data, 0, len - 2);
        String crcStr = CRC16.getCrc(forCrc);
        System.out.println("验证CRC：" + crcStr);
        return crcStr.equalsIgnoreCase(orgiCrcStr);
    }

    /**
     * 取得AGV查询状态
     *
     * @param data
     * @return
     */
    public static byte[] getQueryStatus(byte[] data) {
        int len = getActualLength(data); // 获取响应帧长度
        byte[] status = Arrays.copyOfRange(data, 3, len - 2);
        return status;
    }

    /**
     * 生成带CRC16的指令
     *
     * @param order
     * @return
     */
    public static byte[] generateBytesWithCRC(byte[] order) {
        return byteMergerAll(order, AGVUtil.hexStringToBytes(CRC16.getCrc2(order)));
    }

    /**
     * 将byte[]转为各种进制的字符串
     *
     * @param bytes byte[]
     * @param radix 基数可以转换进制的范围(2-36)，从Character.MIN_RADIX到Character.MAX_RADIX，超出范围后变为10进制
     * @return 转换后的字符串
     */
    public static String binary(byte[] bytes, int radix) {
        return new BigInteger(1, bytes).toString(radix);// 这里的1代表正数
    }


    public static void main(String[] args) {
       /* byte[] b = new byte[]{0x01, 0x03, 0x01, 0x00, 0x00, 0x02, (byte) 0xC5, (byte) 0xF7};
        for (int i = 0; i < b.length; i++) {
            String hex = Integer.toHexString(b[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            System.out.print(hex.toUpperCase());
        }*/

//        byte[] b = new byte[]{0x01, 0x03, 0x04, 0x00, 0x00, 0x00, 0x00, (byte) 0xFA, 0x33};
//        int len = getActualLength(b);
//        System.out.println("响应帧长度：" + len);
//
//        if (isCrcPassed(b)) {
//            System.out.println("验证通过");
//        } else {
//            System.out.printf("验证失败");
//        }

       /* byte[] tx = new byte[]{0x01, 0x10, 0x02, 0x01, 0x00, 0x01, 0x02, 0x00, 0x02, 0x05, (byte) 0x80, 0x00, 0x00};
        int index = 0;
        for (int i = tx.length - 1; i > 0; i--) {
            if (tx[i] != '\0') {
                System.out.printf("i=" + i);
                break;
            }
        }*/
        System.out.println(binary(new byte[]{0x03, (byte) 0xE8}, 10));
    }

}
