package com.bookshopping.action.order;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class PrepareOrderInfoListAction extends ActionSupport implements ServletRequestAware {
	private HttpServletRequest request;
	private int pageNow = 1;
	private int pageSize = 5;
	
	@Override
	public String execute() throws Exception {		
		TbCustomer customer = CustomerService.getCurrentCustomer();
		List<TbOrder> orderList = customer.getTbOrders();
		for (int i = 0; i < orderList.size(); i++) {
			if (!orderList.get(i).getValid()) {
				orderList.remove(i);
			}
		}
		Collections.reverse(orderList);
		int pageCount = (orderList.size()-1) / pageSize + 1;
		int fromIndex = (pageNow - 1) * pageSize;
		int toIndex = (pageNow * pageSize > orderList.size()) ? orderList.size() : (pageNow * pageSize);
		orderList = orderList.subList(fromIndex, toIndex);
		for (TbOrder order : orderList) {
			List<TbOrderdetail> orderDetailList = order.getTbOrderdetails();
			Hibernate.initialize(orderDetailList);
			for (TbOrderdetail orderDetail : orderDetailList) {
				Hibernate.initialize(orderDetail.getTbBooks());
			}
		}
		System.out.println("订单列表："+orderList.toString());
		for(TbOrder order: orderList){
			List<TbOrderdetail> orderDetailList = order.getTbOrderdetails();
			for (TbOrderdetail orderDetail : orderDetailList) {
				System.out.println("orderdetail:"+orderDetail.toString());
			}
		}
		
		request.setAttribute("orderList", orderList);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pageNow", pageNow);
		request.setAttribute("pageCount", pageCount);
	    return SUCCESS;
	}

	@Override
    public void setServletRequest(HttpServletRequest request) {
		this.request = request;
    }

	public int getPageNow() {
		return pageNow;
	}

	public void setPageNow(int pageNow) {
		this.pageNow = pageNow;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	
	
}
