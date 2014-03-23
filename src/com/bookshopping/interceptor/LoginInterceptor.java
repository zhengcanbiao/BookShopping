package com.bookshopping.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.exception.NoActiveCustomerException;
import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginInterceptor extends AbstractInterceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		try {
			String customerName = CustomerService.getCurrentCustomerName();
			return invocation.invoke();
		} catch (NoActiveCustomerException ex) {
			HttpServletRequest request = (HttpServletRequest) invocation.getInvocationContext().get(ServletActionContext.HTTP_REQUEST);    
			String backwardUrl = request.getRequestURI();
			backwardUrl = backwardUrl.substring(backwardUrl.indexOf("/BookShopping/") + "/BookShopping/".length());
			System.out.println(backwardUrl);
			request.setAttribute("backwardUrl", backwardUrl);
			return "login";
		}
	}


}
