package com.Vegle.Dao;

import com.Vegle.Bean.Article;
import com.Vegle.Bean.ArticleType;
import com.Vegle.Bean.Comments;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ArticleDao {
    /**
     * 获取所有文章类型（getArticleType）
     * @return
     *       返回值为一个ArticleType的列表（因为文章类型可能有多个）
     */
    List<ArticleType> getArticleType();

    /**
     * 通过名字获取指定的文章类型的Id（getArticleTypeIdByName）
     * @param name
     *        指定的文章类型的名字
     * @return
     *        返回一个int数据类型，该类型用于表示指定文章类型的Id
     */
    int getArticleTypeIdByName(@Param("name")String name);

    /**
     * 用于删除文章类型的函数（deleteType）
     * @param name
     *        指定删除文章类型的名称
     * @return
     *        返回一个boolean数据类型，删除成功返回true，否则返回false
     */
    boolean deleteType(@Param("name")String name);

    /**
     * 用于插入文章的函数（insertArticle）
     * @param title
     *        插入文章的标题
     * @param txt
     *        插入文章的内容（内容为）Base64，需要转成Utf-8才能正常显示
     * @param articleTypeId
     *        插入文章的类型Id
     * @param addTime
     *        插入文章的时间
     * @param updateTime
     *        文章的更新时间（新增的文章的时间和插入文章的时间相同）
     * @return
     *        返回值为True或False，插入成功则返回True，失败则返回False
     */
    boolean insertArticle(@Param("title") String title,
                          @Param("txt") String txt,
                          @Param("typeId") int articleTypeId,
                          @Param("addTime") String addTime,
                          @Param("updateTime") String updateTime);


    boolean deleteArticle(@Param("aid")int aid);
    /**
     * 用于文章更新的函数（updateArticle）
     * @param id
     *        匹配指定Id的文章
     * @param title
     *        更新指定文章的标题
     * @param txt
     *        更新指定文章的内容
     * @param typeId
     *        更新指定文章的文章类型Id
     * @param time
     *        更新文章修改的时间
     * @return
     *        返回值为一个布尔类型（boolean），若成功则返回true，失败则返回false
     */
    boolean updateArticle(@Param("id")int id,
                          @Param("title")String title,
                          @Param("txt")String txt,
                          @Param("typeId")int typeId,
                          @Param("time") String time);

    /**
     * 用于新增文章类型的函数（insertArticleType）
     * @param typeName
     *        指定文章类型的名称叫什么
     * @param fatherId
     *        指定他的上一级的文章类型的Id（若它自己就是最顶级，则这个参数一般为空）
     * @return
     *        返回一个布尔类型（boolean），若插入成功返回true，若失败返回false
     */
    boolean insertArticleType(@Param("typeName")String typeName,@Param("fatherId") int fatherId);

    /**
     * 用于获取文章的函数（getArticles）
     * @param title
     *        当title（文章标题）不为空的时候，根据title去查询文章，
     * @param type
     *        当type（文章类型）不为空的时候，根据type去查询文章，
     * @param col
     *        指定排序的列名称（必须在数据库中存在的表名称）
     * @param sort
     *        指定是降序排序还是升序排序（ASC or DESC）
     * @return
     */
    List<Article> getArticles(@Param("title")String title, @Param("type")String type, @Param("col")String col, @Param("sort") String sort);

    /**
     * 用于获取所有留言的函数（getComments）
     * @param articleId
     *        通过文章ID获取文章的留言
     * @return
     *        返回值为一个回复列表
     */
    List<Comments> getComments(@Param("articleId")int articleId);

    /**
     * 用于删除留言的函数（deleteCommentById）
     * @param id
     *        通过id定位留言并删除
     * @return
     *        成功返回true,失败返回false
     */
    boolean deleteCommentById(@Param("id")int id);

    /**
     * 用于新增文章的留言函数（insertComment）
     * @param uid
     *        留言人的id
     * @param rid
     *        回复回给留言人的Id，若留言人和回复人为同一个则这两个id应该相同
     * @param pid
     *        若该pid存在，说明这个评论是该pid评论的子评论
     * @param aid
     *        指定为哪篇文章的评论
     * @param createTime
     *        指定新增留言的时间
     * @param content
     *        评论的内容
     * @return
     *        返回值为一个布尔类型（boolean），若插入成功则返回true，否则返回false
     */
    boolean insertComment(@Param("uid")int uid,
                          @Param("rid")int rid,
                          @Param("pid")int pid,
                          @Param("aid")int aid,
                          @Param("createTime")String createTime,
                          @Param("content")String content);
}
