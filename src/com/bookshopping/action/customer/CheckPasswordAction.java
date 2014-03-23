package com.bookshopping.action.customer;

import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class CheckPasswordAction extends ActionSupport {
	private String result;
	private String password;
	
	@Override
	public String execute() {
		String customerName = CustomerService.getCurrentCustomerName();
	    if (!CustomerService.validateCustomer(customerName, password)) {
	    	result = "fail";
	    } else {
	    	result = "success";
	    }
	    return SUCCESS;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
