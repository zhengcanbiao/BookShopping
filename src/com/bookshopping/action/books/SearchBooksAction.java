package com.bookshopping.action.books;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.exception.TargetNotFoundException;
import com.bookshopping.service.BooksService;
import com.opensymphony.xwork2.ActionSupport;

public class SearchBooksAction extends ActionSupport implements ServletRequestAware {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String keyword;
	private int pageNow = 1;
	private int pageSize = 16;
	private int orderIndex = BooksService.ORDER_BY_NAME;
	private HttpServletRequest request;
	
	@Override
	public String execute() throws Exception {
		List<TbBooks> booksList;
		try {
			booksList = BooksService.searchBooks(keyword, orderIndex);
			System.out.println("orderIndex:"+orderIndex);
			for (int i = 0; i < booksList.size(); i++) {
				if (booksList.get(i).getValid() == false) {
					booksList.remove(i);
				}
			}
			int pageCount = (booksList.size()-1) / pageSize + 1;
			int fromIndex = (pageNow-1) * pageSize;
			int toIndex = ((pageNow * pageSize) > booksList.size()) ? booksList.size() : (pageNow * pageSize);
			booksList = booksList.subList(fromIndex, toIndex);
//			for (TbBooks books : booksList) {
//				Hibernate.initialize(books.getTbBooksdetails());
//			}
			request.setAttribute("orderIndex", orderIndex);
			request.setAttribute("booksList", booksList);
			request.setAttribute("pageNow", pageNow);
			request.setAttribute("pageCount", pageCount);
			request.setAttribute("keyword", keyword);
		} catch (TargetNotFoundException ex) {
			ex.printStackTrace();
			booksList = null;
		}
		return SUCCESS;
	}
	
	public String getKeyword() {
		return keyword;
	}
	
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getPageNow() {
		return pageNow;
	}

	public void setPageNow(int pageNow) {
		this.pageNow = pageNow;
	}

	@Override
    public void setServletRequest(HttpServletRequest request) {
		this.request = request;
    }

	public int getOrderIndex() {
		return orderIndex;
	}

	public void setOrderIndex(int orderIndex) {
		this.orderIndex = orderIndex;
	}
	
	
	
}
