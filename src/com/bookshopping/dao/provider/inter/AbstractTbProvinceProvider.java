package com.bookshopping.dao.provider.inter;

import java.util.List;

import com.bookshopping.domain.TbCity;
import com.bookshopping.domain.TbProvince;

public interface AbstractTbProvinceProvider {
	public String getProvinceNameByProvinceId(int provinceId);
	public List<TbCity> getCityListByProvinceId(int provinceId);
	public TbProvince getProvinceByProvinceId(int provinceId);
	public List<TbProvince> getProvinceList();
}
