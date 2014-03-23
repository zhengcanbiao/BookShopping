package com.bookshopping.action.customer;

import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class CheckCustomerNameAction extends ActionSupport {
	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
	private String customerName;
	private String result;
	
	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getResult() {
		return result;
	}
	
	public void setResult(String result) {
		this.result = result;
	}

	@Override
	public String execute() throws Exception {
		if (CustomerService.isCustomerNameExist(customerName)) {
			result = "success";
		} else {
			result = "fail";
		}
		
	    return SUCCESS;
	}
}
