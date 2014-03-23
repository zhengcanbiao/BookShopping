package com.bookshopping.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SHAEncypherUtil {
	public static String encryptSHA(String str) {
		byte[] data = str.getBytes();
		MessageDigest md5;
        try {
	        md5 = MessageDigest.getInstance("SHA");
			md5.update(data);
			return new String(md5.digest());
        } catch (NoSuchAlgorithmException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
        }
        return null;
	}
}
