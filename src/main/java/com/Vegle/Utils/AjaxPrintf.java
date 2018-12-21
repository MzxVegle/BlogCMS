package com.Vegle.Utils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
@Component
public class AjaxPrintf {
    private Object obj;
    private void printfMethod(){
        HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        try {
            PrintWriter pw = response.getWriter();
            pw.print(obj);
            pw.flush();
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void printf(String mess){
        this.obj = mess;
        printfMethod();
    }
    public void printf(JSONObject jsonObject){
        this.obj = jsonObject;
        printfMethod();
    }
    public void printf(JSONArray jsonArray){
        this.obj = jsonArray;
        printfMethod();
    }
    public void printf(Object obj){
        this.obj = obj;
        printfMethod();
    }
}
