package com.bookshopping.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.bookshopping.exception.CookieNotExistException;

public class CookieUtil {
	private CookieUtil(){
	}
	
	public static void addCookie(String key, List<Map<String, String>> attributes) {
		Cookie cookie = new Cookie(key, JSONArray.fromObject(attributes).toString());
		cookie.setMaxAge(30*24*60*60);
		ServletActionContext.getResponse().addCookie(cookie);
	}
	
	public static void removeCookie(String name) {
		Cookie[] cookies = ServletActionContext.getRequest().getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(name)) {
				cookie.setMaxAge(0);
				ServletActionContext.getResponse().addCookie(cookie);
				break;
			}
		}
	}
	
	public static List<Map<String, String>> getCookieValues(String key) throws CookieNotExistException {
		Cookie[] cookies = ServletActionContext.getRequest().getCookies();
		String value = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(key)) {
					value = cookie.getValue();
					break;
				}
			}
		}
		if (value == null) {
			throw new CookieNotExistException();
		} else {
			JSONArray jsonArray = JSONArray.fromObject(value);
			List<Map<String, String>> list = new ArrayList<Map<String, String>>(0);
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				Map<String, String> map = new HashMap<String, String>(0);
				Iterator<String> iterator = jsonObject.keys();
				while (iterator.hasNext()) {
					String attributeName = iterator.next();
					map.put(attributeName, jsonObject.getString(attributeName));
				}
				list.add(map);
			}
			return list;
		}
	}
	
	public static void appendCookieValue(String key, List<Map<String, String>> attributes) {
		try {
			attributes.addAll(getCookieValues(key));
		} catch (CookieNotExistException ex) {
			ex.printStackTrace();
		}
		addCookie(key, attributes);
	}
}
