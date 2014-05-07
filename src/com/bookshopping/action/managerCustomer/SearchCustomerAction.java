package com.bookshopping.action.managerCustomer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbDiscount;
import com.bookshopping.exception.TargetNotFoundException;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.comparator.CustomerNameComparator;
import com.bookshopping.service.comparator.CustomerNickNameComparator;
import com.bookshopping.service.comparator.CustomerPointsComparator;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class SearchCustomerAction extends ActionSupport implements ServletRequestAware{
	
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
	@SuppressWarnings("unchecked")
	public String execute() {
		try {
			List<TbCustomer> customerList = CustomerService.searchCustomer(keyword);
			if (searchChoice == 0) {
				Collections.sort(customerList, new CustomerNameComparator());
			} else if (searchChoice == 1) {
				Collections.sort(customerList, new CustomerNickNameComparator());
			} else if (searchChoice == 2) {
				Collections.sort(customerList, new CustomerPointsComparator());
			}
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
		} catch (TargetNotFoundException e) {
		}
		request.setAttribute("keyword", keyword);
		request.setAttribute("searchChoice", searchChoice);
		return SUCCESS;
	}

}
