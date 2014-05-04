package com.bookshopping.action.managerOrder;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.exception.OrderNotFoundException;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PrepareOrderDetailAction extends ActionSupport implements ServletRequestAware {
	
	private String orderId;
	private HttpServletRequest request;
	
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() throws Exception {
		TbOrder order;
		try {
			order = OrderService.getOrderByOrderId(orderId);
		} catch (OrderNotFoundException e) {
			addActionError("orderId： " + orderId + " 不存在");
			return INPUT;
		}
		
		List<TbOrderdetail> orderDetailList = OrderService.getOrdertailListByOrderId(orderId);
		List<TbBooks> books = new ArrayList<TbBooks>(orderDetailList.size());
		for (int i = 0; i < orderDetailList.size(); i++ ) {
			books.add(orderDetailList.get(i).getTbBooks());
			Hibernate.initialize(books);
		}
		Hibernate.initialize(order.getTbCustomer());
		request.setAttribute("order", order);
		request.setAttribute("orderDetail", orderDetailList);
		request.setAttribute("books", books);
		
		return SUCCESS;
	}

}
