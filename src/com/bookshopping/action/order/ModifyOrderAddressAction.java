package com.bookshopping.action.order;

import com.bookshopping.domain.TbOrder;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

public class ModifyOrderAddressAction extends ActionSupport {
	private String receiverInfo;
	private String orderId;
	private String result;
	
	@Override
	public String execute() throws Exception {
		TbOrder order = OrderService.getOrderByOrderId(orderId);
		order.setReceiverInfo(receiverInfo);
		OrderService.updateOrder(order);
		result = "success";
	    return SUCCESS;
	}

	public String getReceiverInfo() {
		return receiverInfo;
	}

	public void setReceiverInfo(String receiverInfo) {
		this.receiverInfo = receiverInfo;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	

}
