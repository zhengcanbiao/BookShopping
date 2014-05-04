package com.bookshopping.action.managerOrder;

import com.bookshopping.domain.TbOrder;
import com.bookshopping.exception.OrderNotFoundException;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ModifyOrderAction extends ActionSupport {
	
	private String orderId;

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Override
	public String execute() throws Exception {
		TbOrder order = null;
		try {
			order = OrderService.getOrderByOrderId(orderId);
		} catch (OrderNotFoundException e) {
			addActionError("订单号： " + order.getOrderId() + " ，无此订单！");
			return INPUT;
		}
		if (order.getOrderStatus() != 1) {
			addActionError("订单号： " + order.getOrderId()+" ，订单的状态不为未发货！");
			return INPUT;
		}
		order.setOrderStatus(2);
		OrderService.updateOrder(order);
		return SUCCESS;
	}

}
