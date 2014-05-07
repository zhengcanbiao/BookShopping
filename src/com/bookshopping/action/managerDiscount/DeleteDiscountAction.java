package com.bookshopping.action.managerDiscount;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.domain.TbDiscount;
import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class DeleteDiscountAction extends ActionSupport {
	
	private int discountPoints;
	private int discountRate;
	
	public int getDiscountPoints() {
		return discountPoints;
	}
	
	public void setDiscountPoints(int discountPoints) {
		this.discountPoints = discountPoints;
	}
	
	public int getDiscountRate() {
		return discountRate;
	}
	
	public void setDiscountRate(int discountRate) {
		this.discountRate = discountRate;
	}
	
	@Override
	public String execute() {
		DiscountService.deleteDiscount(new TbDiscount(discountPoints, discountRate));
		ServletContext context = ServletActionContext.getServletContext();
		context.removeAttribute("discountList");
		context.setAttribute("discountList", DiscountService.getDiscountList());
		return SUCCESS;
	}

}
