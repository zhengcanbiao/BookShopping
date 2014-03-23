package com.bookshopping.service.comparator;

import java.util.Comparator;

import com.bookshopping.domain.TbBooks;

public class BooksIdComparator implements Comparator<TbBooks> {
	
	public int compare(TbBooks c1, TbBooks c2) {
		return c1.getBooksId() - c2.getBooksId();
	}

}
