package com.bookshopping.action.manager;

import com.bookshopping.exception.AdminNotFoundException;
import com.bookshopping.service.AdminService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class AdminExistAction extends ActionSupport {
	
	private String adminName;
	private String result;
	
	public String getAdminName() {
		return adminName;
	}
	
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	
	public String getResult() {
		return result;
	}
	
	public void setResult(String result) {
		this.result = result;
	}
	
	@Override
	public String execute() {
		result = "success";
		try {
			AdminService.getTbAdminProvider().getAdminByAdminName(adminName);
		} catch(AdminNotFoundException e) {
			result = "error";
		}
		return SUCCESS;
	}

}
