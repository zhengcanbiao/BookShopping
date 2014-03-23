package com.bookshopping.action.customer;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbCustomer;
import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class PreparePersonalInfoAction extends ActionSupport implements ServletRequestAware {
	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
    private HttpServletRequest request;
    
    public String execute() throws Exception {
    	TbCustomer customer = CustomerService.getCurrentCustomer();
    	request.setAttribute("nickName", customer.getNickName());
    	request.setAttribute("sex", customer.getSex());
    	return SUCCESS;
    }

	@Override
    public void setServletRequest(HttpServletRequest request) {
	    this.request = request;
    }

}
