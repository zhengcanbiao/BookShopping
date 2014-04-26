package com.bookshopping.action.manager;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.domain.TbAdmin;
import com.bookshopping.service.AdminService;
import com.bookshopping.utils.SHAEncypherUtil;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class AdminPwdConfirmAction extends ActionSupport {
	
	private String password;
	private String result;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	@Override
	public String execute() {
		String adminName = null;
		try {
			adminName = (String)ServletActionContext.getContext().getSession().get("currentAdminName");
		} catch (Exception e) {
			result = "timeout";
			return SUCCESS;
		}
		TbAdmin admin = AdminService.getTbAdminProvider().getAdminByAdminName(adminName);
		result = "error";
		if (SHAEncypherUtil.encryptSHA(password).equals(admin.getPassword())) {
			result = "success";
		}
		return SUCCESS;
	}

}
