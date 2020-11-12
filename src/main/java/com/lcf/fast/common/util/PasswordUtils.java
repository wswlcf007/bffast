package com.lcf.fast.common.util;

import cn.hutool.core.codec.Base64;
import cn.hutool.crypto.Mode;
import cn.hutool.crypto.Padding;
import cn.hutool.crypto.symmetric.AES;

import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;

/**
 * 解密
 *
 * @author lcf
 * @date 2020-07-15 10:56
 */
public class PasswordUtils {
    public static String decryptAES(String password, String key) {
        AES aes = new AES(Mode.CBC, Padding.NoPadding,
                new SecretKeySpec(key.getBytes(), "AES"),
                new IvParameterSpec(key.getBytes()));
        byte[] result = aes.decrypt(Base64.decode(password.getBytes(StandardCharsets.UTF_8)));
        return new String(result, StandardCharsets.UTF_8);
    }
}
