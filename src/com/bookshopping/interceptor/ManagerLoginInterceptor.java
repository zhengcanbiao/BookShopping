package com.bookshopping.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.exception.AdminNotFoundException;
import com.bookshopping.service.AdminService;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class ManagerLoginInterceptor extends AbstractInterceptor{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		try {
			String adminName = AdminService.getCurrentAdminName();
			System.out.println("adminName:"+adminName);
			return invocation.invoke();
		} catch (AdminNotFoundException ex) {
			HttpServletRequest request = (HttpServletRequest) invocation.getInvocationContext().get(ServletActionContext.HTTP_REQUEST);    
			String backwardUrl = request.getRequestURI();
			backwardUrl = backwardUrl.substring(backwardUrl.indexOf("/BookShopping/") + "/BookShopping/".length());
			System.out.println(backwardUrl);
			request.setAttribute("backwardUrl", backwardUrl);
			return "login";
		}
		
		
	}

}
