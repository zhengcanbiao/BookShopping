package com.bookshopping.action.cart;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCart;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.service.CartService;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

public class PrepareCartItemListAction extends ActionSupport implements ServletRequestAware {
	private HttpServletRequest request;
	
	@Override
	public String execute() throws Exception {
		int customerLevel;
		try {
			customerLevel = DiscountService.getDiscountLevelByPoints(CustomerService.getCurrentCustomer().getPoints());
		} catch (CustomerNotFoundException ex) {
			customerLevel = 0;
		}
	    List<TbCart> cartItemList = CartService.getCartItemList();
	    List<TbBooks> booksList = new ArrayList<TbBooks>(0);
	    List<Double> priceList = new ArrayList<Double>(0);
	    double totalPrice = 0.0;
	    for (TbCart cart : cartItemList) {
	    	TbBooks books = cart.getTbBooks();
	    	priceList.add(books.getPrice() / 100.0);
	    	totalPrice += books.getPrice() / 100.0 * cart.getBooksNumber();
	    	booksList.add(books);
	    }
	    request.setAttribute("customerLevel", customerLevel);
	    request.setAttribute("booksList", booksList);
	    request.setAttribute("cartItemList", cartItemList);
	    request.setAttribute("priceList", priceList);
	    request.setAttribute("totalPrice", totalPrice);
	    return SUCCESS;
	}

	@Override
    public void setServletRequest(HttpServletRequest request) {
	    this.request = request;
    }
}
