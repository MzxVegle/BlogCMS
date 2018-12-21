package com.Vegle.Dao;

import com.Vegle.Bean.CmsNavBar;

import java.util.List;

public interface NavBarDao {
    List<CmsNavBar> getCmsNavBarTag();
    List<CmsNavBar> getCmsNavBarChildTag(int id);
    CmsNavBar getChildByFatherId(int id);
    CmsNavBar getTagById(int id);
    CmsNavBar getTagByName(String name);
}
