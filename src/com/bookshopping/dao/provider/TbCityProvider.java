package com.bookshopping.dao.provider;

import java.util.ArrayList;
import java.util.List;

import com.bookshopping.dao.provider.inter.AbstractTbCityProvider;
import com.bookshopping.domain.TbCity;
import com.bookshopping.domain.TbTown;
import com.bookshopping.exception.CityNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbCityProvider implements AbstractTbCityProvider {

	@Override
	public TbCity getCityByCityId(int cityId) throws CityNotFoundException {
		return (TbCity) HibernateUtil.get(TbCity.class, cityId);
    }

	@Override
    public String getCityNameByCityId(int cityId) {
	    // TODO Auto-generated method stub
	    return null;
    }

	@Override
    public List<TbTown> getTownListByCityId(int cityId) {
	    List<TbTown> townList = new ArrayList<TbTown>(getCityByCityId(cityId).getTbTowns());
	    return townList;
    }
}
