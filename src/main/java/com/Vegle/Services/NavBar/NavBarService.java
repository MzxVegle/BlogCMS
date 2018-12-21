package com.Vegle.Services.NavBar;

import com.Vegle.Bean.CmsNavBar;
import net.sf.json.JSONArray;

import java.util.List;

public interface NavBarService {
     List<CmsNavBar> getCmsNavBarTag();
     JSONArray getChildByName(String name);
}
