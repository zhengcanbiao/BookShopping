package com.bookshopping.domain;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * TbBooks entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_books", catalog = "db_bookshopping")
public class TbBooks implements java.io.Serializable {

	// Fields

	private Integer booksId;
	private TbCategory tbCategory;
	private String bookName;
	private String picUrl;
	private Integer remainder;
	private String author;
	private String publisher;
	private String publicationDate;
	private String booksDescription;
	private boolean valid;
	private Integer price;
	private Integer sales;
	private Set<TbOrderdetail> tbOrderdetails = new HashSet<TbOrderdetail>(0);
	private Set<TbCart> tbCarts = new HashSet<TbCart>(0);
	private Set<TbFavorite> tbFavorites = new HashSet<TbFavorite>(0);
	private Set<TbComment> tbComments = new HashSet<TbComment>(0);

	// Constructors

	/** default constructor */
	public TbBooks() {
	}

	/** minimal constructor */
	public TbBooks(String bookName, String picUrl, Integer remainder,
			boolean valid, Integer price, Integer sales) {
		this.bookName = bookName;
		this.picUrl = picUrl;
		this.remainder = remainder;
		this.valid = valid;
		this.price = price;
		this.sales = sales;
	}

	/** full constructor */
	public TbBooks(TbCategory tbCategory, String bookName, String picUrl,
			Integer remainder, String author, String publisher,
			String publicationDate, String booksDescription, boolean valid,
			Integer price, Integer sales, Set<TbOrderdetail> tbOrderdetails,
			Set<TbCart> tbCarts, Set<TbFavorite> tbFavorites,
			Set<TbComment> tbComments) {
		this.tbCategory = tbCategory;
		this.bookName = bookName;
		this.picUrl = picUrl;
		this.remainder = remainder;
		this.author = author;
		this.publisher = publisher;
		this.publicationDate = publicationDate;
		this.booksDescription = booksDescription;
		this.valid = valid;
		this.price = price;
		this.sales = sales;
		this.tbOrderdetails = tbOrderdetails;
		this.tbCarts = tbCarts;
		this.tbFavorites = tbFavorites;
		this.tbComments = tbComments;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "BooksID", unique = true, nullable = false)
	public Integer getBooksId() {
		return this.booksId;
	}

	public void setBooksId(Integer booksId) {
		this.booksId = booksId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CategoryID")
	public TbCategory getTbCategory() {
		return this.tbCategory;
	}

	public void setTbCategory(TbCategory tbCategory) {
		this.tbCategory = tbCategory;
	}

	@Column(name = "BookName", nullable = false, length = 100)
	public String getBookName() {
		return this.bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	@Column(name = "PicUrl", nullable = false, length = 200)
	public String getPicUrl() {
		return this.picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}

	@Column(name = "Remainder", nullable = false)
	public Integer getRemainder() {
		return this.remainder;
	}

	public void setRemainder(Integer remainder) {
		this.remainder = remainder;
	}

	@Column(name = "Author", length = 100)
	public String getAuthor() {
		return this.author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	@Column(name = "Publisher", length = 100)
	public String getPublisher() {
		return this.publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	@Column(name = "PublicationDate", length = 100)
	public String getPublicationDate() {
		return this.publicationDate;
	}

	public void setPublicationDate(String publicationDate) {
		this.publicationDate = publicationDate;
	}

	@Column(name = "BooksDescription", length = 65535)
	public String getBooksDescription() {
		return this.booksDescription;
	}

	public void setBooksDescription(String booksDescription) {
		this.booksDescription = booksDescription;
	}

	@Column(name = "Valid", nullable = false)
	public boolean getValid() {
		return this.valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	@Column(name = "Price", nullable = false)
	public Integer getPrice() {
		return this.price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	@Column(name = "Sales", nullable = false)
	public Integer getSales() {
		return this.sales;
	}

	public void setSales(Integer sales) {
		this.sales = sales;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbBooks")
	public Set<TbOrderdetail> getTbOrderdetails() {
		return this.tbOrderdetails;
	}

	public void setTbOrderdetails(Set<TbOrderdetail> tbOrderdetails) {
		this.tbOrderdetails = tbOrderdetails;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbBooks")
	public Set<TbCart> getTbCarts() {
		return this.tbCarts;
	}

	public void setTbCarts(Set<TbCart> tbCarts) {
		this.tbCarts = tbCarts;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbBooks")
	public Set<TbFavorite> getTbFavorites() {
		return this.tbFavorites;
	}

	public void setTbFavorites(Set<TbFavorite> tbFavorites) {
		this.tbFavorites = tbFavorites;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbBooks")
	public Set<TbComment> getTbComments() {
		return this.tbComments;
	}

	public void setTbComments(Set<TbComment> tbComments) {
		this.tbComments = tbComments;
	}

}