package com.bookshopping.action.order;

import com.bookshopping.exception.NoActiveCustomerException;
import com.bookshopping.exception.OrderNotFoundException;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

public class CancelOrderAction extends ActionSupport {
	private String orderId;

	@Override
	public String execute() throws Exception {
		try {
			String customerName = CustomerService.getCurrentCustomerName();
			OrderService.cancelOrderByOrderIdForCusomter(orderId, customerName);
		} catch (NoActiveCustomerException ex) {
			ex.printStackTrace();
		} catch (OrderNotFoundException ex) {
			ex.printStackTrace();
		}
	    return SUCCESS;
	}
	
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
}
