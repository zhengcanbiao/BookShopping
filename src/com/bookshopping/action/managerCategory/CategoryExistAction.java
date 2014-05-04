package com.bookshopping.action.managerCategory;

import java.util.List;

import com.bookshopping.domain.TbCategory;
import com.bookshopping.service.CategoryService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class CategoryExistAction extends ActionSupport {
	
	private String categoryName;
	private int parentId;
	private String result;
	
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

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	@Override
	public String execute() throws Exception {
		List<TbCategory> list = CategoryService.getCategoryListByParentId(parentId);
		result = "success";
		for (TbCategory category : list) {
			if (category.getCategoryName().equals(categoryName.trim())) {
				result = "error";
				break;
			}
		}
		return SUCCESS;
	}

}
