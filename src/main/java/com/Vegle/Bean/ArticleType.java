package com.Vegle.Bean;

import java.util.List;

public class ArticleType {
    private String articleTypeId;
    private String typeName;
    private List<ArticleType> articleTypes;

    @Override
    public String toString() {
        return "ArticleType{" +
                "articleTypeId='" + articleTypeId + '\'' +
                ", typeName='" + typeName + '\'' +
                ", articleTypes=" + articleTypes +
                '}';
    }

    public String getArticleTypeId() {
        return articleTypeId;
    }

    public void setArticleTypeId(String articleTypeId) {
        this.articleTypeId = articleTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public List<ArticleType> getArticleTypes() {
        return articleTypes;
    }

    public void setArticleTypes(List<ArticleType> articleTypes) {
        this.articleTypes = articleTypes;
    }
}
