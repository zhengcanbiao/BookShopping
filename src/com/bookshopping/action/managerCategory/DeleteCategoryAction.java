package com.bookshopping.action.managerCategory;

import com.bookshopping.domain.TbCategory;
import com.bookshopping.service.CategoryService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class DeleteCategoryAction extends ActionSupport {
	
	private int categoryId;

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
	@Override
	public String execute() {
		TbCategory category = CategoryService.getCategoryByCategoryId(categoryId);
		category.setValid(false);
		CategoryService.updateCategory(category);
		return SUCCESS;
	}

}
