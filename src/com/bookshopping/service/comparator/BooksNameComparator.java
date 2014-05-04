package com.bookshopping.service.comparator;

import java.text.RuleBasedCollator;
import java.util.Comparator;

import com.bookshopping.domain.TbBooks;

public class BooksNameComparator implements Comparator<TbBooks> {
	public int compare(TbBooks c1, TbBooks c2) {
	    return c1.getBookName().compareTo(c2.getBookName());
	}
	
	
//	 private  RuleBasedCollator  GB2312Collator =
//		        ChineseGB2312Collator.getFixedGB2312Collator();
//		    private  String  str1;
//		    
//		    /**
//		     * @param str1
//		     */
////		    public  ChineseGB2312Comparator(String  str1) {
////		        this .str1 = str1;
////		    }
//		    /**
//		     * 
//		     */
////		    public  ChineseGB2312Comparator() {
////		        this .str1="" ;
////		    }
//		    /**
//		     * @param str1
//		     * @param str2
//		     * @return an integer indicatint the comparison result
//		     * @see java.util.Comparator#compare(Object, Object)
//		     */
//		    public  int  compare(TbBooks c1, TbBooks c2) {
//		        return  GB2312Collator.compare(c1.getBookName(), c2.getBookName());
//		    }
//		    /**
//		     * @param str2
//		     * @return an integer indicatint the comparison result
//		     *  @see java.lang.Comparable#compareTo(Object)
//		     */
////		    public  int  compareTo(String  str2) {
////		        return  GB2312Collator.compare(str1, str2);
////		    }
}
