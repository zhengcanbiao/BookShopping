package com.bookshopping.action.managerOrder;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbOrder;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PrepareOrderAction extends ActionSupport implements ServletRequestAware {
	
	private HttpServletRequest request;
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() throws Exception {
		List<TbOrder> orderList = OrderService.getOrderList();
		for(TbOrder order : orderList) {
			Hibernate.initialize(order.getTbCustomer());
		}
		Collections.reverse(orderList);
		request.setAttribute("orderList", orderList);
		return SUCCESS;
	}

}
