package com.bookshopping.action.customer;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbCart;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

public class PreparePersonalHomeAction extends ActionSupport implements ServletRequestAware {
	private HttpServletRequest request;
	
	@Override
	public String execute() throws Exception {
		TbCustomer customer = CustomerService.getCurrentCustomer();
		List<TbOrder> orderList = customer.getTbOrders();
		List<TbOrder> recentOrders = new ArrayList<TbOrder>(0);
		List<TbCart> cartList = customer.getTbCarts();
		for (int i = orderList.size() - 1; i >= 0 && recentOrders.size() <= 2; i--) {
			TbOrder order = orderList.get(i);
			if (order.getValid()) {
				Hibernate.initialize(order.getTbOrderdetails().get(0).getTbBooks());
				recentOrders.add(order);
			}
		}
		int toIndex = (2 > cartList.size()) ? cartList.size() : 2;
		cartList = cartList.subList(0, toIndex);
		for (TbCart cart : cartList) {
			Hibernate.initialize(cart.getTbBooks());
		}
		int customerLevel = DiscountService.getDiscountLevelByPoints(customer.getPoints());
 		request.setAttribute("recentOrders", recentOrders);
 		request.setAttribute("cartList", cartList);
 		request.setAttribute("customerLevel", customerLevel);
	    return SUCCESS;
	}

	@Override
    public void setServletRequest(HttpServletRequest request) {
	    this.request = request;
    }
}
