package com.bookshopping.service;

import java.util.List;

import com.bookshopping.dao.provider.TbCityProvider;
import com.bookshopping.domain.TbCity;
import com.bookshopping.domain.TbTown;
import com.bookshopping.utils.SpringUtil;

public class CityService {
	private CityService() {
	}
	
	public static List<TbCity> getCityListByProvinceId(int provinceId) {
		List<TbCity> list = ProvinceService.getCityListByProvinceId(provinceId);
		return list;
	}
	
	public static String generateJsonForCityList(List<TbCity> cityList) {
		if (cityList == null) {
			throw new NullPointerException();
		}
		if (cityList.size() == 0) {
			return "[]";
		}
		StringBuffer result = new StringBuffer("");
		for (TbCity city : cityList) {
			result.append(",{");
			result.append("\"cityId\":" + city.getCityId() + ",");
			result.append("\"cityName\":\"" + city.getCityName() + "\"");
			result.append("}");
		}
		return "[" + result.substring(1) + "]";
	}
	
	public static TbCityProvider getTbCityProvider() {
		return (TbCityProvider) SpringUtil.getBeanById("tbCityProvider");
	}

	public static TbCity getCityByCityId(int cityId) {
		return getTbCityProvider().getCityByCityId(cityId);
    }

	public static List<TbTown> getTownListByCityId(int cityId) {
		return getTbCityProvider().getTownListByCityId(cityId);
    }
}
