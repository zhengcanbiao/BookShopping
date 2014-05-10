package com.bookshopping.dao.provider;

import java.util.ArrayList;
import java.util.List;

import com.bookshopping.dao.provider.inter.AbstractTbCategoryProvider;
import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCategory;
import com.bookshopping.exception.CategoryNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbCategoryProvider implements AbstractTbCategoryProvider {
	
	@Override
	public void addCategory(TbCategory category) {
		HibernateUtil.add(category);
	}

	@Override
	public void updateCategory(TbCategory category) {
		HibernateUtil.update(category);
	}
	
	@Override
	public TbCategory getCategoryByCategoryId(Integer categoryId) throws CategoryNotFoundException {
		TbCategory category = (TbCategory) HibernateUtil.get(TbCategory.class, categoryId);
		if (category == null) {
			throw new CategoryNotFoundException();
		} else {
			return category;
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<TbCategory> getCategoryListByParentId(int parentId) throws CategoryNotFoundException {
		List<TbCategory> list = (List<TbCategory>) HibernateUtil.executeQueryForMultiResults("from TbCategory where parentId=? and valid=1", new Object[]{parentId});
		if (list == null || list.isEmpty()) {
			throw new CategoryNotFoundException();
		} else {
			return list;
		}
	}
	
	@Override
	public List<TbBooks> getClothesListByCategoryId(int categoryId) {
		return getCategoryByCategoryId(categoryId).getTbBookses();
	}
	
	@Override
	public List<TbCategory> getSubcategoryListByCategoryId(int categoryId) {
		List<TbCategory> list = new ArrayList<TbCategory>(0);
		try {
			list.addAll(getCategoryListByParentId(categoryId));
			for (TbCategory category : list) {
				getSubcategoryListByCategoryId(category.getCategoryId());
			}
		} catch (CategoryNotFoundException ex) {
			ex.printStackTrace();
		}
		return list;
	}
	
	public List<TbCategory> getTbCategoryList()  {
		@SuppressWarnings("unchecked")
		List<TbCategory> list = HibernateUtil.executeQueryForMultiResults("from TbCategory", null);
		if (list == null) {
			throw new CategoryNotFoundException();
		} else {
			return list;
		}
	}
}
