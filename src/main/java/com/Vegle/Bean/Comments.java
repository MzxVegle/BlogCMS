package com.Vegle.Bean;

import java.util.Date;
import java.util.List;

/**
 *
 * @author:Vegle
 */
public class Comments {

    private int id;
    private Date createTime;
    private String content;

    private User commentUser;//commentUser表示评论用户
    private User replyUser;//replyUser表示回复给哪个用户的评论

    private List<Comments> comments;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public User getCommentUser() {
        return commentUser;
    }

    public void setCommentUser(User commentUser) {
        this.commentUser = commentUser;
    }

    public User getReplyUser() {
        return replyUser;
    }

    public void setReplyUser(User replyUser) {
        this.replyUser = replyUser;
    }

    public List<Comments> getComments() {
        return comments;
    }

    public void setComments(List<Comments> comments) {
        this.comments = comments;
    }

    @Override
    public String toString() {
        return "Comments{" +
                "id=" + id +
                ", createTime=" + createTime +
                ", content='" + content + '\'' +
                ", commentUser=" + commentUser +
                ", replyUser=" + replyUser +
                ", comments=" + comments +
                '}';
    }
}
