package com.bookshopping.action.customer;

import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.service.CustomerService;
import com.opensymphony.xwork2.ActionSupport;

public class ModifyPersonalInfoAction extends ActionSupport {

	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
    private String nickName;
    private Integer sex;
    private String result;

	@Override
    public void validate() {
    	try {
	        if (!(CustomerService.getCurrentCustomer().getNickName().equals(nickName))
	        		&& CustomerService.isNickNameExist(nickName)) {
	        	addActionError("该昵称已被注册");
	        }
        } catch (CustomerNotFoundException e) {
	        e.printStackTrace();
        }
		
    }
    
    @Override
    public String execute() throws Exception {
    	CustomerService.modifyPersonalInfo(nickName, sex);
    	return SUCCESS;
    }

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}
	
}
