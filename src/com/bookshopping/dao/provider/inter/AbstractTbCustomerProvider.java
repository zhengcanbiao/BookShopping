package com.bookshopping.dao.provider.inter;

import java.util.List;

import com.bookshopping.domain.TbCart;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbFavorite;

public interface AbstractTbCustomerProvider {
	public void addCustomer(TbCustomer customer);
	public void deleteCustomer(TbCustomer customer);
	public void updateCustomer(TbCustomer customer);
	public TbCustomer getCustomerByCustomerName(String customerName);
	public TbCustomer getCustomerByNickName(String nickName);
	public List<TbCart> getCartListByCustomerName(String customerName);
	public List<TbFavorite> getFavoriteListByCustomerName(String customerName);
}
