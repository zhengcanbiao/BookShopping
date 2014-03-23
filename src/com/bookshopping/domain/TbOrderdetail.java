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
 * TbOrderdetail entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_orderdetail", catalog = "db_bookshopping")
public class TbOrderdetail implements java.io.Serializable {

	// Fields

	private Integer orderDetailId;
	private TbBooks tbBooks;
	private TbOrder tbOrder;
	private Integer quantity;
	private Integer price;

	// Constructors

	/** default constructor */
	public TbOrderdetail() {
	}

	/** full constructor */
	public TbOrderdetail(TbBooks tbBooks, TbOrder tbOrder, Integer quantity,
			Integer price) {
		this.tbBooks = tbBooks;
		this.tbOrder = tbOrder;
		this.quantity = quantity;
		this.price = price;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "OrderDetailID", unique = true, nullable = false)
	public Integer getOrderDetailId() {
		return this.orderDetailId;
	}

	public void setOrderDetailId(Integer orderDetailId) {
		this.orderDetailId = orderDetailId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BooksID", nullable = false)
	public TbBooks getTbBooks() {
		return this.tbBooks;
	}

	public void setTbBooks(TbBooks tbBooks) {
		this.tbBooks = tbBooks;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "OrderID", nullable = false)
	public TbOrder getTbOrder() {
		return this.tbOrder;
	}

	public void setTbOrder(TbOrder tbOrder) {
		this.tbOrder = tbOrder;
	}

	@Column(name = "Quantity", nullable = false)
	public Integer getQuantity() {
		return this.quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	@Column(name = "Price", nullable = false)
	public Integer getPrice() {
		return this.price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

}