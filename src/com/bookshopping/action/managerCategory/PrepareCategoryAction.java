package com.bookshopping.action.managerCategory;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbCategory;
import com.bookshopping.service.CategoryService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PrepareCategoryAction extends ActionSupport implements ServletRequestAware {

	private HttpServletRequest request;
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}

	@Override
	public String execute() throws Exception {
		List<List<TbCategory>> allSecondCategoryList = new ArrayList<List<TbCategory>>(4);
		List<TbCategory> categoryList = CategoryService.getTopCategory();
		for (TbCategory category : categoryList) {
			allSecondCategoryList.add(CategoryService.getCategoryListByParentId(category.getCategoryId()));
		}
		request.setAttribute("AllSecondCategoryList", allSecondCategoryList);
		return SUCCESS;
	}
	
}
