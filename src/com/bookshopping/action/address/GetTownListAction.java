package com.bookshopping.action.address;

import com.bookshopping.service.TownService;
import com.opensymphony.xwork2.ActionSupport;

public class GetTownListAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    private String result;
    private String cityId;
	
	@Override
	public String execute() throws Exception {
		result = TownService.generateJsonForTownList(TownService.getTownsByCityId(Integer.parseInt(cityId)));
		return SUCCESS;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	
}
