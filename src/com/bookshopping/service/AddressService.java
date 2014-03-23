package com.bookshopping.service;

import java.util.List;

import org.hibernate.Hibernate;

import com.bookshopping.dao.provider.TbAddressProvider;
import com.bookshopping.domain.TbAddress;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.exception.AddressNotFoundException;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.exception.TownNotFoundException;
import com.bookshopping.utils.SpringUtil;

public class AddressService {
	private AddressService() {
	}
	
	public static List<TbAddress> getAddressListByCustomerName(String customerName) {
		List<TbAddress> addresses = getTbAddressProvider().getAddressListByCustomerName(customerName);
		return addresses;
	}
	
	public static void initializeAddressList(List<TbAddress> addressList) {
    	for (TbAddress address : addressList) {
    		initializeAddress(address);
    	}
	}
	
	public static void initializeAddress(TbAddress address) {
		Hibernate.initialize(address.getTbProvince());
		Hibernate.initialize(address.getTbCity());
		Hibernate.initialize(address.getTbTown());
	}
	
	public static void addAddress(String receiverName, String phone, int provinceId, int cityId, 
			int townId, String receiverAddress, int postcode) throws TownNotFoundException, CustomerNotFoundException {
		TbCustomer customer = CustomerService.getCurrentCustomer();
		TbAddress address = new TbAddress(customer, 
				ProvinceService.getProvinceByProvinceId(provinceId),
				CityService.getCityByCityId(cityId),
				TownService.getTownByTownId(townId),
				receiverName, receiverAddress, postcode,
				phone);
		if (customer.getTbAddresses() == null
				|| customer.getTbAddresses().size() == 0) {
			address.setIsDefault(true);
		}
		getTbAddressProvider().addAddress(address);
	}
	
	public static TbAddressProvider getTbAddressProvider() {
		return (TbAddressProvider) SpringUtil.getBeanById("tbAddressProvider");
	}
	
	public static String generateReceiverInfo(TbAddress address) {
		StringBuffer receiverInfo = new StringBuffer("");
		receiverInfo.append(address.getReceiverName() + ",");
		receiverInfo.append(address.getTbProvince().getProvinceName() + ",");
		receiverInfo.append(address.getTbCity().getCityName() + ",");
		receiverInfo.append(address.getTbTown().getTownName() + ",");
		receiverInfo.append(address.getReceiverAddress() + ",");
		receiverInfo.append(address.getPostcode() + ",");
		receiverInfo.append(address.getPhone());
		return receiverInfo.toString();
	}
	
	public static void setDefaultAddressByAddressId(Integer addressId)
	        throws AddressNotFoundException {
		TbAddressProvider tbAddressProvider = getTbAddressProvider();
		TbAddress newAddress = tbAddressProvider.getAddressByAddressId(addressId);
		String customerName = newAddress.getTbCustomer().getCustomerName();
		try {
			TbAddress oldAddress = getDefaultAddressByCustomerName(customerName);
			oldAddress.setIsDefault(false);
			tbAddressProvider.updateAddress(oldAddress);
		} catch(AddressNotFoundException ex) {
			ex.printStackTrace();
		}
		newAddress.setIsDefault(true);
		
		tbAddressProvider.updateAddress(newAddress);
	}
	
	public static TbAddress getDefaultAddressByCustomerName(String customerName) throws AddressNotFoundException {
		return getTbAddressProvider().getDefaultAddressByCustomerName(customerName);
	}
	
	public static void deleteAddressByAddressId(Integer addressId) throws AddressNotFoundException {
		TbAddressProvider tbAddressProvider = getTbAddressProvider();
		TbAddress address = tbAddressProvider.getAddressByAddressId(addressId);
		getTbAddressProvider().deleteAddress(address);
	}

	public static TbAddress getAddressByAddressId(int addressId) {
		return getTbAddressProvider().getAddressByAddressId(addressId);
    }

	public static void updateAddress(TbAddress address) {
		getTbAddressProvider().updateAddress(address);
    }
}
