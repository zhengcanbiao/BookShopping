package com.bookshopping.action.managerDiscount;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.domain.TbDiscount;
import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ModifyDiscountAction extends ActionSupport {
	
	private String oldDiscountPoints;
	private String discountPoints;
	private String discountRate;
	
	public String getOldDiscountPoints() {
		return oldDiscountPoints;
	}

	public void setOldDiscountPoints(String oldDiscountPoints) {
		this.oldDiscountPoints = oldDiscountPoints;
	}

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
		int oldDiscountPoints2, discountPoints2, discountRate2;
		try {
			oldDiscountPoints2 = Integer.parseInt(oldDiscountPoints);
			discountPoints2 = Integer.parseInt(discountPoints);
			discountRate2 = Integer.parseInt(discountRate);
		} catch (NumberFormatException e) {
			addActionError("折扣或积分格式错误");
			return INPUT;
		}
		TbDiscount discount = DiscountService.getDiscountByDiscountPoints(oldDiscountPoints2);
		if(oldDiscountPoints2 != discountPoints2) {
			DiscountService.deleteDiscount(discount);
			DiscountService.addDiscount(discountPoints2, discountRate2);
		} else {
			discount.setDiscountRate(discountRate2);
			DiscountService.updateDiscount(discount);
		}
		ServletContext context = ServletActionContext.getServletContext();
		context.removeAttribute("discountList");
		context.setAttribute("discountList", DiscountService.getDiscountList());
		return SUCCESS;
	}

}
