package com.bookshopping.action.customer;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ApplicationAware;
import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbDiscount;
import com.bookshopping.exception.DiscountNotFoundException;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.DiscountService;
import com.opensymphony.xwork2.ActionSupport;

public class PrepareCreditsAction extends ActionSupport implements ServletRequestAware, ApplicationAware {

	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
    private HttpServletRequest request;
    private Map<String, Object> application;

    @SuppressWarnings("unchecked")
    @Override
    public String execute() throws Exception {
    	TbCustomer customer = CustomerService.getCurrentCustomer();
    	int currentLevel;
    	int pointsToNextLevel = 0;
    	int currentPoints = customer.getPoints();
    	try {
    		List<TbDiscount> discountList = (List<TbDiscount>) application.get("discountList");
    		currentLevel = DiscountService.getDiscountLevelByPoints(customer.getPoints());
    		if (currentLevel < discountList.size() - 1) {
    			pointsToNextLevel = discountList.get(currentLevel + 1).getDiscountPoints() - currentPoints;
    		}
    	} catch (DiscountNotFoundException ex) {
    		pointsToNextLevel = 0;
    		currentLevel = 0;
    	}
    	request.setAttribute("currentPoints", currentPoints);
    	request.setAttribute("currentLevel", currentLevel);
    	request.setAttribute("pointsToNextLevel", pointsToNextLevel);
        return SUCCESS;
    }

	@Override
    public void setServletRequest(HttpServletRequest request) {
	    this.request = request;
    }

	@Override
    public void setApplication(Map<String, Object> application) {
	    this.application = application;
    }
    
}
