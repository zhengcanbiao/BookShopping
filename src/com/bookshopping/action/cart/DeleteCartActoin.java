package com.bookshopping.action.cart;

import com.bookshopping.service.CartService;
import com.opensymphony.xwork2.ActionSupport;

public class DeleteCartActoin extends ActionSupport {
	private int cartId;
	
	@Override
	public String execute() throws Exception {
	    CartService.deleteCartByCartId(cartId);
	    return SUCCESS;
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	
}
