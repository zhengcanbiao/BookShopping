package com.bookshopping.action.managerCategory;

import com.bookshopping.domain.TbCategory;
import com.bookshopping.service.CategoryService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ModifyCategoryAction extends ActionSupport {
	
	private int categoryId;
	private String categoryName;
	private int parentId;
	
	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

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
		TbCategory category = CategoryService.getCategoryByCategoryId(categoryId);
		category.setCategoryName(categoryName);
		category.setParentId(parentId);
		CategoryService.updateCategory(category);
		return SUCCESS;
	}

}
