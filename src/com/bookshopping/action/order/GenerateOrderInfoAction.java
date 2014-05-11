package com.bookshopping.action.order;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbAddress;
import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCart;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.service.AddressService;
import com.bookshopping.service.CartService;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

public class GenerateOrderInfoAction extends ActionSupport implements ServletRequestAware {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private HttpServletRequest request;
	
	@Override
	public String execute() throws Exception {
		TbCustomer customer = CustomerService.getCurrentCustomer();
	    List<TbCart> cartItemList = CartService.getCartItemList();
	    List<TbBooks> booksDetailList = new ArrayList<TbBooks>(0);
	    List<TbAddress> addressList = customer.getTbAddresses();
	    AddressService.initializeAddressList(addressList);
	    int customerLevel = DiscountService.getDiscountLevelByPoints(customer.getPoints());
	    double totalPrice = 0.0;
	    for (TbCart cart : cartItemList) {
	    	TbBooks booksDetail = cart.getTbBooks();
	    	totalPrice += booksDetail.getPrice() / 100.0 * cart.getBooksNumber();
	    	booksDetailList.add(booksDetail);
	    	Hibernate.initialize(booksDetail);
	    }
	    request.setAttribute("customerLevel", customerLevel);
	    request.setAttribute("cartItemList", cartItemList);
	    request.setAttribute("booksDetailList", booksDetailList);
	    request.setAttribute("totalPrice", totalPrice);
	    request.setAttribute("addressList", addressList);
	    return SUCCESS;
	}

	@Override
    public void setServletRequest(HttpServletRequest request) {
		this.request = request;
    }
}
