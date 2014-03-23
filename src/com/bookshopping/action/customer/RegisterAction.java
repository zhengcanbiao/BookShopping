package com.bookshopping.action.customer;

import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class RegisterAction extends ActionSupport {
	private String customerName;
	private String nickName;
	private String password;
	
	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
	
	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
    public void validate() {
	    if (!CustomerService.validateCustomerNameFormat(customerName)) {
	    	this.addActionError("用户名格式错误");
	    } else if (CustomerService.isCustomerNameExist(customerName)) {
	    	this.addActionError("该用户名已被注册");
	    } else if (CustomerService.isNickNameExist(nickName)) {
	    	this.addActionError("该昵称已存在");
	    }
    }

	@Override
	public String execute() throws Exception {
		CustomerService.addCustomer(customerName, nickName, password);
		
		CustomerService.putCustomerIntoSession(customerName);
		return SUCCESS;
	}
}
