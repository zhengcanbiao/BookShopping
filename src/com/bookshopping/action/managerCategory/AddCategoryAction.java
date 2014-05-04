package com.bookshopping.action.managerCategory;

import com.bookshopping.service.CategoryService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class AddCategoryAction extends ActionSupport {
	
	private String categoryName;
	private int parentId;

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	@Override
	public String execute() {
		CategoryService.addCategory(categoryName, parentId);
		return SUCCESS;
	}

}
