package com.bookshopping.service;

import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.dao.provider.TbAdminProvider;
import com.bookshopping.domain.TbAdmin;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.exception.AdminNotFoundException;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.utils.SHAEncypherUtil;
import com.bookshopping.utils.SpringUtil;

public class AdminService {
	
	private static Map<String, Object> session;
	
	private AdminService(){
	}
	
	public static TbAdminProvider getTbAdminProvider() {
		return (TbAdminProvider) SpringUtil.getBeanById("tbAdminProvider");
	}
	
	public static boolean login(String adminName,String password){
		TbAdmin admin = getTbAdminProvider().getAdminByAdminName(adminName);
		if(SHAEncypherUtil.encryptSHA(password).equals(admin.getPassword())) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public static boolean changePsw(String new_password){
		TbAdmin admin = getTbAdminProvider().getAdminByAdminName(getCurrentAdminName());
		admin.setPassword(SHAEncypherUtil.encryptSHA(new_password));
		getTbAdminProvider().updateAdmin(admin);
		return true;
		
	}
	private static void initSession() {
		session = ServletActionContext.getContext().getSession();
	}
	
	public static void putAdminIntoSession(String adminName) {
		initSession();
		session.put("currentAdminName", adminName);
	}
	
	public static String getCurrentAdminName() {
		initSession();
		String adminName =  (String)session.get("currentAdminName");
		if (adminName == null) {
			throw new AdminNotFoundException();
		} else {
			return adminName;
		}
	}
	
	public static void clearSession() {
		session.clear();
	}
	
	public static boolean validateAdmin(String adminName, String password) {
		if (adminName == null || adminName.trim().equals("")
				|| password == null || password.trim().equals("")) {
			return false;
		}
		try { 
	        TbAdmin admin = getTbAdminProvider().getAdminByAdminName(adminName);
	        if (encodePassword(password).equals(admin.getPassword())) {
	        	return true;
	        } else {
	        	return false;
	        }
        } catch (CustomerNotFoundException e) {
	        e.printStackTrace();
	        return false;
        }
	}
	
	private static String encodePassword(String password) {
		return SHAEncypherUtil.encryptSHA(password);
	}
}
