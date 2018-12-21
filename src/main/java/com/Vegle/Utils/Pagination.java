package com.Vegle.Utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("pagination")
public class Pagination {

    Logger logger = LogManager.getLogger(this);

    int currentPageNo = 1;/*      当前页面*/

    int totalPage;/*              总页面*/

    int totalRecord;/*          总记录数*/


    int pageSize ;/*            每页记录数*/

    int fromindex ;

    int toindex ;
    List list;

    public Pagination(){

    }
    public  Pagination(int No,int pageSize,List obj){
        System.out.println(pageSize);
        this.currentPageNo = No;
        this.pageSize = pageSize;
        this.list = obj;


    }

    public void setCurrentPageNo(int currentPageNo) {
        this.currentPageNo = currentPageNo;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public void setObj(List obj) {
        this.list = obj;
    }

    public List disapart(List obj,int pageSize,int currentPageNo){
        setObj(obj);
        setPageSize(pageSize);
        setCurrentPageNo(currentPageNo);



        totalRecord = obj.size();
        totalPage = totalRecord/pageSize;

        if((totalRecord % pageSize) > 0){
            totalPage += 1;
        }

        fromindex = (currentPageNo-1)*pageSize;

        toindex = (currentPageNo)*pageSize;

        if(toindex>totalRecord){
            toindex = totalRecord;
        }

        List disapartList = obj;

        logger.info("总页面："+totalPage+"页,当前页面："+currentPageNo+"页,每页显示数据："+(toindex-fromindex)+"条,数据总量:"+totalRecord+"条");

        return disapartList.subList(fromindex,toindex);
    }
    public int getCurrentPageNo() {
        return currentPageNo;
    }

    public int getTotalPage() {
        return totalPage;
    }

}
