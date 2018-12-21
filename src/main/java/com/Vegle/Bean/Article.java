package com.Vegle.Bean;

import java.util.Date;
import java.util.List;

/**
 * @author:Vegle
 */
public class Article {
    private int articleId;
    private String title;
    private String txt;
    private ArticleType articleType;
    private Date addTime;
    private Date updateTime;

    private List<Comments> comments;    //评论列表
    private int commentCount;   //评论条数

    @Override
    public String toString() {
        return "Article{" +
                "articleId=" + articleId +
                ", title='" + title + '\'' +
                ", txt='" + txt + '\'' +
                ", articleType=" + articleType +
                ", addTime=" + addTime +
                ", updateTime=" + updateTime +
                ", comments=" + comments +
                ", commentCount=" + commentCount +
                '}';
    }

    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    public List<Comments> getComments() {
        return comments;
    }

    public void setComments(List<Comments> comments) {
        this.comments = comments;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public int getArticleId() {
        return articleId;
    }

    public void setArticleId(int articleId) {
        this.articleId = articleId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTxt() {
        return txt;
    }

    public void setTxt(String txt) {
        this.txt = txt;
    }

    public ArticleType getArticleType() {
        return articleType;
    }

    public void setArticleType(ArticleType articleType) {
        this.articleType = articleType;
    }

}
