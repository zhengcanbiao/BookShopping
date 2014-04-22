package com.bookshopping.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.dao.provider.TbCustomerProvider;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.exception.CookieNotExistException;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.exception.NoActiveCustomerException;
import com.bookshopping.utils.CookieUtil;
import com.bookshopping.utils.SHAEncypherUtil;
import com.bookshopping.utils.SpringUtil;
import com.bookshopping.utils.UUIDUtil;

public class CustomerService {
	private static Map<String, Object> session;
	final private static Pattern emailPattern;
	private CustomerService() {
	}
	
	public static boolean isOrderBelongToCustomer(TbOrder order, String customerName) {
		TbCustomer customer = getCustomerByCustomerName(customerName);
		return customer.getTbOrders().contains(order);
	}
	
	public static boolean isCustomerNameExist(String customerName) {
		try {
			getTbCustomerProvider().getCustomerByCustomerName(customerName);
	        return true;
        } catch (CustomerNotFoundException e) {
	        e.printStackTrace();
	        return false;
        }
	}
	
	public static boolean isNickNameExist(String nickName) {
		try {
			getTbCustomerProvider().getCustomerByNickName(nickName);
			return true;
		} catch (CustomerNotFoundException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static boolean validateCustomerNameFormat(String customerName) {
		Matcher matcher = emailPattern.matcher(customerName);
		boolean flag = matcher.find();
		return flag;
	}
	
	public static boolean validateCustomer(String customerName, String password) {
		if (customerName == null || customerName.trim().equals("")
				|| password == null || password.trim().equals("")) {
			return false;
		}
		try {
	        TbCustomer customer = getTbCustomerProvider().getCustomerByCustomerName(customerName);
	        if (encodePassword(password).equals(customer.getPassword())) {
	        	return true;
	        } else {
	        	return false;
	        }
        } catch (CustomerNotFoundException e) {
	        e.printStackTrace();
	        return false;
        }
	}
	
	public static void addCustomerToCookie(String customerName, String password) {
		Map<String, String> map = new HashMap<String, String>(0);
		map.put("customerName", customerName);
		map.put("password", password);
		List<Map<String, String>> attributes = new ArrayList<Map<String, String>>(0);
		attributes.add(map);
		CookieUtil.addCookie("bookshoppingUser", attributes);
	}
	
	public static void loadCustomerFromCookieToSession() throws CookieNotExistException, CustomerNotFoundException {
		initSession();
		try {
		    List<Map<String, String>> values = CookieUtil.getCookieValues("bookshoppingUser");
		    if(values==null)
		    	System.out.println("cookies null");
		    else{
		    String customerName = values.get(0).get("customerName");
		    String password = values.get(0).get("password");
		    if (CustomerService.validateCustomer(customerName, password)) {
		    	putCustomerIntoSession(customerName);
		    } 
		    }
		} catch (CustomerNotFoundException ex) {
			throw new CookieNotExistException();
		}
	}
	
	public static void putCustomerIntoSession(String customerName) throws CustomerNotFoundException {
		initSession();
		TbCustomer customer = getTbCustomerProvider().getCustomerByCustomerName(customerName);
		session.put("currentNickName", customer.getNickName());
		session.put("currentCustomerName", customer.getCustomerName());
	}
	
	public static TbCustomer getCurrentCustomer() throws CustomerNotFoundException {
		initSession();
		System.out.println("当前用户名："+(String) session.get("currentCustomerName"));
		return getCustomerByCustomerName((String) session.get("currentCustomerName"));
	}
	
	public static String getCurrentCustomerName() {
		initSession();
		String customerName = (String) session.get("currentCustomerName");
		if (customerName == null) {
			throw new NoActiveCustomerException();
		} else {
			return customerName;
		}
	}
	
	public static String getCurrentNickName() {
		initSession();
		String nickName = (String) session.get("currentNickName");
		if (nickName == null) {
			throw new NoActiveCustomerException();
		} else {
			return nickName;
		}
	}
	
	public static void clearSession() {
		session.clear();
	}
	
	public static void clearCookie() {
		CookieUtil.removeCookie("bookshoppingUser");
	}
	
	private static void initSession() {
		session = ServletActionContext.getContext().getSession();
	}
	
	public static String setRandomPassword(String customerName) throws CustomerNotFoundException, AddressException, MessagingException {
		TbCustomer customer = getCustomerByCustomerName(customerName);
		String tempPsw = UUIDUtil.getRandomString();
		customer.setPassword(SHAEncypherUtil.encryptSHA(tempPsw));
		getTbCustomerProvider().updateCustomer(customer);
		return tempPsw;
	}
	
	public static void setPassword(String password) throws Exception {
    	TbCustomer customer = CustomerService.getCurrentCustomer();
    	customer.setPassword(SHAEncypherUtil.encryptSHA(password));
    	getTbCustomerProvider().updateCustomer(customer);
	}
	
	public static void modifyPersonalInfo(String nickName, Integer sex) throws Exception {
    	TbCustomer currentCustomer = CustomerService.getCurrentCustomer();
    	currentCustomer.setNickName(nickName);
    	currentCustomer.setSex(sex);
    	getTbCustomerProvider().updateCustomer(currentCustomer);
    	CustomerService.putCustomerIntoSession(currentCustomer.getCustomerName());
	}
	
	public static void addCustomer(String customerName, String nickName, String password) throws Exception {
		System.out.println(customerName+nickName+password);
		getTbCustomerProvider().addCustomer(new TbCustomer(customerName, nickName, encodePassword(password)));
	}
	
	public static TbCustomerProvider getTbCustomerProvider() {
		return (TbCustomerProvider) SpringUtil.getBeanById("tbCustomerProvider");
	}
	
	public static void freezeCustomerByCustomerName(String customerName) throws CustomerNotFoundException {
		TbCustomer customer = getCustomerByCustomerName(customerName);
		customer.setValid(false);
		getTbCustomerProvider().updateCustomer(customer);
	}
	
	public static TbCustomer getCustomerByCustomerName(String customerName) throws CustomerNotFoundException {
		return getTbCustomerProvider().getCustomerByCustomerName(customerName);
    }

	private static String encodePassword(String password) {
		return SHAEncypherUtil.encryptSHA(password);
	}
	
	static {
		emailPattern = Pattern.compile("[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?");
	}

	public static void updateCustomer(TbCustomer customer) {
		getTbCustomerProvider().updateCustomer(customer);
    }

	public static boolean isCustomerValid(String customerName) {
		return getCustomerByCustomerName(customerName).getValid();
    }

}
