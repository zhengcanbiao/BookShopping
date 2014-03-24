package com.bookshopping.action.category;

import com.bookshopping.service.CategoryService;
import com.opensymphony.xwork2.ActionSupport;

public class GetSubcategoryListAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String parentId;
	private String result;
	
	@Override
	public String execute() throws Exception {
		result = CategoryService.generateJsonForCategoryList(CategoryService.getCategoryListByParentId(Integer.parseInt(parentId)));
	    return SUCCESS;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	
}
