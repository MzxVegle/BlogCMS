package com.Vegle.Services.Upload;

import com.Vegle.Bean.FileResult;
import com.Vegle.Utils.FileResultUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
@Service
public class FileServiceImpl implements FileService {
    @Autowired
    FileResultUtil fileResultUtil;


    public FileResult upLoadFile(MultipartFile myFileName, String path) {
        String realPath = "";
        String realName = "";
        if(myFileName != null){
            //获取到file的全名
            String fileName = myFileName.getOriginalFilename();
            //获取到file的后缀名
            String fileNameExtension = fileName.substring(fileName.indexOf("."),fileName.length());
            //生成存储的真实名称
            realName = UUID.randomUUID().toString()+fileNameExtension;


            File uploadFile = new File(path,realName);
            realPath = path.substring(path.indexOf("uploadFiles"),path.length());

            try {
                myFileName.transferTo(uploadFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        String[] str = {realPath+realName};
        return fileResultUtil.success(str);
    }

    public void deleteFile(String fileUrl) {
        File file = new File(fileUrl);
        if(file.exists()){
            System.out.println("文件存在");
            if(file.delete()){
                System.out.println("文件名:"+file.getName()+",删除成功");
            }
        }else{
            System.out.println("文件不存在");
        }

    }
}
