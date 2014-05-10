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
		@SuppressWarnings("unchecked")
		List<TbCategory> topCategories = (List<TbCategory>) application.get("topCategoryList");
		List<List<TbBooks>> booksCategoryList = new ArrayList<List<TbBooks>>(0);
		List<TbBooks> zongbangList = new ArrayList<TbBooks>(0);
		
		
		for (TbCategory category : topCategories) {
			if(category.getCategoryName().equals("文艺")){
				List<TbBooks> booksList = BooksService.getBooksListByCategoryId(category.getCategoryId());
				List<TbBooks> wenyiBooksList = BooksService.sortByBooksSalesDesc(booksList);
				request.setAttribute("wenyiBooksList", wenyiBooksList);
			}
			if(category.getCategoryName().equals("经管")){
				List<TbBooks> booksList = BooksService.getBooksListByCategoryId(category.getCategoryId());
				List<TbBooks> jinguanBooksList = BooksService.sortByBooksSalesDesc(booksList);
				request.setAttribute("jinguanBooksList", jinguanBooksList);
			}
			List<TbBooks> booksList = BooksService.getBooksListByCategoryId(category.getCategoryId());
			zongbangList.addAll(booksList);
			int toIndex = (4 > booksList.size()) ? booksList.size() : 4;
			booksList = booksList.subList(0, toIndex);
			for (TbBooks books : booksList) {
				Hibernate.initialize(books.getTbCategory());
//				Hibernate.initialize(books.getTbBooksdetails());
			}
			booksCategoryList.add(booksList);
			
		}
		List<TbBooks> zongbangBooksList1 = BooksService.sortByBooksSalesDesc(zongbangList);
		request.setAttribute("zongbangBooksList1", zongbangBooksList1);
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
