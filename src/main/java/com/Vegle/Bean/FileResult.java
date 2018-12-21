package com.Vegle.Bean;

import org.springframework.stereotype.Component;

import java.util.Arrays;
@Component
public class FileResult {
    /*错误码*/
    private int errno;
    /*图片地址数组*/
    private String[] data;

    public int getErrno() {
        return errno;
    }

    public void setErrno(int errno) {
        this.errno = errno;
    }

    public String[] getData() {
        return data;
    }

    public void setData(String[] data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "FileResult{" +
                "errno=" + errno +
                ", data=" + Arrays.toString(data) +
                '}';
    }
}
