package com.bookshopping.action.comment;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbOrder;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.exception.OrderNotFoundException;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

public class PrepareCommentAction extends ActionSupport implements ServletRequestAware {
	private String orderId;
	private HttpServletRequest request;
	
	@Override
	public String execute() throws Exception {
		try {
			String customerName = CustomerService.getCurrentCustomerName();
			TbOrder order = OrderService.getOrderByOrderId(orderId);
			if (CustomerService.isOrderBelongToCustomer(order, customerName) 
					&& order.getOrderStatus().equals(OrderService.CONFIRM_DELIVERY)
					&& (!order.getIsComment())) {
				List<TbOrderdetail> orderDetailList = order.getTbOrderdetails();
				for (TbOrderdetail orderDetail : orderDetailList) {
					Hibernate.initialize(orderDetail.getTbBooks());
				}
				request.setAttribute("booksDetailList", orderDetailList);
				return SUCCESS;
			} else {
				throw new OrderNotFoundException();
			}
		} catch (OrderNotFoundException ex) {
			return ERROR;
		}
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	@Override
    public void setServletRequest(HttpServletRequest request) {
		this.request = request;
    }
	
	
}
