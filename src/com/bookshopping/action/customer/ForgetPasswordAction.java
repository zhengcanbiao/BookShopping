package com.bookshopping.action.customer;


import com.bookshopping.service.CustomerService;
import com.bookshopping.utils.mailConfirm.MailContent;
import com.bookshopping.utils.mailConfirm.MailSender;
import com.opensymphony.xwork2.ActionSupport;

public class ForgetPasswordAction extends ActionSupport {

	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
    private String customerName;
    private MailSender mailSender;
    private String result;

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public MailSender getMailSender() {
		return mailSender;
	}

	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	@Override
    public String execute() throws Exception {
		if (!CustomerService.isCustomerNameExist(customerName)) {
			result = "fail";
		} else {
			String tempPsw = CustomerService.setRandomPassword(customerName);
			mailSender.send(customerName, new MailContent("临时密码", "您的临时密码为" + tempPsw + "，请及时更改密码"));
			result = "success";
		}
		return SUCCESS;
    }

}
