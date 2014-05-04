package com.bookshopping.action.managerBooks;

import java.io.File;
import java.math.BigDecimal;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCategory;
import com.bookshopping.service.BooksService;
import com.bookshopping.service.CategoryService;
import com.bookshopping.utils.UUIDUtil;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ModifyBooksDetailAction extends ActionSupport {

	private int booksId;
//	private String booksName;
//	private String price;
//	private String remainder0 = "";
//	private String remainder1 = "";
//	private String remainder2 = "";
//	private String producer;
//	private String material;
//	private int secondCategory;
//	private String booksDescription;
//	private File image = null;
	
	private String bookName;
	private String price;
	private String remainder;
	private String author;
	private String publisher;
	private String publicationDate;
//	private int categoryId;
	private int secondCategory;
	private String booksDescription;
	private File image;
	
	
	public int getBooksId() {
		return booksId;
	}


	public void setBooksId(int booksId) {
		this.booksId = booksId;
	}


	public String getBookName() {
		return bookName;
	}


	public void setBookName(String bookName) {
		this.bookName = bookName;
	}


	public String getPrice() {
		return price;
	}


	public void setPrice(String price) {
		this.price = price;
	}


	public String getRemainder() {
		return remainder;
	}


	public void setRemainder(String remainder) {
		this.remainder = remainder;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


	public String getPublisher() {
		return publisher;
	}


	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}


	public String getPublicationDate() {
		return publicationDate;
	}


	public void setPublicationDate(String publicationDate) {
		this.publicationDate = publicationDate;
	}


	public int getSecondCategory() {
		return secondCategory;
	}


	public void setSecondCategory(int secondCategory) {
		this.secondCategory = secondCategory;
	}


	public String getBooksDescription() {
		return booksDescription;
	}


	public void setBooksDescription(String booksDescription) {
		this.booksDescription = booksDescription;
	}


	public File getImage() {
		return image;
	}


	public void setImage(File image) {
		this.image = image;
	}


	@Override
	public String execute() throws Exception {
		int r = 0;
		try {
			if (remainder.equals("") == false) {
				r = Integer.parseInt(remainder);
			}

		} catch (NumberFormatException e) {
			addActionError("remainder库存格式错误");
			return INPUT;
		}
		TbBooks books = BooksService.getBooksByBooksId(booksId);
		TbCategory category = CategoryService.getCategoryByCategoryId(secondCategory);
		books.setTbCategory(category);
		books.setBookName(bookName.trim());
		books.setRemainder(Integer.parseInt(remainder));
		books.setAuthor(author);
		books.setPublisher(publisher);
		books.setPublicationDate(publicationDate);
		books.setBooksDescription(booksDescription);
		BigDecimal bd = new BigDecimal(price).setScale(2, BigDecimal.ROUND_DOWN).multiply(new BigDecimal(100));
		books.setPrice(bd.intValue());
		String picUrl = null;
		if(image != null) {
			String realpath = ServletActionContext.getServletContext().getRealPath("/pic");
			new File(new File(realpath),books.getPicUrl().substring(5)).delete();
			picUrl = UUIDUtil.getRandomString()+".jpg";
			FileUtils.copyFile(image, new File(new File(realpath), picUrl));
			picUrl = "/BookShopping/pic/" + picUrl;
			books.setPicUrl(picUrl);
		}
		BooksService.updateBooks(books);
		return SUCCESS;
	}
}
