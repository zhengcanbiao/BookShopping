package com.bookshopping.utils.mailConfirm;

import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

public class MailSender {
	private final transient Properties props = System.getProperties();
	private transient MailAuthenticator authenticator;
	private transient Session session;
	
	public MailSender() {
	}
	
	public MailSender(final String userName, final String password) {
		authenticator = new MailAuthenticator(userName, password);
		init();
	}
	
	public MailAuthenticator getAuthenticator() {
		return authenticator;
	}

	public void setAuthenticator(MailAuthenticator authenticator) {
		this.authenticator = authenticator;
	}

	public void init() {
		final String smtpHostName = "smtp." + authenticator.getUserName().split("@")[1];
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.host", smtpHostName);
		session = Session.getInstance(props, authenticator);
	}
	
	private void send(String recipient, String subject, Object content) throws AddressException, MessagingException {
		final MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(authenticator.getUserName()));
		message.setRecipient(RecipientType.TO, new InternetAddress(recipient));
		message.setSubject(subject);
		message.setContent(content.toString(), "text/html;charset=utf-8");
		Transport.send(message, authenticator.getUserName(), authenticator.getPassword());
	}
	
	public void send(String recipient, MailContent mail) throws AddressException, MessagingException {
		send(recipient, mail.getSubject(), mail.getContent());
	}
}
