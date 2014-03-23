package com.bookshopping.interceptor;

import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class AutoLoginInterceptor extends AbstractInterceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    public String intercept(ActionInvocation invocation) throws Exception {
    	try {
    		CustomerService.loadCustomerFromCookieToSession();
    	} catch(Exception ex) {
    		ex.printStackTrace();
    	}
	    return invocation.invoke();
    }


}
