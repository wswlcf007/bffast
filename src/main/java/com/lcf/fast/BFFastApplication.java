package com.lcf.fast;

import com.lcf.fast.common.constant.CommonEnum;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BFFastApplication {

    public static void main(String[] args) {
        //配置加解密跟秘钥，与配置文件的密文分开放
        System.setProperty("jasypt.encryptor.password", CommonEnum.Jasypt_Encryptor_Password.getValue());
        SpringApplication.run(BFFastApplication.class, args);
    }

}
