package com.bookshopping.action.customer;

import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {
	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
	private String customerName = "";
	private String password = "";
	private boolean savePassword = false;
	private String result;
	
	public boolean getSavePassword() {
		return savePassword;
	}

	public void setSavePassword(boolean savePassword) {
		this.savePassword = savePassword;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	@Override
	public String execute() throws Exception {
		if (CustomerService.validateCustomer(customerName, password) == false) {
	    	result = "wrongPassword";
	    } else if (!CustomerService.isCustomerValid(customerName)) {
	    	result = "customerNotValid";
	    } else {
			if (savePassword == true) {
				CustomerService.addCustomerToCookie(customerName, password);
			}
			CustomerService.putCustomerIntoSession(customerName);
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
	
}
