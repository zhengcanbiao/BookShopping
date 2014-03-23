package com.bookshopping.service;

import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.dao.provider.TbAdminProvider;
import com.bookshopping.domain.TbAdmin;
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
		return (String) session.get("currentAdminName");
	}
	
	public static void clearSession() {
		session.clear();
	}
	
}
