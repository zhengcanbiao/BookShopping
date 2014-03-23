package com.bookshopping.service;

import java.util.List;

import com.bookshopping.dao.provider.TbProvinceProvider;
import com.bookshopping.domain.TbCity;
import com.bookshopping.domain.TbProvince;
import com.bookshopping.utils.SpringUtil;

public class ProvinceService {
	private ProvinceService() {
	}
	
	public static List<TbProvince> getProvinceList() {
		return getTbProvinceProvider().getProvinceList();
	}
	
	public static TbProvinceProvider getTbProvinceProvider() {
		return (TbProvinceProvider) SpringUtil.getBeanById("tbProvinceProvider");
	}

	public static TbProvince getProvinceByProvinceId(int provinceId) {
		return getTbProvinceProvider().getProvinceByProvinceId(provinceId);
    }

	public static List<TbCity> getCityListByProvinceId(int provinceId) {
		return getTbProvinceProvider().getCityListByProvinceId(provinceId);
    }

	public static String generateJsonForProvinceList(
            List<TbProvince> provinceList) {
		if (provinceList == null) {
			throw new NullPointerException();
		}
		StringBuffer result = new StringBuffer("");
		for (TbProvince province : provinceList) {
			result.append(",{");
			result.append("\"provinceId\":" + province.getProvinceId() + ",");
			result.append("\"provinceName\":\"" + province.getProvinceName() + "\"");
			result.append("}");
		}
		return "[" + result.substring(1) + "]";
    }
}
