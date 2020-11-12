package com.lcf.fast.module.netty.util;

import cn.hutool.core.util.StrUtil;

import java.util.Arrays;

/**
 * ModBus协议 工具类
 *
 * @author lcf
 * @date 2020/4/9 14:26
 */
public class ModBusUtils {

    /**
     * 校验数据有效性
     *
     * @param recv
     * @return
     */
    public static Boolean check(byte[] recv) {
        if (recv == null || recv.length == 0) {
            return false;
        }
        // 获取接收数据的总字节数
        int totalLen = recv.length;
        if (totalLen < 3) {
            //没有长度位
            return false;
        }
        if (recv[1] == 6) {
            //06码的设备反馈，不需处理，原路返回就可以
            return true;
        }
        if (recv[1] == 8) {
            //08码的设备反馈，不需处理，原路返回就可以
            return true;
        }

        int dataLen = recv[2] & 0XFF;//有效字节数
        if (dataLen == 0) {
            return false;
        }
        //若接收到数据长度小于实际有效的数据长度，则返回false
        if (totalLen != (dataLen + 5)) {
            // 5字节 = 地址码1 + 功能码1 + 有效字节数1 + CRC校验码2
            return false;
        }
        if (totalLen > dataLen + 5) {
            //粘包处理
            return false;
        }

        /*计算CRC校验数据的字节数  计算公式：有效数据字节数+地址吗（1字节）+功能吗（1字节）+有效字节数（1字节）*/
        int crcDataLen = dataLen + 3;
        /*获取数据中的CRC值*/
        String stringCRC = Integer.toHexString((recv[crcDataLen] & 0xff) << 8 | (recv[crcDataLen + 1] & 0xff));
        /*获取CRC校验数据*/
        byte[] crcData = Arrays.copyOf(recv, crcDataLen);
        /*计算CRC校验值*/
        String checkCRC = getCRCStringBytes(crcData);
        /*比较, 若不相同，退出*/
        return StrUtil.equals(stringCRC, checkCRC);
    }

    /**
     * 计算CRC16 / Modbus校验码
     * 低位在前,高位在后
     *
     * @param bytes 字节数组
     * @return
     */
    public static int[] getCRC16Bytes(byte[] bytes) {
        int CRC = 0x0000ffff;
        int POLYNOMIAL = 0x0000a001;

        int i, j;
        for (i = 0; i < bytes.length; i++) {
            CRC ^= ((int) bytes[i] & 0x000000ff); //高位补码
            for (j = 0; j < 8; j++) {
                if ((CRC & 0x00000001) != 0) {
                    CRC >>= 1;
                    CRC ^= POLYNOMIAL;
                } else {
                    CRC >>= 1;
                }
            }
        }
        String s = Integer.toHexString(CRC);
        int h = CRC >> 8;//高8位
        int low = CRC % 256;//低8位
        int[] crc = {low, h};
        return crc;
    }

    /**
     * 计算CRC16 / Modbus校验码
     * 低位在前,高位在后
     *
     * @param bytes 字节数组
     * @return
     */
    public static String getCRCStringBytes(byte[] bytes) {
        int CRC = 0x0000ffff;
        int POLYNOMIAL = 0x0000a001;

        int i, j;
        for (i = 0; i < bytes.length; i++) {
            CRC ^= ((int) bytes[i] & 0x000000ff); //高位补码
            for (j = 0; j < 8; j++) {
                if ((CRC & 0x00000001) != 0) {
                    CRC >>= 1;
                    CRC ^= POLYNOMIAL;
                } else {
                    CRC >>= 1;
                }
            }
        }
        CRC = ((CRC & 0x0000FF00) >> 8) | ((CRC & 0x000000FF) << 8);
        return Integer.toHexString(CRC);
    }

    /**
     * 字节转十六进制
     *
     * @param b 需要进行转换的byte字节
     * @return 转换后的Hex字符串
     */
    public static String byteToHexString(byte b) {
        String hex = Integer.toHexString(b & 0xFF);
        if (hex.length() < 2) {
            hex = "0" + hex;
        }
        return hex;
    }

    /**
     * 字节数组转16进制
     *
     * @param bytes 需要转换的byte数组
     * @return 转换后的Hex字符串
     */
    public static String bytesToHexString(byte[] bytes) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(bytes[i] & 0xFF);
            if (hex.length() < 2) {
                sb.append(0);
            }
            sb.append(hex);
        }
        return sb.toString();
    }

    /**
     * Hex字符串转byte
     *
     * @param inHex 待转换的Hex字符串
     * @return 转换后的byte
     */
    public static byte hexStringToByte(String inHex) {
        return (byte) Integer.parseInt(inHex, 16);
    }

    /**
     * hex字符串转byte数组
     *
     * @param inHex 待转换的Hex字符串
     * @return 转换后的byte数组结果
     */
    public static byte[] hexStringToByteArray(String inHex) {
        int hexlen = inHex.length();
        byte[] result;
        if (hexlen % 2 == 1) {
            //奇数
            hexlen++;
            result = new byte[(hexlen / 2)];
            inHex = "0" + inHex;
        } else {
            //偶数
            result = new byte[(hexlen / 2)];
        }
        int j = 0;
        for (int i = 0; i < hexlen; i += 2) {
            result[j] = hexStringToByte(inHex.substring(i, i + 2));
            j++;
        }
        return result;
    }

    /**
     * byte转int类型
     * 如果byte是负数，则转出的int型是正数
     *
     * @param b
     * @return
     */
    public static int byteToInt(byte b) {
        return b & 0xff;
    }

    /**
     * int 类型转换为byte 类型
     * 截取int类型的最后8位,与 0xff
     *
     * @param x
     * @return
     */
    public static byte intToByte(int x) {
        return (byte) (x & 0xff);
    }

    /**
     * 把整数转换为字节数组：整数是32位，8位一个字节，依次读取8位，转化为字节数组
     * 整数与0xff,取得最后8位,生成整数,再强转为第3个byte
     * 整数右移8位,与0xff,取得倒数第二组8位,生成整数,再强转为第2个byte
     * 整数右移16位,与0xff,取得倒数第3组8位,生成整数,再强转为第1个byte
     * 整数右移24位,与0xff,取得倒数第4组8位,生成整数,再强转为第0个byte
     *
     * @param x
     * @return
     */
    public static byte[] intToBytes(int x) {
        byte[] arr = new byte[4];
        arr[3] = (byte) (x & 0xff);
        arr[2] = (byte) (x >> 8 & 0xff);
        arr[1] = (byte) (x >> 16 & 0xff);
        arr[0] = (byte) (x >> 24 & 0xff);
        return arr;
    }

    /**
     * byte数组转换为整数
     * 第0个byte与上0xff,生成整数,在右移24位，取得一个整数
     * 第1个byte与上0xff,生成整数,在右移16位，取得一个整数
     * 第2个byte与上0xff,生成整数,在右移8位，取得一个整数
     * 第3个byte与上0xff,生成整数
     * 把四个整数做或操作,转换为已整数
     *
     * @param arr
     * @return
     */
    public static int bytesToInt(byte[] arr) {
        int x = ((arr[0] & 0xff) << 24) | ((arr[1] & 0xff) << 16) | ((arr[2] & 0xff) << 8) | (arr[3] & 0xff);
        return x;
    }

}
