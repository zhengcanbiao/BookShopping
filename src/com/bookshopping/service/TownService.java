package com.bookshopping.service;

import java.util.List;

import com.bookshopping.dao.provider.TbTownProvider;
import com.bookshopping.domain.TbTown;
import com.bookshopping.utils.SpringUtil;

public class TownService {
	private TownService() {
	}
	
	public static TbTown getTownByTownId(int townId) {
		return getTbTownProvider().getTownByTownId(townId);
	}
	
	public static List<TbTown> getTownsByCityId(int cityId) {
		List<TbTown> list = CityService.getTownListByCityId(cityId);
		return list;
	}
	
	public static String generateJsonForTownList(List<TbTown> townList) {
		if (townList == null) {
			throw new NullPointerException();
		}
		StringBuffer result = new StringBuffer("");
		for (TbTown city : townList) {
			result.append(",{");
			result.append("\"townId\":" + city.getTownId() + ",");
			result.append("\"townName\":\"" + city.getTownName() + "\"");
			result.append("}");
		}
		return "[" + result.substring(1) + "]";
	}
	
	public static TbTownProvider getTbTownProvider() {
		return (TbTownProvider) SpringUtil.getBeanById("tbTownProvider");
	}
}
