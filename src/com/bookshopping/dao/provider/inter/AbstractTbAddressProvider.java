package com.bookshopping.dao.provider.inter;

import java.util.List;

import com.bookshopping.domain.TbAddress;

public interface AbstractTbAddressProvider {
	public void addAddress(TbAddress address);
	public void deleteAddress(TbAddress address);
	public void updateAddress(TbAddress address);
	public TbAddress getAddressByAddressId(int addressId);
	public TbAddress getDefaultAddressByCustomerName(String customerName);
	public List<TbAddress> getAddressListByCustomerName(String customerName);
}
