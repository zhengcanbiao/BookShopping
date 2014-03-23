package com.bookshopping.service.comparator;

import java.util.Comparator;

import com.bookshopping.domain.TbBooks;

public class BooksSalesComparator implements Comparator<TbBooks> {
	
	private boolean isAsc ;
	
	public BooksSalesComparator(boolean isAsc) {
		this.isAsc = isAsc;
	}
	
	public int compare(TbBooks c1, TbBooks c2) {
		if(isAsc) {
			return c1.getSales() - c2.getSales();
		} else {
			return c2.getSales() - c1.getSales();
		}
	}

}
