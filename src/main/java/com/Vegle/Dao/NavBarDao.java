package com.Vegle.Dao;

import com.Vegle.Bean.CmsNavBar;

import java.util.List;

public interface NavBarDao {
    /**
     * 获取所有最顶层菜单栏的标签
     * @return
     * 返回一个菜单栏标签列表
     */
    List<CmsNavBar> getCmsNavBarTag();


    List<CmsNavBar> getCmsNavBarChildTag(int id);
    CmsNavBar getChildByFatherId(int id);

    /**
     * 通过id获取菜单栏标签
     * @param id
     * 指定id
     * @return
     * 返回一个菜单栏标签对象
     */
    CmsNavBar getTagById(int id);
    CmsNavBar getTagByName(String name);
}
