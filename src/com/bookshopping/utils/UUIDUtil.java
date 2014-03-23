package com.bookshopping.utils;

import java.util.UUID;

public class UUIDUtil {
	private UUIDUtil() {
	}
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().split("-")[0];
	}
}
