package com.bookshopping.service.comparator;

import java.util.Comparator;

import org.hibernate.Hibernate;

import com.bookshopping.domain.TbOrder;

public class OrderCustomerNameComparator implements Comparator<TbOrder> {
	
	public int compare(TbOrder c1, TbOrder c2) {
		Hibernate.initialize(c1.getTbCustomer());
		Hibernate.initialize(c2.getTbCustomer());
	    return c1.getTbCustomer().getCustomerName().compareTo(c2.getTbCustomer().getCustomerName());
	}

}
