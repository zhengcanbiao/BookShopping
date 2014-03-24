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

public class PrepareBooksInfoListAction extends ActionSupport implements ServletRequestAware {
	private int categoryId;
	private int booksId;
	private HttpServletRequest request;
	final private int pageSize = 16;
	private int pageNow;
	
	@Override
	public String execute() throws Exception {
		List<TbBooks> booksList = BooksService.getValidBooksListByCategoryId(categoryId);
		int pageCount = (booksList.size()-1) / pageSize + 1;
		int fromIndex = (pageNow-1) * pageSize;
		int toIndex = ((pageNow * pageSize) > booksList.size()) ? booksList.size() : (pageNow * pageSize);
		booksList = booksList.subList(fromIndex, toIndex);
//		
		
		request.setAttribute("booksList", booksList);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("categoryId", categoryId);
		
		return SUCCESS;
	}

	public int getPageNow() {
		return pageNow;
	}

	public void setPageNow(int pageNow) {
		this.pageNow = pageNow;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	@Override
    public void setServletRequest(HttpServletRequest request) {
		this.request = request;
    }

	public int getBooksId() {
		return booksId;
	}

	public void setBooksId(int booksId) {
		this.booksId = booksId;
	}

}
