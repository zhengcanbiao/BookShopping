package com.bookshopping.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/**
 * TbCart entity. @author MyEclipse Persistence Tools
 */
@Entity
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
@Table(name = "tb_cart", catalog = "db_bookshopping")

public class TbCart implements java.io.Serializable {

	// Fields

	private Integer cartId;
	private TbCustomer tbCustomer;
	private TbBooks tbBooks;
	private Integer booksNumber;

	// Constructors

	/** default constructor */
	public TbCart() {
	}

	/** full constructor */
	public TbCart(TbCustomer tbCustomer, TbBooks tbBooks, Integer booksNumber) {
		this.tbCustomer = tbCustomer;
		this.tbBooks = tbBooks;
		this.booksNumber = booksNumber;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "CartID", unique = true, nullable = false)
	public Integer getCartId() {
		return this.cartId;
	}

	public void setCartId(Integer cartId) {
		this.cartId = cartId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CustomerName", nullable = false)
	public TbCustomer getTbCustomer() {
		return this.tbCustomer;
	}

	public void setTbCustomer(TbCustomer tbCustomer) {
		this.tbCustomer = tbCustomer;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BooksID", nullable = false)
	public TbBooks getTbBooks() {
		return this.tbBooks;
	}

	public void setTbBooks(TbBooks tbBooks) {
		this.tbBooks = tbBooks;
	}

	@Column(name = "BooksNumber", nullable = false)
	public Integer getBooksNumber() {
		return this.booksNumber;
	}

	public void setBooksNumber(Integer booksNumber) {
		this.booksNumber = booksNumber;
	}

}