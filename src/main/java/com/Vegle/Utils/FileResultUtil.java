package com.Vegle.Utils;

import com.Vegle.Bean.FileResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class FileResultUtil {
    @Autowired
    FileResult fileResult;
    public FileResult success(String[] obj){
        fileResult.setErrno(0);
        fileResult.setData(obj);
        return fileResult;
    }
}
