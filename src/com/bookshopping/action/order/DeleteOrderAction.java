package com.bookshopping.action.order;

import com.bookshopping.domain.TbOrder;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

public class DeleteOrderAction extends ActionSupport {
	private String orderId;
	
	@Override
	public String execute() throws Exception {
		TbOrder order = OrderService.getOrderByOrderId(orderId);
		order.setValid(false);
		OrderService.updateOrder(order);
	    return SUCCESS;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	
}
