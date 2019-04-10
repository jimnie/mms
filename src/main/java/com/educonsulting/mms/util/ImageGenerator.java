package com.educonsulting.mms.util;

import org.apache.commons.lang.StringUtils;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import java.io.*;
import java.util.UUID;

public class ImageGenerator {

    // 对字节数组字符串进行Base64解码并生成图片
    public static boolean generateImage(String imgStr, String imgFilePath) {
        if (StringUtils.isEmpty(imgStr)) //图像数据为空
            return false;
        BASE64Decoder decoder = new BASE64Decoder();
        try {
            //Base64解码
            byte[] b = decoder.decodeBuffer(imgStr);
            for (int i = 0; i < b.length; ++i) {
                if (b[i] < 0) {//调整异常数据
                    b[i] += 256;
                }
            }
            //生成jpeg图片
            OutputStream out = new FileOutputStream(imgFilePath);
            out.write(b);
            out.flush();
            out.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public static String getImageStr(String imgFile) {
        InputStream inputStream = null;
        byte[] data = null;
        try {
            inputStream = new FileInputStream(imgFile);
            data = new byte[inputStream.available()];
            inputStream.read(data);
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 加密
        BASE64Encoder encoder = new BASE64Encoder();
        return encoder.encode(data);
    }

    public static void main(String[] args) {
        String origImg = "E:\\sign.jpg";
        String imgStr = getImageStr(origImg);
        String imgFilePath = "E:\\" + UUID.randomUUID().toString() + ".jpg";
        boolean succ = generateImage(imgStr, imgFilePath);
        System.out.printf(Boolean.toString(succ));
    }
}
