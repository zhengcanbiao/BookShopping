package com.bookshopping.action.customer;

import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class LogoutAction extends ActionSupport {

	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;

    @Override
    public String execute() {
    	CustomerService.clearSession();
    	CustomerService.clearCookie();
    	return SUCCESS;
    }
}
