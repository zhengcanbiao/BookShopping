package com.bookshopping.dao.provider;

import java.util.List;

import com.bookshopping.dao.provider.inter.AbstractTbCartProvider;
import com.bookshopping.domain.TbCart;
import com.bookshopping.exception.CartNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbCartProvider implements AbstractTbCartProvider{
	
	@Override
	public void addCart(TbCart cart) {
		HibernateUtil.add(cart);
	}
	
	@Override
	public void deleteCart(TbCart cart) {
		HibernateUtil.delete(cart);
	}
	
	@Override
	public void updateCart(TbCart cart) {
		HibernateUtil.update(cart);
	}
	
	@Override
	public TbCart getCartByCartId(Integer cartId) throws CartNotFoundException {
		TbCart cart = (TbCart) HibernateUtil.get(TbCart.class, cartId);
		if (cart == null) {
			throw new CartNotFoundException();
		} else {
			return cart;
		}
	}

	public void deleteCartList(List<TbCart> cartList) {
		for (TbCart cart : cartList) {
			this.deleteCart(cart);
		}
    }

}
