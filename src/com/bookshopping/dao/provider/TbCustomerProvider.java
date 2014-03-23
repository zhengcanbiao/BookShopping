package com.bookshopping.dao.provider;

import java.util.ArrayList;
import java.util.List;

import com.bookshopping.dao.provider.inter.AbstractTbCustomerProvider;
import com.bookshopping.domain.TbCart;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbFavorite;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbCustomerProvider implements AbstractTbCustomerProvider {

	@Override
	public void addCustomer(TbCustomer customer) {
		HibernateUtil.add(customer);
	}

	@Override
	public void deleteCustomer(TbCustomer customer) {
		HibernateUtil.delete(customer);
	}

	@Override
	public void updateCustomer(TbCustomer customer) {
		HibernateUtil.update(customer);
	}

	@Override
	public TbCustomer getCustomerByCustomerName(String customerName) throws CustomerNotFoundException {
		try {
			TbCustomer customer = (TbCustomer) HibernateUtil.get(TbCustomer.class, customerName);
			if (customer == null) {
				throw new CustomerNotFoundException();
			} else {
				return customer;
			}
		} catch(IllegalArgumentException ex) {
			ex.printStackTrace();
			throw new CustomerNotFoundException();
		}
	}

	@Override
	public List<TbCart> getCartListByCustomerName(String customerName) throws CustomerNotFoundException {
		TbCustomer customer = getCustomerByCustomerName(customerName);
		List<TbCart> cartList = new ArrayList<TbCart> (customer.getTbCarts());
		return cartList;
	}

	@Override
	public List<TbFavorite> getFavoriteListByCustomerName(String customerName) {
		TbCustomer customer = getCustomerByCustomerName(customerName);
		List<TbFavorite> favoriteList = new ArrayList<TbFavorite> (customer.getTbFavorites());
		return favoriteList;
	}

	@Override
    public TbCustomer getCustomerByNickName(String nickName) {
		TbCustomer customer = (TbCustomer) HibernateUtil.executeQueryForUniqueResult("from TbCustomer where nickName=?", new Object[] {nickName});
	    System.out.println(customer);
		if (customer == null) {
	    	throw new CustomerNotFoundException();
	    } else {
	    	return customer;
	    }
		
	   
    }

	@SuppressWarnings("unchecked")
	public List<TbCustomer> getCustomerList() {
		List<TbCustomer> list = HibernateUtil.executeQueryForMultiResults("from TbCustomer", null);
		if (list == null) {
			throw new CustomerNotFoundException();
		} else {
			return list;
		}
	}

	@SuppressWarnings("unchecked")
	public List<TbCustomer> getCustomerAscListByPoint() {
		List<TbCustomer> list = HibernateUtil.executeQueryForMultiResults("from TbCustomer customer order by customer.points asc", null);
		if (list == null) {
			throw new CustomerNotFoundException();
		} else {
			return list;
		}
	}
}
