package com.Vegle.Services.NavBar;

import com.Vegle.Bean.CmsNavBar;
import com.Vegle.Dao.NavBarDao;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class NavBarServiceImpl implements NavBarService{
    private JSONArray jsonArray;
    private CmsNavBar tag;
    @Autowired
    NavBarDao navBarDao;
    public List<CmsNavBar> getCmsNavBarTag() {

        return navBarDao.getCmsNavBarTag();
    }

    public JSONArray getChildByName(String name) {
        // 1、根据id去查找到当前id标签并获取父标签id
        tag = navBarDao.getTagByName(name);
        jsonArray = new JSONArray();
        while (true){
            // 2、若父标签id不为0，则说明还存在父标签
            if (tag.getFatherId() != 0) {
                // 将当前标签保存到tag中
                jsonArray.add(tag);
                // 将当前的FatherId作为id继续获取上一级标签（相当于递归）
                tag = navBarDao.getTagById(tag.getFatherId());
            }else {
                break;
            }

        }
        // 将最顶层的标签压入jsonArray中，相当于一个队列（先进先出）
        jsonArray.add(tag);
        return jsonArray;
    }

}
