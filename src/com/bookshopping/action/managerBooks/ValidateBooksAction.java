package com.bookshopping.action.managerBooks;

import com.bookshopping.service.BooksService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ValidateBooksAction extends ActionSupport {
	
	private int booksId;
	private int valid;
	
	public int getBooksId() {
		return booksId;
	}

	public void setBooksId(int booksId) {
		this.booksId = booksId;
	}

	public int getValid() {
		return valid;
	}

	public void setValid(int valid) {
		this.valid = valid;
	}

	@Override
	public String execute() throws Exception {
		BooksService.setBooksValidByBooksId(booksId, (valid == 1));
		return SUCCESS;
	}

}
