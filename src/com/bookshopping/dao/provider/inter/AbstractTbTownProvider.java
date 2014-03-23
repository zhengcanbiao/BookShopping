package com.bookshopping.dao.provider.inter;

import com.bookshopping.domain.TbTown;

public interface AbstractTbTownProvider {
	public TbTown getTownByTownId(int townId);
	public String getTownNameByTownId(int townId);
}
