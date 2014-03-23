package com.bookshopping.action.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ApplicationAware;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCategory;
import com.bookshopping.service.BooksService;
import com.opensymphony.xwork2.ActionSupport;

public class RedirectToHomeAction extends ActionSupport implements ServletRequestAware, ApplicationAware {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private HttpServletRequest request;
	private Map<String, Object> application;
	
	@Override
	public String execute() throws Exception {
		List<TbCategory> topCategories = (List<TbCategory>) application.get("topCategoryList");
		List<List<TbBooks>> booksCategoryList = new ArrayList<List<TbBooks>>(0);
		for (TbCategory category : topCategories) {
			List<TbBooks> booksList = BooksService.getBooksListByCategoryId(category.getCategoryId());
			int toIndex = (8 > booksList.size()) ? booksList.size() : 8;
			booksList = booksList.subList(0, toIndex);
			for (TbBooks books : booksList) {
				Hibernate.initialize(books.getTbCategory());
//				Hibernate.initialize(books.getTbBooksdetails());
			}
			booksCategoryList.add(booksList);
		}
		request.setAttribute("booksCategoryList", booksCategoryList);
	    return SUCCESS;
	}

	@Override
    public void setServletRequest(HttpServletRequest request) {
		this.request = request;
    }

	@Override
    public void setApplication(Map<String, Object> application) {
		this.application = application;
    }
}
