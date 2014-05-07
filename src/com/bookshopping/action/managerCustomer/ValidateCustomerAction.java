package com.bookshopping.action.managerCustomer;

import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ValidateCustomerAction extends ActionSupport {
	private String customerName;
	private int valid;

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public int getValid() {
		return valid;
	}

	public void setValid(int valid) {
		this.valid = valid;
	}

	@Override
	public String execute() throws Exception {
		CustomerService.setCustomerValidByCustomerName(customerName, (valid == 1));
		return super.execute();
	}
	
}
