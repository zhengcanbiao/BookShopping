package com.bookshopping.action.address;

import com.bookshopping.service.AddressService;
import com.opensymphony.xwork2.ActionSupport;

public class DeleteAddressAction extends ActionSupport {
	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
    private String result;
	private String addressId;
	
	public String execute() throws Exception {
		AddressService.deleteAddressByAddressId(Integer.parseInt(addressId));
		result = "success";
		return SUCCESS;
	}

	public String getAddressId() {
		return addressId;
	}

	public void setAddressId(String addressId) {
		this.addressId = addressId;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	
}
