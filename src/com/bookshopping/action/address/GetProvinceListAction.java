package com.bookshopping.action.address;

import com.bookshopping.service.ProvinceService;
import com.opensymphony.xwork2.ActionSupport;

public class GetProvinceListAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String result;
	
	@Override
	public String execute() throws Exception {
		result = ProvinceService.generateJsonForProvinceList(ProvinceService.getProvinceList());
	    return super.execute();
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	
}
