package com.bookshopping.action.cart;

import java.util.List;

import com.bookshopping.domain.TbCart;
import com.bookshopping.service.CartService;
import com.opensymphony.xwork2.ActionSupport;

public class GetCartItemListAction extends ActionSupport {
	private String result;
	
	@Override
	public String execute() throws Exception {
		try {
			List<TbCart> list = CartService.getCartItemList();
			result = CartService.generateJsonForCartList(list);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return SUCCESS;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
}
