package com.bookshopping.dao.provider.inter;

import java.util.List;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbComment;
import com.bookshopping.exception.BooksNotFoundException;

public interface AbstractTbBooksProvider {
	public void addBooks(TbBooks clothes);
	public void updateBooks(TbBooks clothes);
	public TbBooks getBooksByBooksId(int clothesId);
	public List<TbComment> getCommentListByBooksId(int clothesId);
	public List<TbComment> getCommentListByBooksId(Integer clothesId) throws BooksNotFoundException;
	List<TbBooks> getBooksList() throws BooksNotFoundException;
}
