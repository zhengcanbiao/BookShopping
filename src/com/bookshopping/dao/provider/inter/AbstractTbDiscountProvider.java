package com.bookshopping.dao.provider.inter;

import java.util.List;

import com.bookshopping.domain.TbDiscount;
import com.bookshopping.exception.DiscountNotFoundException;

public interface AbstractTbDiscountProvider {
	public void addDiscount(TbDiscount discount);
	public void deleteDiscount(TbDiscount discount);
	public void updateDiscount(TbDiscount discount);
	public TbDiscount getDiscountByDiscountPoints(Integer discountPoints)throws DiscountNotFoundException;
	public List<TbDiscount> getDiscountList() throws DiscountNotFoundException;
}
