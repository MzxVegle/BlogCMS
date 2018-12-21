package com.Vegle.Controllers;

import com.Vegle.Services.Article.ArticleService;
import com.Vegle.Utils.AjaxPrintf;
import com.Vegle.Utils.Pagination;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ArticleController {
    @Autowired
    ArticleService articleService;
    @Autowired
    AjaxPrintf ajax;
    @Autowired
    Pagination pagination;
    @RequestMapping("/updateArticle")
    public void updateArticle(String article){
        System.out.println("执行了");
        ajax.printf(articleService.updateArticle(JSONObject.fromObject(article)));
    }

    @RequestMapping("/insertArticle")
    public void insertArticle( String article){
        ajax.printf(articleService.insertArticle(JSONObject.fromObject(article)));
    }
    @RequestMapping("/getArticleType")
    public void getArticleType(){
        JSONArray data = JSONArray.fromObject(articleService.getArticleType());
        ajax.printf(data);
    }
    @RequestMapping("deleteTypes")
    public void deleteTypes(String typeName){
        ajax.printf(articleService.deleteType(typeName));
    }

    @RequestMapping("/insertArticleType")
    public void insertArticleType(String typeName,String fatherName){
        ajax.printf(articleService.insertArticleType(typeName,fatherName));
    }
    @RequestMapping("/getArticles")
    public void getArticles(int pageNo,String title,String type,String col,String sort){
        System.out.println("pageNo:"+pageNo+",name:"+title+",type:"+type+",col:"+col+",sort:"+sort);
        JSONArray data = JSONArray.fromObject(pagination.disapart(articleService.getArticles(title,type,col,sort),3,pageNo));
        JSONObject jsonObject = new JSONObject();
        jsonObject.accumulate("totalPage",pagination.getTotalPage());
        jsonObject.accumulate("currentPage",pagination.getCurrentPageNo());
        data.add(jsonObject);
        ajax.printf(data);
    }
    @RequestMapping("/getCommentsById")
    public void getCommentsById(int articleId){
        ajax.printf(JSONArray.fromObject(articleService.getComments(articleId)));
    }
    @RequestMapping("/deleteCommentById")
    public void deleteCommentById(int commentId){
        ajax.printf(articleService.deleteCommentById(commentId));
    }
}
