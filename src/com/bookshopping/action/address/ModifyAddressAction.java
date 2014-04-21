package com.bookshopping.action.address;

import com.bookshopping.domain.TbAddress;
import com.bookshopping.service.AddressService;
import com.bookshopping.service.CityService;
import com.bookshopping.service.ProvinceService;
import com.bookshopping.service.TownService;
import com.opensymphony.xwork2.ActionSupport;

public class ModifyAddressAction extends ActionSupport {
	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
    private int addressId;
	private String receiverName;
	private String phone;
	private Integer provinceId;
	private Integer cityId;
	private Integer townId;
	private String receiverAddress;
	private Integer postcode;
	private String result;
	
	@Override
	public String execute() throws Exception {
		TbAddress address = AddressService.getAddressByAddressId(addressId);
		address.setPhone(phone);
		address.setPostcode(postcode);
		address.setReceiverAddress(receiverAddress);
		address.setReceiverName(receiverName);
		address.setTbCity(CityService.getCityByCityId(cityId));
		address.setTbProvince(ProvinceService.getProvinceByProvinceId(provinceId));
		address.setTbTown(TownService.getTownByTownId(townId));
		AddressService.updateAddress(address);
		return SUCCESS;
	}

	public Integer getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(Integer provinceId) {
		this.provinceId = provinceId;
	}

	public Integer getCityId() {
		return cityId;
	}

	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getTownId() {
		return townId;
	}

	public void setTownId(Integer townId) {
		this.townId = townId;
	}

	public String getReceiverAddress() {
		return receiverAddress;
	}

	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}

	public Integer getPostcode() {
		return postcode;
	}

	public void setPostcode(Integer postcode) {
		this.postcode = postcode;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}
	
	public void setResult(String result) {
		this.result = result;
	}
	
	public String getResult() {
		return this.result;
	}
}
