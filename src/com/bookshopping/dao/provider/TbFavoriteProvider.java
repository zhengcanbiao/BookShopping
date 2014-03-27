package com.bookshopping.dao.provider;

import com.bookshopping.dao.provider.inter.AbstractTbFavoriteProvider;
import com.bookshopping.domain.TbFavorite;
import com.bookshopping.exception.FavoriteNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbFavoriteProvider implements AbstractTbFavoriteProvider{
	
	@Override
	public void addFavorite(TbFavorite favorite) {
		HibernateUtil.add(favorite);
	}
	
	@Override
	public void deleteFavorite(TbFavorite favorite) {
		HibernateUtil.delete(favorite);
	}
	
	@Override
	public void updateFavorite(TbFavorite favorite) {
		HibernateUtil.update(favorite);
	}
	
	@Override
	public TbFavorite getFavoriteByFavoriteId(int favoriteId) throws  FavoriteNotFoundException {
		TbFavorite favorite = (TbFavorite) HibernateUtil.get(TbFavorite.class, favoriteId);
		if (favorite == null) {
			throw new FavoriteNotFoundException();
		} else {
			return favorite;
		}
	}
	
}
