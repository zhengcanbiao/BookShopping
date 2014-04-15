package com.bookshopping.action.favorite;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbFavorite;
import com.bookshopping.service.FavoriteService;
import com.opensymphony.xwork2.ActionSupport;

public class PrepareFavoriteAction extends ActionSupport implements ServletRequestAware{

	private HttpServletRequest request;
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
		
	}

	@Override
	public String execute() throws Exception {
    	List<TbFavorite> favoriteList = FavoriteService.getFavoriteList();
    	List<String> picUrls = new ArrayList<String>(0);
    	for (TbFavorite favorite : favoriteList) {
    		Hibernate.initialize(favorite.getFavoriteId());
    		Hibernate.initialize(favorite.getTbBooks());
    		Hibernate.initialize(favorite.getTbCustomer());
    		picUrls.add(favorite.getTbBooks().getPicUrl());
    	}
    	System.out.println(request);
    	request.setAttribute("favoriteList", favoriteList);
    	request.setAttribute("picUrls", picUrls);
    	return SUCCESS;
		
	}

}
