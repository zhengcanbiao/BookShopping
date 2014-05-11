package com.bookshopping.service.comparator;

import java.util.Comparator;

import com.bookshopping.domain.TbOrder;

public class OrderTimeComparator implements Comparator<TbOrder> {
	
	public int compare(TbOrder c1, TbOrder c2) {
	    return c1.getOrderId().compareTo(c2.getOrderId());
	}

}
