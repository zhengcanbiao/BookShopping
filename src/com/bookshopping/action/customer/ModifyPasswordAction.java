package com.bookshopping.action.customer;

import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class ModifyPasswordAction extends ActionSupport {
	private String oldPassword;
	private String newPassword;
	
	@Override
	public String execute() throws Exception {
		String customerName = CustomerService.getCurrentCustomerName();
		if (!CustomerService.validateCustomer(customerName, oldPassword)) {
		} else {
			CustomerService.setPassword(newPassword);
		}
	    return SUCCESS;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
}
