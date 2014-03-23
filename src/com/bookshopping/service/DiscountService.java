package com.bookshopping.service;

import java.util.List;

import com.bookshopping.dao.provider.TbDiscountProvider;
import com.bookshopping.domain.TbDiscount;
import com.bookshopping.exception.DiscountNotFoundException;
import com.bookshopping.utils.SpringUtil;

public class DiscountService {
	private DiscountService() {
	}
	
	public static List<TbDiscount> getDiscountList() {
		return getTbDiscountProvider().getDiscountList();
	}
	
	public static int getDiscountLevelByPoints(int points) {
		try {
			List<TbDiscount> list = getDiscountList();
			int i = -1;
			for (TbDiscount discount : list) {
				if (discount.getDiscountPoints() > points) {
					break;
				}
				i++;
			}
		    return i;
		} catch(DiscountNotFoundException ex) {
			return 0;
		}
	}
	
	public static double getDiscountRateByDiscountLevel(int discountLevel) {
		try {
			return getDiscountList().get(discountLevel).getDiscountRate() / 100.0;
		} catch(DiscountNotFoundException ex) {
			return 1.0;
		}
	}
	
	public static TbDiscountProvider getTbDiscountProvider() {
		return (TbDiscountProvider) SpringUtil.getBeanById("tbDiscountProvider");
	}
}
