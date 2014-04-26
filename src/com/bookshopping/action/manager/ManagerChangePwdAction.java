package com.bookshopping.action.manager;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.service.AdminService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ManagerChangePwdAction extends ActionSupport implements ServletRequestAware {
	
	private String old_password;
	private String new_password;
	private String new_password1;
	private HttpServletRequest request;
	
	@Override
	public String execute() throws Exception {
		try {
			AdminService.changePsw(new_password);
		} catch (Exception e) {
			request.setAttribute("errorMsg", "您过长时间未登陆，请重新登陆");
			return ERROR;
		}
		return SUCCESS;
	}

	public String getOld_password() {
		return old_password;
	}
	
	public void setOld_password(String old_password) {
		this.old_password = old_password;
	}
	
	public String getNew_password() {
		return new_password;
	}
	
	public void setNew_password(String new_password) {
		this.new_password = new_password;
	}
	
	public String getNew_password1() {
		return new_password1;
	}
	
	public void setNew_password1(String new_password1) {
		this.new_password1 = new_password1;
	}
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
}
