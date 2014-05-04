package com.bookshopping.action.managerBooks;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.exception.TargetNotFoundException;
import com.bookshopping.service.BooksService;
import com.bookshopping.service.comparator.BooksIdComparator;
import com.bookshopping.service.comparator.BooksNameComparator;
import com.bookshopping.service.comparator.BooksPriceComparator;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class SearchBooksAction extends ActionSupport implements ServletRequestAware{
	
	private int searchChoice;
	private String keyword;
	private HttpServletRequest request;
	
	public int getSearchChoice() {
		return searchChoice;
	}

	public void setSearchChoice(int searchChoice) {
		this.searchChoice = searchChoice;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public String execute() {
	
		//java.util.Comparator cmp = Collator.getInstance(java.util.Locale.CHINA);
		try {
			List<TbBooks> booksList = BooksService.searchBooks(keyword);
			if (searchChoice == 0) {
				Collections.sort(booksList, new BooksIdComparator());
			} else if (searchChoice == 1) {
				Collections.sort(booksList, new BooksNameComparator());
			} else if (searchChoice == 2) {
				Collections.sort(booksList, new BooksPriceComparator(true));
			}
			request.setAttribute("BooksList", booksList);
		} catch (TargetNotFoundException e) {
		}
		request.setAttribute("keyword", keyword);
		request.setAttribute("searchChoice", searchChoice);
		return SUCCESS;
	}

}
