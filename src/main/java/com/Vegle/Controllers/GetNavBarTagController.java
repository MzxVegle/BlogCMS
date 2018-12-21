package com.Vegle.Controllers;

import com.Vegle.Services.NavBar.NavBarService;
import com.Vegle.Utils.AjaxPrintf;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
public class GetNavBarTagController {
    @Autowired
    NavBarService navBarService;
    @Autowired
    AjaxPrintf ajax;
    @RequestMapping("/loadCmsNavBar")
    public void getCmsNavBarTag(HttpServletResponse response){
        JSONArray navTag = JSONArray.fromObject(navBarService.getCmsNavBarTag());
        ajax.printf(navTag);
    }
    @RequestMapping("/getBreadcrumbNavBar")
    public void getBreadcrumbNavBar(String name){
        System.out.println(name);
        ajax.printf(navBarService.getChildByName(name));
    }
}
