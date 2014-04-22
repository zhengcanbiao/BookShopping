package com.bookshopping.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bookshopping.dao.provider.TbCartProvider;
import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCart;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.exception.CartNotFoundException;
import com.bookshopping.exception.ClothesdetailNotFoundException;
import com.bookshopping.exception.CookieNotExistException;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.utils.CookieUtil;
import com.bookshopping.utils.SpringUtil;

public class CartService {
	
	private CartService() {
	}
	
	private static List<TbCart> getCartItemListFromCookie() {
		List<TbCart> list = new ArrayList<TbCart>(0);
		try {
			List<Map<String, String>> cartItemStr = CookieUtil.getCookieValues("cartItemList");
			for (Map<String, String> item : cartItemStr) {
				try {
					TbBooks books = (BooksService.getBooksByBooksId(Integer.parseInt(item.get("booksId"))));
					TbCart cart = new TbCart();
					cart.setCartId(Integer.parseInt(item.get("cartId")));
					cart.setTbBooks(books);
					cart.setBooksNumber(Integer.parseInt(item.get("booksNum")));
					list.add(cart);
				} catch (ClothesdetailNotFoundException ex) {
					ex.printStackTrace();
				}
			}
		} catch(CookieNotExistException ex) {
			ex.printStackTrace();
		}
		return list;
	}
	
	public static List<TbCart> getCartItemList() {
		try {
			TbCustomer customer = CustomerService.getCurrentCustomer();
			List<TbCart> cartListInCookie = getCartItemListFromCookie();
			for (TbCart cart : cartListInCookie) {
				addCart(cart.getTbBooks().getBooksId(), cart.getBooksNumber());
			}
			CookieUtil.removeCookie("cartItemList");
			List<TbCart> cartList = customer.getTbCarts();
			return cartList;
		} catch (CustomerNotFoundException ex) {
			ex.printStackTrace();
			return getCartItemListFromCookie();
		}
	}

	public static TbCartProvider getTbCartProvider() {
		return (TbCartProvider) (SpringUtil.getBeanById("tbCartProvider"));
	}
	
	private static boolean putCartToCookie(TbCart cart) {
		try {
			List<Map<String, String>> cartItemList = CookieUtil.getCookieValues("cartItemList");
			System.out.println(cartItemList);
			if(cartItemList!=null){
			for (Map<String, String> item : cartItemList) {
				if (((Integer)Integer.parseInt(item.get("booksId"))).equals(cart.getTbBooks().getBooksId())) {
					int booksNum = Integer.parseInt(item.get("booksNum")) + cart.getBooksNumber();
					return modifyBooksNumberInCookie(booksNum, Integer.parseInt(item.get("cartId")));
				}
			}
			}
		} catch(CookieNotExistException ex) {
			ex.printStackTrace();
		}
		List<Map<String, String>> list = new ArrayList<Map<String, String>>(0);
		Map<String, String> map = new HashMap<String, String>(0);
		map.put("cartId", cart.getCartId().toString());
		map.put("booksId", cart.getTbBooks().getBooksId().toString());
		map.put("booksNum", cart.getBooksNumber().toString());
		list.add(map);
		CookieUtil.appendCookieValue("cartItemList", list);
		return true;
	}

	public static boolean addCart(int booksId, int booksNumber) {
		TbBooks books = BooksService.getBooksByBooksId(booksId);
		if (booksNumber <= books.getRemainder()) {
			try {
				TbCustomer customer = CustomerService.getCurrentCustomer();
				List<TbCart> list = customer.getTbCarts();
				for (TbCart cart : list) {
					if (cart.getTbBooks().getBooksId().equals(booksId)) {
						 return modifyBooksNumberByCartId(booksNumber + cart.getBooksNumber(), cart.getCartId());
					}
				}
				getTbCartProvider().addCart(new TbCart(customer, books, booksNumber));
				BooksService.updateBooks(books);
				return true;
			} catch (CustomerNotFoundException ex) {
				TbCart cart = new TbCart();
				int cartId = (int) System.currentTimeMillis();
				cartId = (cartId > 0) ? -cartId : cartId;
				cart.setCartId(cartId);
				cart.setTbBooks(books);
				cart.setBooksNumber(booksNumber);
				putCartToCookie(cart);
				return true;
			}
		} else {
			return false;
		}
    }

	public static String generateJsonForCartList(List<TbCart> list) {
		if (list == null) {
			throw new NullPointerException();
		}
		if (list.isEmpty()) {
			return "[]";
		}
		StringBuffer result = new StringBuffer("");
		for (TbCart cart : list) {
			result.append(",{");
			result.append("\"picUrl\":\"" + cart.getTbBooks().getPicUrl() + "\",");
			result.append("\"booksId\":" + cart.getTbBooks().getBooksId() + ",");
			result.append("\"categoryId\":" + cart.getTbBooks().getTbCategory().getCategoryId() + ",");
			result.append("\"booksNumber\":" + cart.getBooksNumber() + ",");
			result.append("\"price\":" + (cart.getTbBooks().getPrice() / 100.0) + ",");
			result.append("\"bookName\":\"" + cart.getTbBooks().getBookName() + "\",");
			result.append("\"author\":\"" + cart.getTbBooks().getAuthor() + "\",");
			result.append("\"publisher\":\"" + cart.getTbBooks().getPublisher() + "\",");
			result.append("}");
		}
		return "[" + result.substring(1) + "]";
    }

	public static TbCart getCartByCartId(int cartId) {
		return getTbCartProvider().getCartByCartId(cartId);
    }

	public static void updateCart(TbCart cart) {
		getTbCartProvider().updateCart(cart);
    }

	public static boolean modifyBooksNumberByCartId(int booksNumber, int cartId) {
		try {
			TbCart cart = CartService.getCartByCartId(cartId);
			if (booksNumber > cart.getTbBooks().getRemainder()) {
				return false;
			} else {
				cart.setBooksNumber(booksNumber);
				CartService.updateCart(cart);
				return true;
			}
		} catch (CartNotFoundException ex) {
			ex.printStackTrace();
			return modifyBooksNumberInCookie(booksNumber, cartId);
		}
    }

	
	//判断数量的修改
	private static boolean modifyBooksNumberInCookie(int booksNumber,
            int cartId) {
		List<Map<String, String>> cartItemList = CookieUtil.getCookieValues("cartItemList");
		for (Map<String, String> map : cartItemList) {
			if (map.get("cartId").equals(String.valueOf(cartId))) {
				TbBooks books = BooksService.getBooksByBooksId(Integer.parseInt(map.get("booksId")));
				if (booksNumber > books.getRemainder()) {
					return false;
				} else {
					map.put("booksNum", String.valueOf(booksNumber));
					break;
				}
			}
		}
		CookieUtil.addCookie("cartItemList", cartItemList);
		return true;
    }

	public static void deleteCartByCartId(int cartId) {
		if (cartId > 0) {
			TbCart cart = getCartByCartId(cartId);
			getTbCartProvider().deleteCart(cart);
		} else {
			deleteCartFromCookie(cartId);
		}
	}

	private static void deleteCartFromCookie(int cartId) {
		List<Map<String, String>> cartItemList = CookieUtil.getCookieValues("cartItemList");
		for (Map<String, String> map : cartItemList) {
			if (map.get("cartId").equals(String.valueOf(cartId))) {
				cartItemList.remove(map);
				break;
			}
		}
		CookieUtil.addCookie("cartItemList", cartItemList);
    }

	public static void emptyCartByCustomerName(String customerName) {
		TbCustomer customer = CustomerService.getCustomerByCustomerName(customerName);
		List<TbCart> cartList = customer.getTbCarts();
		customer.setTbCarts(new ArrayList<TbCart>(0));
		deleteCartList(cartList);
    }

	public static void deleteCartList(List<TbCart> cartList) {
	    getTbCartProvider().deleteCartList(cartList);
    }
}
