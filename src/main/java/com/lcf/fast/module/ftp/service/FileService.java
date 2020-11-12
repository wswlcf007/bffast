package com.lcf.fast.module.ftp.service;

import cn.hutool.core.util.StrUtil;
import com.lcf.fast.common.constant.RCodeEnum;
import com.lcf.fast.common.exception.BFRuntimeException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * 上传文件到FTP
 * 依赖：commons-net
 *
 * @author lcf
 * @date 2020/4/7 15:45
 */
@Service
@Slf4j
public class FileService {
    //ftp服务器ip地址
    @Value("${file.ftp.url}")
    private String ftpURL;
    //端口号
    @Value("${file.ftp.port}")
    private int ftpPort;
    //用户名
    @Value("${file.ftp.username}")
    private String ftpUsername;
    //密码
    @Value("${file.ftp.password}")
    private String ftpPassword;
    //被动模式
    @Value("${file.ftp.passiveMode}")
    private Boolean passiveMode;
    //根目录
    @Value("${file.rootPath}")
    private String rootPath;
    @Value("${file.httpPath}")
    private String httpPath;
    @Value("${file.method}")
    private String method;

    /**
     * 文件上传
     *
     * @param file
     * @return
     */
    public String uploadFile(MultipartFile file) {
        String finalName = getFinalName(file);
        if ("0".equalsIgnoreCase(method)) {
            // ftp 上传
            return uploadFtpFile(file, finalName);
        }
        return uploadLocalFile(file, finalName);
    }

    private String getFinalName(MultipartFile file) {
        String originFileName = file.getOriginalFilename();
        if (StrUtil.isBlank(originFileName)) {
            throw new BFRuntimeException(RCodeEnum.Error.getCode(), "上传失败，上传文件名为空");
        }
        //1、当前上传文件的文件后缀
        String suffix = originFileName.contains(".") ? originFileName.substring(originFileName.lastIndexOf(".")
        ) : "";
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        return uuid + suffix;
    }

    /**
     * ftp 文件上传
     *
     * @param multipartFile
     * @param finalName
     * @return
     * @throws Exception
     */
    public String uploadFtpFile(MultipartFile multipartFile, String finalName) {
        if (multipartFile == null) {
            log.error("文件上传失败，没有获取到上传的文件");
            throw new BFRuntimeException("文件上传失败，没有获取到上传的文件");
        }
        InputStream inputStream = null;
        FTPClient ftp = new FTPClient();
        try {
            //3、定义上传路径
            DateFormat dataFormat = new SimpleDateFormat("yyyyMMdd");
            String ftpPath = rootPath + "/" + dataFormat.format(new Date()) + "/";

            ftp.setControlEncoding("UTF-8");
            ftp.setRemoteVerificationEnabled(false);
            ftp.setBufferSize(10000);
            inputStream = multipartFile.getInputStream();
            int reply;
            ftp.connect(ftpURL, ftpPort);// 连接FTP服务器
            ftp.login(ftpUsername, ftpPassword);// 登录
            reply = ftp.getReplyCode();
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftp.disconnect();
                log.error("与FTP服务器建立连接失败，请检查用户名和密码是否正确");
                throw new BFRuntimeException("文件上传失败");
            }
            ftp.setFileType(FTPClient.BINARY_FILE_TYPE);
            //创建目录结构
            if (ftpPath != null && !"".equals(ftpPath.trim())) {
                String[] pathes = ftpPath.split("/");
                for (String onepath : pathes) {
                    if (onepath == null || "".equals(onepath.trim())) {
                        continue;
                    }
                    onepath = new String(onepath.getBytes(StandardCharsets.UTF_8), StandardCharsets.UTF_8);
                    if (!ftp.changeWorkingDirectory(onepath)) {
                        ftp.makeDirectory(onepath);//创建FTP服务器目录
                        ftp.changeWorkingDirectory(onepath);//改变FTP服务器目录
                    }
                }

            }
            //设置PassiveMode传输
            if (passiveMode) {
                ftp.enterLocalPassiveMode();
            }
            if (ftp.storeFile(finalName, inputStream)) {
                log.info("文件[{}]上传成功", ftpPath + "/" + finalName);
            }
            ftp.logout();
            return httpPath + ftpPath + finalName;
        } catch (Exception e) {
            log.error("上传失败，异常原因[{}]" + e.getMessage());
            throw new BFRuntimeException("文件上传失败");
        } finally {
            if (ftp.isConnected()) {
                try {
                    ftp.disconnect();
                } catch (IOException e) {
                    log.error("disconnect fail ------->>>{}", e.getCause());
                }
            }
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    log.error("inputStream close fail -------- {}", e.getCause());
                }
            }

        }
    }

    /**
     * 本地 文件上传
     *
     * @param multipartFile
     * @return
     */
    public String uploadLocalFile(MultipartFile multipartFile, String finalName) {
        if (multipartFile == null) {
            log.error("文件上传失败，没有获取到上传的文件");
            throw new BFRuntimeException("文件上传失败，没有获取到上传的文件");
        }
        try {
            //MultipartFile multipartFile = (MultipartFile)file;
            String originFileName = multipartFile.getOriginalFilename();
            //当前上传文件的文件后缀
            String suffix = originFileName.indexOf(".") != -1 ? originFileName.substring(originFileName.lastIndexOf(".")
            ) : null;

            //重命名上传后的文件名
//            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
            String saveFileName = finalName + suffix;

            //定义上传路径
            DateFormat dataFormat = new SimpleDateFormat("yyyyMMdd");
            String tmppath = rootPath + "/" + dataFormat.format(new Date()) + "/";

            //文件最终保存全路径
            String fileNamePath = tmppath + saveFileName;

            //创建File对象
            File localFile = new File(System.getProperty("user.dir") + fileNamePath);

            //检测是否存在目录，不存在则创建
            if (!localFile.getParentFile().exists()) {
                localFile.getParentFile().mkdirs();
            }
            //执行上传文件
            multipartFile.transferTo(localFile);
            return httpPath + tmppath + saveFileName;
        } catch (Exception e) {
            throw new BFRuntimeException("文件上传失败");
        }
    }

}
