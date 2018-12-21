package com.Vegle.Controllers;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PageController {
    private Logger logger = LogManager.getLogger(PageController.class.getName());
    @RequestMapping("/index")
    String indexPage(){
        return "/loginPage";
    }
    @RequestMapping("/page")
    public String page(String page){

        logger.info("跳转页面:"+page);

        return page;
    }
}
