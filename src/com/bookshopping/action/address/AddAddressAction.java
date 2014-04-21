package com.bookshopping.action.address;

import com.bookshopping.service.AddressService;
import com.opensymphony.xwork2.ActionSupport;


public class AddAddressAction extends ActionSupport {
	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
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
		AddressService.addAddress(receiverName, phone, provinceId, cityId, townId, receiverAddress, postcode);
		result = "success";
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

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
}
