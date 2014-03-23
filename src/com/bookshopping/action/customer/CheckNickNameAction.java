package com.bookshopping.action.customer;

import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class CheckNickNameAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String result;
	private String nickName;
	
	@Override
	public String execute() throws Exception {
		if (CustomerService.isNickNameExist(nickName)) {
			result = "success";
		} else {
			result = "fail";
		}
	    return SUCCESS;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	
	
}
