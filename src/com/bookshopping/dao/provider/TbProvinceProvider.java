package com.bookshopping.dao.provider;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.LazyInitializationException;
import org.hibernate.Session;

import com.bookshopping.dao.provider.inter.AbstractTbProvinceProvider;
import com.bookshopping.domain.TbCity;
import com.bookshopping.domain.TbProvince;
import com.bookshopping.utils.HibernateUtil;

public class TbProvinceProvider implements AbstractTbProvinceProvider {
	@SuppressWarnings("unchecked")
	@Override
    public List<TbProvince> getProvinceList() {
		List<TbProvince> provinces = (List<TbProvince>) HibernateUtil.executeQueryForMultiResults("from TbProvince", null);
		return provinces;
	}

	@Override
	public TbProvince getProvinceByProvinceId(int provinceId) {
	    return (TbProvince) HibernateUtil.get(TbProvince.class, provinceId);
    }

	@Override
    public String getProvinceNameByProvinceId(int provinceId) {
		return getProvinceByProvinceId(provinceId).getProvinceName();
    }

	@Override
    public List<TbCity> getCityListByProvinceId(int provinceId) {
		List<TbCity> cityList;
		try {
			cityList = new ArrayList<TbCity>(getProvinceByProvinceId(provinceId).getTbCities());
		} catch(LazyInitializationException ex) {
			Session session = HibernateUtil.getSessionFactory().getCurrentSession();
			cityList = new ArrayList<TbCity>(getProvinceByProvinceId(provinceId).getTbCities());
			session.close();
		}
		return cityList;
    }
}
