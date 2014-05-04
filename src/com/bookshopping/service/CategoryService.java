package com.bookshopping.service;

import java.util.ArrayList;
import java.util.List;

import com.bookshopping.dao.provider.TbCategoryProvider;
import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCategory;
import com.bookshopping.exception.CategoryNotFoundException;
import com.bookshopping.utils.SpringUtil;

public class CategoryService {
	private CategoryService() {
	}
	
	public static List<TbCategory> getTopCategory() {
		return getTbCategoryProvider().getCategoryListByParentId(0);
	}
	
	public static List<TbCategory> getCategoryListByParentId(int parentId) {
		return getTbCategoryProvider().getCategoryListByParentId(parentId);
	}
	
	public static TbCategoryProvider getTbCategoryProvider() {
		return (TbCategoryProvider) SpringUtil.getBeanById("tbCategoryProvider");
	}
	
	public static String generateJsonForCategoryList(List<TbCategory> categoryList) {
		if (categoryList == null) {
			throw new NullPointerException();
		}
		StringBuffer result = new StringBuffer("");
		for (TbCategory category : categoryList) {
			result.append(",{");
			result.append("\"categoryId\":" + category.getCategoryId() + ",");
			result.append("\"categoryName\":\"" + category.getCategoryName() + "\"");
			result.append("}");
		}
		return "[" + result.substring(1) + "]";
	}
	
	public static List<TbBooks> getClothesListByCategoryId(int categoryId) {
		List<TbBooks> clothesList = new ArrayList<TbBooks>();
		try {
			List<TbCategory> categoryList = getCategoryListByParentId(categoryId);
			for (TbCategory category : categoryList) {
				clothesList.addAll(getClothesListByCategoryId(category.getCategoryId()));
			}
		} catch(CategoryNotFoundException ex) {
			clothesList.addAll(getTbCategoryProvider().getClothesListByCategoryId(categoryId));
		}
		return clothesList;
	}

	public static List<TbCategory> getSubcategoryListByCategoryId(int categoryId) {
	    List<TbCategory> list = new ArrayList<TbCategory>(0);
	    try {
		    list.addAll(getCategoryListByParentId(categoryId));
		    List<TbCategory> tempList = new ArrayList<TbCategory>(0);
		    for (TbCategory category : list) {
		    	tempList.addAll(getSubcategoryListByCategoryId(category.getCategoryId()));
		    }
		    list.addAll(tempList);
	    } catch (CategoryNotFoundException ex) {
	    	ex.printStackTrace();
	    }
	    return list;
    }

	public static TbCategory getCategoryByCategoryId(int categoryId) {
	    return getTbCategoryProvider().getCategoryByCategoryId(categoryId);
    }
	
	public static void updateCategory(TbCategory category) {
		getTbCategoryProvider().updateCategory(category);
	}
	
	public static void addCategory(String categoryName, int parentId) {
		TbCategory category = new TbCategory(categoryName);
		category.setParentId(parentId);
		getTbCategoryProvider().addCategory(category);
	}
}
