package com.bookshopping.action.books;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.service.BooksService;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

public class PrepareBooksDetailAction extends ActionSupport implements ServletRequestAware {
	private int booksId;
	private HttpServletRequest request;

	@Override
	public String execute() throws Exception {
		TbBooks books = BooksService.getBooksByBooksId(booksId);
	//	Hibernate.initialize(books.getTbBooks());
		Hibernate.initialize(books.getTbCategory());
		Hibernate.initialize(books.getTbComments());
	//	List<TbBooks> booksDetailList = books.getTbBookss();
		int customerLevel;
		try {
			TbCustomer customer = CustomerService.getCurrentCustomer();
			customerLevel = DiscountService.getDiscountLevelByPoints(customer.getPoints());
		} catch (CustomerNotFoundException ex) {
			customerLevel = 0;
		}
		System.out.println(books.getBookName());
		//request.setAttribute("booksDetail", booksDetailList);
		request.setAttribute("currentBooks", books);
		request.setAttribute("customerLevel", customerLevel);
	    return SUCCESS;
	}
	
	public int getBooksId() {
		return booksId;
	}

	public void setBooksId(int booksId) {
		this.booksId = booksId;
	}

	@Override
    public void setServletRequest(HttpServletRequest request) {
		this.request = request;
    }
}
