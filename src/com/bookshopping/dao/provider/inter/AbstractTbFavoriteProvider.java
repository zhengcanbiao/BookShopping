package com.bookshopping.dao.provider.inter;

import com.bookshopping.domain.TbFavorite;
import com.bookshopping.exception.FavoriteNotFoundException;

public interface AbstractTbFavoriteProvider {
	public void addFavorite(TbFavorite favorite);
	public void deleteFavorite(TbFavorite favorite);
	public void updateFavorite(TbFavorite favorite);
	public TbFavorite getFavoriteByFavoriteId(int favoriteId) throws FavoriteNotFoundException;
}
