package com.bookshopping.action.managerDiscount;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbDiscount;
import com.bookshopping.exception.DiscountNotFoundException;
import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PrepareDiscountAction extends ActionSupport implements ServletRequestAware {
	
	private String discountPoints;
	private HttpServletRequest request;
	
	public String getDiscountPoints() {
		return discountPoints;
	}
	
	public void setDiscountPoints(String discountPoints) {
		this.discountPoints = discountPoints;
	}
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() {
		int discountPoints2;
		TbDiscount discount;
		try {
			discountPoints2 = Integer.parseInt(discountPoints);
			discount = DiscountService.getDiscountByDiscountPoints(discountPoints2);
		} catch (NumberFormatException e) {
			addActionError("discountPoints：" + discountPoints + " 格式错误");
			return INPUT;
		} catch (DiscountNotFoundException e) {
			addActionError("discountPoints： " + discountPoints + " 不存在");
			return INPUT;
		}
		request.setAttribute("discountPoints", discountPoints2);
		request.setAttribute("discountRate", discount.getDiscountRate());
		return SUCCESS;
	}

}
