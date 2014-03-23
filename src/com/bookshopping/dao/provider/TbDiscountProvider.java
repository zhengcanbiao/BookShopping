package com.bookshopping.dao.provider;

import java.util.List;

import com.bookshopping.dao.provider.inter.AbstractTbDiscountProvider;
import com.bookshopping.domain.TbDiscount;
import com.bookshopping.exception.DiscountNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbDiscountProvider implements AbstractTbDiscountProvider{
	
	@Override
	public void addDiscount(TbDiscount discount) {
		HibernateUtil.add(discount);
	}
	
	@Override
	public void deleteDiscount(TbDiscount discount) {
		HibernateUtil.delete(discount);
	}
	
	@Override
	public void updateDiscount(TbDiscount discount) {
		HibernateUtil.update(discount);
	}
	
	@Override
	public TbDiscount getDiscountByDiscountPoints(Integer discountPoints) throws DiscountNotFoundException {
		TbDiscount discount = (TbDiscount) HibernateUtil.get(TbDiscount.class, discountPoints);
		if (discount == null) {
			throw new DiscountNotFoundException();
		} else {
			return discount;
		}
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<TbDiscount> getDiscountList() throws DiscountNotFoundException {
		List<TbDiscount> list = HibernateUtil.executeQueryForMultiResults("from TbDiscount order by ? asc", new Object[]{"discountPoint"});
		if (list == null || list.isEmpty()) {
			throw new DiscountNotFoundException();
		} else {
			return list;
		}
	}
	
}
