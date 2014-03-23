package com.bookshopping.dao.provider.inter;

import java.util.List;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCategory;
import com.bookshopping.exception.CategoryNotFoundException;

public interface AbstractTbCategoryProvider {
	public void addCategory(TbCategory category);
	public void updateCategory(TbCategory category);
	public TbCategory getCategoryByCategoryId(Integer categoryId) throws CategoryNotFoundException;
	public List<TbCategory> getCategoryListByParentId(int parentId) throws CategoryNotFoundException;
	public List<TbBooks> getClothesListByCategoryId(int categoryId);
	public List<TbCategory> getSubcategoryListByCategoryId(int categoryId);
}
