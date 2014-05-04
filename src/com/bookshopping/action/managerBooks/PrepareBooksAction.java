package com.bookshopping.action.managerBooks;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.service.BooksService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PrepareBooksAction extends ActionSupport implements ServletRequestAware {

	private HttpServletRequest request;
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() throws Exception {
		List<TbBooks> booksList=BooksService.getBooksList();
		request.setAttribute("BooksList", booksList);
		return SUCCESS;
	}
	
}
