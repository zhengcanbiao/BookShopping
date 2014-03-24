package com.bookshopping.utils.mailConfirm;

import javax.mail.Authenticator;

public class MailAuthenticator extends Authenticator {
	private String userName;
	private String password;
	
	public MailAuthenticator() {
	}
	
	public MailAuthenticator(String userName, String password) {
		this.userName = userName;
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
