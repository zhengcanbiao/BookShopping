package com.bookshopping.service.comparator;

import java.util.Comparator;

import com.bookshopping.domain.TbCustomer;

public class CustomerNickNameComparator implements Comparator<TbCustomer> {
	
	public int compare(TbCustomer c1, TbCustomer c2) {
		return c1.getNickName().compareTo(c2.getNickName());
	}

}
