package com.bookshopping.action.address;

import com.bookshopping.service.CityService;
import com.opensymphony.xwork2.ActionSupport;

public class GetCityListAction extends ActionSupport {

	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
    private String result;
    private String provinceId;
    
    public String getProvinceId() {
    	return provinceId;
    }
    
    public void setProvinceId(String provinceId) {
    	this.provinceId = provinceId;
    }
	
	@Override
	public String execute() throws Exception {
		result = CityService.generateJsonForCityList(CityService.getCityListByProvinceId(Integer.parseInt(provinceId)));
		return SUCCESS;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
}
