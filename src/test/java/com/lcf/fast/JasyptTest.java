package com.lcf.fast;

import com.lcf.fast.common.constant.CommonEnum;
import org.jasypt.util.text.BasicTextEncryptor;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Jasypt测试
 *
 * @author ：lcf
 * @date ：2019/11/18 11:17
 */
@SpringBootTest
public class JasyptTest {
    @Test
    public void encrypt() {
        BasicTextEncryptor textEncryptor = new BasicTextEncryptor();
        textEncryptor.setPassword(CommonEnum.Jasypt_Encryptor_Password.getValue());
        String pwd = textEncryptor.encrypt("Zw123456!");
//        String pwd = textEncryptor.encrypt("123456");
        System.out.printf("pwd为：ENC(%s)", pwd);
    }

    @Test
    public void decrypt() {
        BasicTextEncryptor textEncryptor = new BasicTextEncryptor();
        textEncryptor.setPassword(CommonEnum.Jasypt_Encryptor_Password.getValue());
        String pwd = textEncryptor.decrypt("qBFFjy5nFz0ELbXDXIjw2f+sgfd4j0dz");
        System.out.printf("原密码为：%s", pwd);
    }
}
