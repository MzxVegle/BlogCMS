package com.Vegle.Dao;

import com.Vegle.Bean.Article;
import com.Vegle.Bean.ArticleType;
import com.Vegle.Bean.Comments;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ArticleDao {
    List<ArticleType> getArticleType();
    int getArticleTypeIdByName(@Param("name")String name);
    boolean deleteType(@Param("name")String name);
    Boolean insertArticle(@Param("title") String title,
                          @Param("txt") String txt,
                          @Param("typeId") int articleTypeId,
                          @Param("addTime") String addTime,
                          @Param("updateTime") String updateTime);

    boolean updateArticle(@Param("id")int id,@Param("title")String title,@Param("txt")String txt,@Param("typeId")int typeId,@Param("time") String time);
    boolean insertArticleType(@Param("typeName")String typeName,@Param("fatherId") int fatherId);
    List<Article> getArticles(@Param("title")String title, @Param("type")String type, @Param("col")String col, @Param("sort") String sort);

    /**
     *
     * @param articleId
     * 通过文章ID获取文章的留言
     * @return
     * 返回值为一个回复列表
     */
    List<Comments> getComments(@Param("articleId")int articleId);

    /**
     *
     * @param id
     * 通过id定位留言并删除
     * @return
     * 成功返回true,失败返回false
     */
    boolean deleteCommentById(@Param("id")int id);
}
