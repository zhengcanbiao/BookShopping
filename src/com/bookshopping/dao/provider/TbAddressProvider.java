package com.bookshopping.dao.provider;

import java.util.List;

import com.bookshopping.dao.provider.inter.AbstractTbAddressProvider;
import com.bookshopping.domain.TbAddress;
import com.bookshopping.exception.AddressNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbAddressProvider implements AbstractTbAddressProvider {
	
	@Override
	public TbAddress getAddressByAddressId(int addressId) throws AddressNotFoundException {
		TbAddress address = (TbAddress) HibernateUtil.executeQueryForUniqueResult("from TbAddress where addressId=?", new Object[] { addressId });
		if (address == null) {
			throw new AddressNotFoundException();
		} else {
			return address;
		}
	}
	
	@Override
	public TbAddress getDefaultAddressByCustomerName(String customerName) throws AddressNotFoundException {
		TbAddress address = (TbAddress) HibernateUtil.executeQueryForUniqueResult("from TbAddress where customerName=? and isDefault=?", new Object[] {customerName, true });
		if (address == null) {
			throw new AddressNotFoundException();
		} else {
			return address;
		}
	}
	
	@Override
	public void addAddress(TbAddress address) {
		HibernateUtil.add(address);
	}

	@Override
	public void deleteAddress(TbAddress address)
	        throws AddressNotFoundException {
		HibernateUtil.delete(address);
	}

	@Override
	public void updateAddress(TbAddress address) {
		HibernateUtil.update(address);
	}
	
	@SuppressWarnings("unchecked")
	@Override
    public List<TbAddress> getAddressListByCustomerName(String customerName) {
		return (List<TbAddress>) HibernateUtil.executeQueryForMultiResults("from TbAddress where customerName=?", new Object[]{customerName});
	}
}
