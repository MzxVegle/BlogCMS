package com.Vegle.Bean;

import java.util.List;

public class CmsNavBar {
    private int id;
    private String nodeName;
    private String url;
    private List<CmsNavBar> cmsNavBarList;
    private int fatherId;

    public int getFatherId() {
        return fatherId;
    }

    public void setFatherId(int fatherId) {
        this.fatherId = fatherId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNodeName() {
        return nodeName;
    }

    public void setNodeName(String nodeName) {
        this.nodeName = nodeName;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public List<CmsNavBar> getCmsNavBarList() {
        return cmsNavBarList;
    }

    public void setCmsNavBarList(List<CmsNavBar> cmsNavBarList) {
        this.cmsNavBarList = cmsNavBarList;
    }

    @Override
    public String toString() {
        return "CmsNavBar{" +
                "id=" + id +
                ", nodeName='" + nodeName + '\'' +
                ", url='" + url + '\'' +
                ", cmsNavBarList=" + cmsNavBarList +
                ", fatherId=" + fatherId +
                '}';
    }
}
