package com.bookshopping.dao.provider.inter;

import java.util.List;

import com.bookshopping.domain.TbCity;
import com.bookshopping.domain.TbTown;

public interface AbstractTbCityProvider {
	public TbCity getCityByCityId(int cityId);
	public String getCityNameByCityId(int cityId);
	public List<TbTown> getTownListByCityId(int cityId);
}
