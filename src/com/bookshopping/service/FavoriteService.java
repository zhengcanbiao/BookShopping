package com.bookshopping.service;

import java.util.List;

import com.bookshopping.dao.provider.TbFavoriteProvider;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbFavorite;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.exception.FavoriteExistException;
import com.bookshopping.exception.NoMoreFavoriteException;
import com.bookshopping.utils.SpringUtil;

public class FavoriteService {
	private FavoriteService() {
	}

	public static void addFavorite(int booksId) throws FavoriteExistException {
		try {
			TbCustomer customer = CustomerService.getCurrentCustomer();
			List<TbFavorite> favorites = customer.getTbFavorites();
			if (favorites.size() >= 10) {
				throw new NoMoreFavoriteException();
			}
			for (TbFavorite favorite : favorites) {
				if (favorite.getTbBooks().getBooksId().equals(booksId)) {
					throw new FavoriteExistException();
				}
			}
			TbFavorite favorite = new TbFavorite(BooksService.getBooksByBooksId(booksId), customer);
			getTbFavoriteProvider().addFavorite(favorite);
		} catch (CustomerNotFoundException ex) {
			ex.printStackTrace();
			throw ex;
		}
    }

	public static TbFavoriteProvider getTbFavoriteProvider() {
		return (TbFavoriteProvider) SpringUtil.getBeanById("tbFavoriteProvider");
	}
	
	public static TbFavorite getFavoriteByFavoriteId(int favoriteId) {
		TbFavorite favorite = getTbFavoriteProvider().getFavoriteByFavoriteId(favoriteId);
		return favorite;
	}

	public static void deleteFavoriteByFavoriteId(int favoriteId) {
		TbFavorite favorite = getFavoriteByFavoriteId(favoriteId);
		getTbFavoriteProvider().deleteFavorite(favorite);
    }

	public static List<TbFavorite> getFavoriteList() {
	    TbCustomer customer = CustomerService.getCurrentCustomer();
	    return customer.getTbFavorites();
    }
}
