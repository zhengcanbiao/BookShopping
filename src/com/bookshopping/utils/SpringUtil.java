package com.bookshopping.utils;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

final public class SpringUtil {
	private static ApplicationContext context;
	
	private SpringUtil() {
	}
	
	public static Object getBeanById(String id) {
		Object returnVal = null;
		try {
			returnVal = context.getBean(id);
		} catch (BeansException ex) {
			ex.printStackTrace();
		}
		return returnVal;
	}
	
	static {
		context = new ClassPathXmlApplicationContext("applicationContext.xml");
	}
}
