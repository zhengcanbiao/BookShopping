package com.bookshopping.action.managerDiscount;

import com.bookshopping.exception.DiscountNotFoundException;
import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class DiscountConfirmAction extends ActionSupport {
	
	private int discountPoints;
	private String result;
	
	public int getDiscountPoints() {
		return discountPoints;
	}
	
	public void setDiscountPoints(int discountPoints) {
		this.discountPoints = discountPoints;
	}
	
	public String getResult() {
		return result;
	}
	
	public void setResult(String result) {
		this.result = result;
	}
	
	@Override
	public String execute() {
		result = "error";
		try {
			DiscountService.getDiscountByDiscountPoints(discountPoints);
		} catch (DiscountNotFoundException e) {
			result = "success";
		}
		return SUCCESS;
	}

}
