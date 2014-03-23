package com.bookshopping.utils;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.Properties;


public class PropertiesLoader {
	final private static String classPath;
	private InputStream in;
	Properties props;
	
	public PropertiesLoader(String propertyUrl) throws IOException {
		in = new BufferedInputStream(new FileInputStream(classPath + propertyUrl));
		props = new Properties();
		props.load(in);
	}
	
	public String getProperty(String key) {
		return props.getProperty(key);
	}
	
	@SuppressWarnings("unchecked")
    public Enumeration<String> getKeys() {
		return (Enumeration<String>) props.propertyNames();
	}
	
	static {
		classPath = Thread.currentThread().getContextClassLoader().getResource("").getPath();
	}
}
