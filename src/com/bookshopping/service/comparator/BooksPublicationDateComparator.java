package com.bookshopping.service.comparator;

import java.util.Comparator;

import com.bookshopping.domain.TbBooks;

public class BooksPublicationDateComparator implements Comparator<TbBooks> {

	private boolean isAsc;

	public BooksPublicationDateComparator(boolean isAsc) {
		this.isAsc = isAsc;
	}

	public int compare(TbBooks c1, TbBooks c2) {
		if (isAsc) {
			return c1.getPublicationDate().compareTo(c2.getPublicationDate());
		} else {
			return c2.getPublicationDate().compareTo(c1.getPublicationDate());
		}
	}

	

}
