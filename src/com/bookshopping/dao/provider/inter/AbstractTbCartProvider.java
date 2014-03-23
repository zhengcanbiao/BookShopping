package com.bookshopping.dao.provider.inter;

import com.bookshopping.domain.TbCart;
import com.bookshopping.exception.CartNotFoundException;

public interface AbstractTbCartProvider {
	public void addCart(TbCart cart);
	public void deleteCart(TbCart cart);
	public void updateCart(TbCart cart);
	public TbCart getCartByCartId(Integer cartId) throws CartNotFoundException;
}
