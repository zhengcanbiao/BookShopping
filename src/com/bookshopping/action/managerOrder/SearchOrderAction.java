package com.bookshopping.action.managerOrder;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbOrder;
import com.bookshopping.exception.TargetNotFoundException;
import com.bookshopping.service.OrderService;
import com.bookshopping.service.comparator.OrderCustomerNameComparator;
import com.bookshopping.service.comparator.OrderIdComparator;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class SearchOrderAction extends ActionSupport implements ServletRequestAware{
	
	private int searchChoice;
	private String keyword;
	private HttpServletRequest request;
	
	public int getSearchChoice() {
		return searchChoice;
	}

	public void setSearchChoice(int searchChoice) {
		this.searchChoice = searchChoice;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() {
		try {
			List<TbOrder> orderList = OrderService.searchOrder(keyword);
			if (searchChoice == 0) {
				Collections.sort(orderList, new OrderIdComparator());
			} else if (searchChoice == 1) {
				Collections.sort(orderList, new OrderCustomerNameComparator());
			}
			for(TbOrder order : orderList) {
				Hibernate.initialize(order.getTbCustomer());
			}
			request.setAttribute("orderList", orderList);
		} catch (TargetNotFoundException e) {
		}
		request.setAttribute("keyword", keyword);
		request.setAttribute("searchChoice", searchChoice);
		return SUCCESS;
	}

}
