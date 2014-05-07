package com.bookshopping.action.managerCustomer;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbDiscount;
import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class PrepareCustomerAction extends ActionSupport implements ServletRequestAware{
	
	private static final long serialVersionUID = 1L;
	private HttpServletRequest request;
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public String execute() throws Exception {
		List<TbCustomer> customerList = CustomerService.getCustomerAscListByPoint();
		List<TbDiscount> customerDiscountList = new ArrayList<TbDiscount>(customerList.size());
		List<Integer> customerRankList = new ArrayList<Integer>(customerList.size());
		Map<String, Object> application = ServletActionContext.getContext().getApplication();
		List<TbDiscount> discountList = (List<TbDiscount>) application.get("discountList");
		for(TbCustomer customer : customerList ){
			int index = CustomerService.getDiscountIndexByCustomer(customer);
			customerRankList.add(index);
			customerDiscountList.add(discountList.get(index));
		}
		request.setAttribute("DiscountList", customerDiscountList);
		request.setAttribute("RankList", customerRankList);
		request.setAttribute("CustomerList", customerList);
		return SUCCESS;
	}
	
}
