package com.bookshopping.dao.provider;

import com.bookshopping.dao.provider.inter.AbstractTbTownProvider;
import com.bookshopping.domain.TbTown;
import com.bookshopping.exception.TownNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbTownProvider implements AbstractTbTownProvider {
	@Override
	public TbTown getTownByTownId(int townId) throws TownNotFoundException {
		TbTown town = (TbTown) HibernateUtil.get(TbTown.class, townId);
		if (town == null) {
			throw new TownNotFoundException();
		} else {
			return town;
		}
    }

	@Override
    public String getTownNameByTownId(int townId) {
		return getTownByTownId(townId).getTownName();
    }

}
