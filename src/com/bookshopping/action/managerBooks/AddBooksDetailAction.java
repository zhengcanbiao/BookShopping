package com.bookshopping.action.managerBooks;

import java.io.File;
import java.math.BigDecimal;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.bookshopping.service.BooksService;
import com.bookshopping.utils.UUIDUtil;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class AddBooksDetailAction extends ActionSupport {

	private String bookName;
	private String price;
	private String remainder;
	private String author;
	private String publisher;
	private String publicationDate;
	private int categoryId;
	private String booksDescription;
	private File image;

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
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

	public String getBooksDescription() {
		return booksDescription;
	}

	public void setBooksDescription(String booksDescription) {
		this.booksDescription = booksDescription;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
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
		BigDecimal bd = new BigDecimal(price)
				.setScale(2, BigDecimal.ROUND_DOWN).multiply(
						new BigDecimal(100));
		String realpath = ServletActionContext.getServletContext().getRealPath(
				"/pic");
		String picUrl = UUIDUtil.getRandomString() + ".jpg";
		File savefile = new File(new File(realpath), picUrl);
		FileUtils.copyFile(image, savefile);
		picUrl = "/BookShopping/pic/" + picUrl;
		BooksService.addBooks(categoryId, bookName, bd.intValue(), r, author,
				publisher, publicationDate, picUrl, booksDescription);

		return SUCCESS;
	}

}
