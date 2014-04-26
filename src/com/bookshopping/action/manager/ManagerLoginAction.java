package com.bookshopping.action.manager;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.exception.AdminNotFoundException;
import com.bookshopping.service.AdminService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ManagerLoginAction extends ActionSupport implements ServletRequestAware {

	private String adminName;
	private String password;
	private HttpServletRequest request;
	
	public String getAdminName() {
		return adminName;
	}
	
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() {
		try {
			if(AdminService.login(adminName, password)) {
				AdminService.putAdminIntoSession(adminName);
				return SUCCESS;
			}
			request.setAttribute("errorPwd","密码错误");
			return ERROR;
		} catch(AdminNotFoundException e) {
			request.setAttribute("errorMsg","用户名不存在");
			return ERROR;
		}	
	}
}
