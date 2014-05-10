package com.bookshopping.service;

import java.text.Collator;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import com.bookshopping.dao.provider.TbBooksProvider;
import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCategory;
import com.bookshopping.exception.BooksNotFoundException;
import com.bookshopping.service.comparator.BooksNameComparator;
import com.bookshopping.service.comparator.BooksPriceComparator;
import com.bookshopping.service.comparator.BooksPublicationDateComparator;
import com.bookshopping.service.comparator.BooksSalesComparator;
import com.bookshopping.utils.SearchUtil;
import com.bookshopping.utils.SpringUtil;

public class BooksService {
	public static final int DEFAULT_ORDER = 0;
	public static final int ORDER_BY_SALES_ASC = 1;
	public static final int ORDER_BY_SALES_DESC = 2;
	public static final int ORDER_BY_PRICE_ASC = 3;
	public static final int ORDER_BY_PRICE_DESC = 4;
	public static final int ORDER_BY_NAME = 5; 
	public static final int ORDER_BY_PUBLICATION_DATE_ASC = 6; 
	public static final int ORDER_BY_PUBLICATION_DATE_DESC = 7; 
	private static Map<String, Object> application;
	private BooksService() {
	}
	
	public static TbBooks getBooksByBooksId(int booksId) throws BooksNotFoundException {
		return getTbBooksProvider().getBooksByBooksId(booksId);
	}
	
	public static TbBooksProvider getTbBooksProvider() {
		return (TbBooksProvider) SpringUtil.getBeanById("tbBooksProvider");
	}
	
	public static List<TbBooks> getBooksListByCategoryId(int categoryId) {
		List<TbCategory> categoryList = CategoryService.getSubcategoryListByCategoryId(categoryId);
		categoryList.add(CategoryService.getCategoryByCategoryId(categoryId));
		return getTbBooksProvider().getBooksListByCategoryList(categoryList);
	}
	
	public static List<TbBooks> getValidBooksListByCategoryId(int categoryId) {
		List<TbCategory> categoryList = CategoryService.getSubcategoryListByCategoryId(categoryId);
		categoryList.add(CategoryService.getCategoryByCategoryId(categoryId));
		return getTbBooksProvider().getValidBooksListByCategoryList(categoryList);
	}

//	public static List<TbBooksdetail> getBooksDetailListByBooksId(int booksId) {
//		return getTbBooksProvider().getBooksDetailListByBooksId(booksId);
//    }
		
	@SuppressWarnings("unchecked")
	public static List<TbBooks> searchBooks(String keyword, int orderIndex) {
		List<TbCategory> Categories = CategoryService.getCategoryList();
	
		for(TbCategory category: Categories){
			if(keyword.equals(category.getCategoryName())){
				List<TbBooks> list = BooksService.getBooksListByCategoryId(category.getCategoryId());
				switch (orderIndex) {
				case ORDER_BY_NAME:
					sortByBooksName(list);
					break;
				case ORDER_BY_PRICE_ASC:
					sortByBooksPriceAsc(list);
					break;
				case ORDER_BY_PRICE_DESC:
					sortByBooksPriceDesc(list);
					break;
				case ORDER_BY_SALES_ASC:
					sortByBooksSalesAsc(list);
					break;
				case ORDER_BY_SALES_DESC:
					sortByBooksSalesDesc(list);
					break;
				case ORDER_BY_PUBLICATION_DATE_ASC:
					sortByBooksSalesDesc(list);
					break;
				case ORDER_BY_PUBLICATION_DATE_DESC:
					sortByBooksSalesDesc(list);
					break;
				default:
					break;
				}
					return list;
			}
		}

		List<TbBooks> list = SearchUtil.searchForKeyword(keyword.split("\\s+"), "TbBooks",
				new String[]{"BookName", "Publisher", "Author", "BooksDescription","PublicationDate"});
		switch (orderIndex) {
		case ORDER_BY_NAME:
			sortByBooksName(list);
			break;
		case ORDER_BY_PRICE_ASC:
			sortByBooksPriceAsc(list);
			break;
		case ORDER_BY_PRICE_DESC:
			sortByBooksPriceDesc(list);
			break;
		case ORDER_BY_SALES_ASC:
			sortByBooksSalesAsc(list);
			break;
		case ORDER_BY_SALES_DESC:
			sortByBooksSalesDesc(list);
			break;
		case ORDER_BY_PUBLICATION_DATE_ASC:
			sortByBooksSalesDesc(list);
			break;
		case ORDER_BY_PUBLICATION_DATE_DESC:
			sortByBooksSalesDesc(list);
			break;
		default:
			break;
		}
		return list;
	}
	
	public static List<TbBooks> sortByBooksName(List<TbBooks> list) {
		// Comparator comparator = Collator.getInstance(java.util.Locale.CHINA);
//		  String[] arrStrings = { "乔峰", "郭靖", "杨过", "张无忌","韦小宝" };
//		  // 使根据指定比较器产生的顺序对指定对象数组进行排序。
//		  Arrays.sort(arrStrings, comparator);

		
		Collections.sort(list, new BooksNameComparator());
		return list;
	} 
	
	public static List<TbBooks> sortByBooksSalesDesc(List<TbBooks> list) {
		Collections.sort(list, new BooksSalesComparator(false));
		return list;
	}
	
	public static List<TbBooks> sortByBooksSalesAsc(List<TbBooks> list) {
		Collections.sort(list, new BooksSalesComparator(true));
		return list;
	}
	
	public static List<TbBooks> sortByBooksPriceDesc(List<TbBooks> list) {
		Collections.sort(list, new BooksPriceComparator(false));
		return list;
	}
	
	public static List<TbBooks> sortByBooksPriceAsc(List<TbBooks> list) {
		Collections.sort(list, new BooksPriceComparator(true));
		return list;
	}
	
	public static List<TbBooks> sortByBooksPublicationDateAsc(List<TbBooks> list) {
		Collections.sort(list, new BooksPublicationDateComparator(true));
		return list;
	}

	public static List<TbBooks> sortByBooksPublicationDateDesc(List<TbBooks> list) {
		Collections.sort(list, new BooksPublicationDateComparator(false));
		return list;
	}
	public static void updateBooks(TbBooks books) {
	    getTbBooksProvider().updateBooks(books);
    }
	
	public static TbBooks addBooks(int categoryId, String bookName, int price,
			int remainder, String author, String publisher,String publicationDate,String picUrl,String booksDescription) {
		TbBooks books = new TbBooks(CategoryService.getTbCategoryProvider().getCategoryByCategoryId(categoryId),
				bookName, price,picUrl);
		books.setAuthor(author);
		books.setBooksDescription(booksDescription);
		books.setPublicationDate(publicationDate);
		books.setPicUrl(picUrl);
		books.setPublisher(publisher);
		books.setRemainder(remainder);
		getTbBooksProvider().addBooks(books);
		return books;
	}
	
	public static List<TbBooks> getBooksList() throws BooksNotFoundException {
		return getTbBooksProvider().getBooksList();
	}
	
	public static void setBooksValidByBooksId(Integer booksId, Boolean isValid) throws BooksNotFoundException {
		TbBooks books = getBooksByBooksId(booksId);
		books.setValid(isValid);
		updateBooks(books);
	}
	
	@SuppressWarnings("unchecked")
	public static List<TbBooks> searchBooks(String keyword) {
		return SearchUtil.searchForKeyword(keyword.split("\\s+"), "TbBooks",
				new String[]{"BookName", "Publisher", "Author", "BooksDescription","PublicationDate"});
	}
}
