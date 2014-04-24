package com.bookshopping.action.order;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbAddress;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.exception.OrderNotFoundException;
import com.bookshopping.service.AddressService;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.DiscountService;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

public class PrepareOrderDetailAction extends ActionSupport implements ServletRequestAware {
	private String orderId;
	private HttpServletRequest request;
	
	@Override
	public String execute() throws Exception {
		try {
			TbCustomer customer = CustomerService.getCurrentCustomer();
			TbOrder order = OrderService.getOrderByOrderId(orderId);
			List<TbAddress> addressList = customer.getTbAddresses();
			AddressService.initializeAddressList(addressList);
			int customerLevel = DiscountService.getDiscountLevelByPoints(customer.getPoints());
			if (customer.getTbOrders().contains(order)) {
				List<TbOrderdetail> orderDetailList = order.getTbOrderdetails();
				for (TbOrderdetail orderDetail : orderDetailList) {
					Hibernate.initialize(orderDetail.getTbBooks());
				}
				request.setAttribute("customerLevel", customerLevel);
				request.setAttribute("addressList", addressList);
				request.setAttribute("currentOrder", order);
				request.setAttribute("orderDetailList", orderDetailList);
			} else {
				throw new OrderNotFoundException();
			}
		} catch (CustomerNotFoundException ex) {
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

	@Override
    public void setServletRequest(HttpServletRequest request) {
		this.request = request;
    }
	
}
