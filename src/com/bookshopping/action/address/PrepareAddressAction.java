package com.bookshopping.action.address;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.bookshopping.domain.TbAddress;
import com.bookshopping.domain.TbProvince;
import com.bookshopping.service.AddressService;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.ProvinceService;
import com.opensymphony.xwork2.ActionSupport;

public class PrepareAddressAction extends ActionSupport implements ServletRequestAware {

	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;
    private HttpServletRequest request;
    
    @Override
    public String execute() throws Exception {
    	List<TbAddress> addressList = AddressService.getAddressListByCustomerName(CustomerService.getCurrentCustomerName());
    	List<TbProvince> provinceList = ProvinceService.getProvinceList();
    	AddressService.initializeAddressList(addressList);
    	request.setAttribute("addressList", addressList);
    	request.setAttribute("provinceList", provinceList);
    	return SUCCESS;
    }

	@Override
    public void setServletRequest(HttpServletRequest request) {
	    this.request = request;
    }
    
}
