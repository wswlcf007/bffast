package com.lcf.fast.common.kaptcha;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;


/**
 * 生成验证码配置
 *
 * @author lcf
 * @date 2019/11/8 15:10:12
 */
@Configuration
public class KaptchaConfig {

    @Bean
    public DefaultKaptcha producer() {
        DefaultKaptcha defaultKaptcha = new DefaultKaptcha();
        Properties properties = new Properties();
        properties.setProperty("kaptcha.border", "no");
        properties.setProperty("kaptcha.border.color", "34,114,200");
        properties.setProperty("kaptcha.image.width", "125");
        properties.setProperty("kaptcha.image.height", "45");
        properties.setProperty("kaptcha.textproducer.char.string", "ABCDEFG23456789");
        properties.setProperty("kaptcha.textproducer.char.length", "5");
        properties.setProperty("kaptcha.textproducer.font.names", "Arial,Arial Narrow,Serif,Helvetica,Tahoma,Times New Roman,Verdana");
        properties.setProperty("kaptcha.textproducer.font.size", "38");

        properties.setProperty("kaptcha.background.clear.from", "white");
        properties.setProperty("kaptcha.background.clear.to", "white");

        properties.setProperty("kaptcha.word.impl", KaptchaWordRenderer.class.getName());
        properties.setProperty("kaptcha.noise.impl", KaptchaNoise.class.getName());

        Config config = new Config(properties);
        defaultKaptcha.setConfig(config);
        return defaultKaptcha;
    }
}
