package com.Vegle.Services.Article;

import com.Vegle.Bean.Article;
import com.Vegle.Bean.ArticleType;
import com.Vegle.Bean.Comments;
import net.sf.json.JSONObject;

import java.util.List;

public interface ArticleService {
    List<ArticleType> getArticleType();
    boolean insertArticleType(String typeName,String fatherName);
    boolean deleteType(String name);
    boolean insertArticle(JSONObject article);
    boolean updateArticle(JSONObject article);
    boolean deleteArticle(int aid);
    List<Article> getArticles(String title,String type,String col,String sort);
    List<Comments> getComments(int artcileId);
    boolean deleteCommentById(int id);
    boolean insertComment(JSONObject comment);
}
