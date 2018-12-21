package com.Vegle.Services.Article;

import com.Vegle.Bean.Article;
import com.Vegle.Bean.ArticleType;
import com.Vegle.Bean.Comments;
import com.Vegle.Dao.ArticleDao;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
@Service
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    ArticleDao articleDao;
    public List<ArticleType> getArticleType() {
        return articleDao.getArticleType();
    }

    public boolean insertArticleType(String typeName, String fatherName) {
        int fatherId=0;
        System.out.println(fatherId);
        if(fatherName !=null){
            fatherId = articleDao.getArticleTypeIdByName(fatherName);
            return articleDao.insertArticleType(typeName,fatherId);
        }
        return articleDao.insertArticleType(typeName,0);

    }

    public boolean deleteType(String name) {
        return articleDao.deleteType(name);
    }

    public boolean insertArticle(JSONObject article) {
        String title = article.getString("title");
        String txt = article.getString("txt");
        int typeId = articleDao.getArticleTypeIdByName(article.getString("type"));
        String addTime = article.getString("addTime");
        String updateTime = article.getString("updateTime");
        return articleDao.insertArticle(title,txt,typeId,addTime,updateTime);
    }

    public boolean updateArticle(JSONObject article) {
        int typeId = articleDao.getArticleTypeIdByName(article.getString("type"));
        int id = article.getInt("id");
        String txt = article.getString("txt");
        String time = article.getString("updateTime");
        String title = article.getString("title");

        return articleDao.updateArticle(id,title,txt,typeId,time);
    }

    public List<Article> getArticles(String title,String type,String col,String sort) {
        return articleDao.getArticles(title,type,col,sort);
    }

    public List<Comments> getComments(int artcileId) {
        return articleDao.getComments(artcileId);
    }

    public boolean deleteCommentById(int id) {
        return articleDao.deleteCommentById(id);
    }
}
