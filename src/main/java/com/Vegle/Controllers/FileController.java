package com.Vegle.Controllers;

import com.Vegle.Bean.FileResult;
import com.Vegle.Services.Upload.FileService;
import com.Vegle.Utils.AjaxPrintf;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

@Controller
public class FileController {
    @Autowired
    AjaxPrintf ajax;
    @Autowired
    FileService fileService;
    @RequestMapping("/uploadImg")
    public void uploadImgController(MultipartFile myFileName, HttpServletRequest request){
        String imgPath = request.getSession().getServletContext().getRealPath("/uploadFiles/img/");
        FileResult fileResult = fileService.upLoadFile(myFileName, imgPath);
        JSONObject result = JSONObject.fromObject(fileResult);
        ajax.printf(result.toString());
    }
    @RequestMapping("/deleteImg")
    public void deleteImgController(String url,HttpServletRequest request){
        String imgPath = request.getSession().getServletContext().getRealPath(url);
        fileService.deleteFile(imgPath);
    }
}
