package com.bookshopping.dao.provider;

import java.util.ArrayList;
import java.util.List;

import com.bookshopping.dao.provider.inter.AbstractTbBooksProvider;
import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCategory;
import com.bookshopping.domain.TbComment;
import com.bookshopping.exception.BooksNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbBooksProvider implements AbstractTbBooksProvider{

	@Override
	public void addBooks(TbBooks clothes) {
		HibernateUtil.add(clothes);
	}
	
	@Override
	public void updateBooks(TbBooks clothes) {
		HibernateUtil.update(clothes);
	}
	
	@Override
	public TbBooks getBooksByBooksId(int clothesId) throws BooksNotFoundException {
		TbBooks clothes = (TbBooks) HibernateUtil.get(TbBooks.class, clothesId);
		if (clothes == null) {
			throw new BooksNotFoundException();
		} else {
			return clothes;
		}
	}

//	@Override
//	public List<TbBooks> getBooksDetailListByBooksId(int clothesId)
//			throws BooksNotFoundException {
//		TbBooks clothes = getBooksByBooksId(clothesId);
//		List<TbBooks> clothesDetail = new ArrayList<TbBooks> (clothes.getTbBooks());
//		Hibernate.initialize(clothesDetail);
//		return clothesDetail;
//	}

	@Override
	public List<TbComment> getCommentListByBooksId(Integer clothesId)
			throws BooksNotFoundException {
		TbBooks clothes = getBooksByBooksId(clothesId);
		List<TbComment> comment = new ArrayList<TbComment> (clothes.getTbComments());
		return comment;
	}

	@Override
    public List<TbComment> getCommentListByBooksId(int clothesId) {
	    // TODO Auto-generated method stub
	    return null;
    }

	@SuppressWarnings("unchecked")
    public List<TbBooks> getBooksListByCategoryList(List<TbCategory> categoryList) {
		StringBuffer hql = new StringBuffer("from TbBooks");
		String condition = "tbCategory=?";
		if (categoryList != null && !categoryList.isEmpty()) {
			hql.append(" where ").append(condition);
			for (int i = 1; i < categoryList.size(); i++) {
				hql.append(" or ").append(condition);
			}
		}
		List<TbBooks> list = HibernateUtil.executeQueryForMultiResults(hql.toString(), categoryList.toArray());
		System.out.println("查到的书："+list);
	    return list;
    }

	@SuppressWarnings("unchecked")
    public List<TbBooks> getValidBooksListByCategoryList(
            List<TbCategory> categoryList) {
		StringBuffer hql = new StringBuffer("from TbBooks");
		String condition = "tbCategory=?";
		if (categoryList != null && !categoryList.isEmpty()) {
			hql.append(" where ").append(condition);
			for (int i = 1; i < categoryList.size(); i++) {
				hql.append(" or ").append(condition);
			}
		}
		List<TbBooks> list = HibernateUtil.executeQueryForMultiResults(hql.toString() + "and valid=1", categoryList.toArray());
	    return list;
    }

	@Override
	@SuppressWarnings("unchecked")
	public List<TbBooks> getBooksList() throws BooksNotFoundException {
		List<TbBooks> list = HibernateUtil.executeQueryForMultiResults("from TbBooks", null);
		if (list == null) {
			throw new BooksNotFoundException();
		} else {
			return list;
		}
	}
//	@Override
//	public void addBooksdetail(TbBooks clothesDetail) {
//		HibernateUtil.add(clothesDetail);
//	}
//
//	@Override
//	public void updateBooksdetail(TbBooks clothesDetail) {
//		HibernateUtil.update(clothesDetail);
//	}

//	@Override
//	public TbBooks getBooksdetailByBooksdetailId(int clothesDetailId) throws BooksdetailNotFoundException {
//		TbBooks clothesdetail = (TbBooks) HibernateUtil.get(TbBooks.class, clothesDetailId);
//		if (clothesdetail == null) {
//			throw new BooksdetailNotFoundException();
//		} else {
//			return clothesdetail;
//		}
//	}

//	@Override
//	public List<TbBooks> getBooksDetailListByBooksId(int clothesId) {
//		// TODO Auto-generated method stub
//		return null;
//	}
}
