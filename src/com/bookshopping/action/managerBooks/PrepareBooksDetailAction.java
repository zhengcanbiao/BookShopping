package com.bookshopping.action.managerBooks;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.exception.BooksNotFoundException;
import com.bookshopping.service.BooksService;
import com.bookshopping.service.CategoryService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PrepareBooksDetailAction extends ActionSupport implements ServletRequestAware {

	private String booksId;
	private HttpServletRequest request;
	
	
	public String getBooksId() {
		return booksId;
	}

	public void setBooksId(String booksId) {
		this.booksId = booksId;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}
	
	@Override
	public String execute() throws Exception {
		int Id;
		TbBooks books = null;
		try {
			Id = Integer.parseInt(booksId);
			books = BooksService.getBooksByBooksId(Id);
		} catch (NumberFormatException e) {
			addActionError("booksId： " + booksId + " 格式错误");
			return INPUT;
		} catch (BooksNotFoundException e) {
			addActionError("booksId： " + booksId + " 不存在");
			return INPUT;
		}
		request.setAttribute("Books", books);
		Hibernate.initialize(books.getTbCategory());
		request.setAttribute("SubCategoryList",
				CategoryService.getCategoryListByParentId(books.getTbCategory().getParentId()));
		return SUCCESS;
	}

}
