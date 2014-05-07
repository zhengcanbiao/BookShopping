package com.bookshopping.action.managerDiscount;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class AddDiscountAction extends ActionSupport {
	
	private String discountPoints;
	private String discountRate;
	
	public String getDiscountPoints() {
		return discountPoints;
	}
	
	public void setDiscountPoints(String discountPoints) {
		this.discountPoints = discountPoints;
	}
	
	public String getDiscountRate() {
		return discountRate;
	}
	
	public void setDiscountRate(String discountRate) {
		this.discountRate = discountRate;
	}
	
	@Override
	public String execute() {
		int discountPoints2, discountRate2;
		try {
			discountPoints2 = Integer.parseInt(discountPoints);
			discountRate2 = Integer.parseInt(discountRate);
		} catch (NumberFormatException e) {
			addActionError("discountPoints： " + discountPoints+ "或discountRate： " + discountRate + " 格式错误");
			return INPUT;
		}
		DiscountService.addDiscount(discountPoints2, discountRate2);
		ServletContext context = ServletActionContext.getServletContext();
		context.removeAttribute("discountList");
		context.setAttribute("discountList", DiscountService.getDiscountList());
		return SUCCESS;
	}

}
