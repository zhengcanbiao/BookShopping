package com.bookshopping.action.cart;

import com.bookshopping.service.CartService;
import com.opensymphony.xwork2.ActionSupport;

public class AddToShoppingCartAction extends ActionSupport {
	private String booksId;
	private int booksNumber;
	private String result;
	
	@Override
	public String execute() throws Exception {
		if (CartService.addCart(Integer.parseInt(booksId), booksNumber)) 
			result = "success";
		else 
			result = "fail";
	    return SUCCESS;
	}

	public String getBooksId() {
		return booksId;
	}

	public void setBooksId(String booksId) {
		this.booksId = booksId;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public int getBooksNumber() {
		return booksNumber;
	}

	public void setBooksNumber(int booksNumber) {
		this.booksNumber = booksNumber;
	}
	
	

}
