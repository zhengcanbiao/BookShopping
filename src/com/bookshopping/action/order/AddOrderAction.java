package com.bookshopping.action.order;

import java.util.List;

import com.bookshopping.domain.TbCart;
import com.bookshopping.service.CartService;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

public class AddOrderAction extends ActionSupport {
	private String receiverInfo;
	
	@Override
	public String execute() throws Exception {
		boolean flag = false;
		try {
			List<TbCart> cartList = CartService.getCartItemList();
			if (OrderService.addOrder(cartList, receiverInfo, CustomerService.getCurrentCustomerName())) {
				flag = true;
			} else {
				flag = false;
			}
			CartService.emptyCartByCustomerName(CustomerService.getCurrentCustomerName());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		if (flag)
			return SUCCESS;
		else 
			return ERROR;
	}

	public String getReceiverInfo() {
		return receiverInfo;
	}

	public void setReceiverInfo(String receiverInfo) {
		this.receiverInfo = receiverInfo;
	}
	
	
}
