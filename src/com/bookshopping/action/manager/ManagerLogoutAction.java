package com.bookshopping.action.manager;

import com.bookshopping.service.AdminService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ManagerLogoutAction extends ActionSupport {

	@Override
	public String execute() {
		try {
			AdminService.clearSession();
		} catch (Exception e) {
		}
		return SUCCESS;
	}

}
