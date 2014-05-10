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
	private int pageNow = 1;
	private int pageSize = 16;
	
	public int getPageNow() {
		return pageNow;
	}

	public void setPageNow(int pageNow) {
		this.pageNow = pageNow;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() throws Exception {
		List<TbBooks> booksList=BooksService.getBooksList();
		int pageCount = (booksList.size()-1) / pageSize + 1;
		int fromIndex = (pageNow-1) * pageSize;
		int toIndex = ((pageNow * pageSize) > booksList.size()) ? booksList.size() : (pageNow * pageSize);
		//booksList = booksList.subList(fromIndex, toIndex);
		request.setAttribute("pageNow", pageNow);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("BooksList", booksList);
		return SUCCESS;
	}
	
}
