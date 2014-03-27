package com.bookshopping.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * TbFavorite entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_favorite", catalog = "db_bookshopping")
public class TbFavorite implements java.io.Serializable {

	// Fields

	private Integer favoriteId;
	private TbCustomer tbCustomer;
	private TbBooks tbBooks;

	// Constructors

	/** default constructor */
	public TbFavorite() {
	}

	/** full constructor */
	public TbFavorite( TbBooks tbBooks,TbCustomer tbCustomer) {
		this.tbCustomer = tbCustomer;
		this.tbBooks = tbBooks;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "FavoriteID", unique = true, nullable = false)
	public Integer getFavoriteId() {
		return this.favoriteId;
	}

	public void setFavoriteId(Integer favoriteId) {
		this.favoriteId = favoriteId;
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

}