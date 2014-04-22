package com.bookshopping.action.cart;

import com.bookshopping.service.CartService;
import com.opensymphony.xwork2.ActionSupport;

public class ModifyCartAction extends ActionSupport {
	private int cartId;
	private int booksNumber;
	
	@Override
	public String execute() throws Exception {
		if (booksNumber > 0)
			CartService.modifyBooksNumberByCartId(booksNumber, cartId);
		else {
			CartService.deleteCartByCartId(cartId);
		}
	    return super.execute();
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public int getBooksNumber() {
		return booksNumber;
	}

	public void setBooksNumber(int booksNumber) {
		this.booksNumber = booksNumber;
	}
	
	
}
