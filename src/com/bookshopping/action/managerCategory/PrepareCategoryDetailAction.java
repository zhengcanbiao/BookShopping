package com.bookshopping.action.managerCategory;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbCategory;
import com.bookshopping.exception.CategoryNotFoundException;
import com.bookshopping.service.CategoryService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PrepareCategoryDetailAction extends ActionSupport implements ServletRequestAware {
	
	private String categoryId;
	private HttpServletRequest request;
	
	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() {
		int Id;
		TbCategory category;
		try {
			Id = Integer.parseInt(categoryId);
			category = CategoryService.getCategoryByCategoryId(Id);
		} catch (NumberFormatException e) {
			addActionError("categoryId： " + categoryId + " 格式错误");
			return INPUT;
		} catch (CategoryNotFoundException e) {
			addActionError("categoryId： " + categoryId + " 不存在");
			return INPUT;
		}
		request.setAttribute("Category", category);
		return SUCCESS;
	}

}
