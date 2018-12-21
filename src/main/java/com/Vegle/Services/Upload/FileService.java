package com.Vegle.Services.Upload;

import com.Vegle.Bean.FileResult;
import org.springframework.web.multipart.MultipartFile;

public interface FileService {
    //上传文件
    FileResult upLoadFile(MultipartFile myFileName, String path);
    //删除文件
    void deleteFile(String fileUrl);
}
