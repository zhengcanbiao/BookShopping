package com.bookshopping.domain;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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

import org.hibernate.annotations.GenericGenerator;

/**
 * TbOrder entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_order", catalog = "db_bookshopping")
public class TbOrder implements java.io.Serializable {

	// Fields

	private String orderId;
	private TbCustomer tbCustomer;
	private String receiverInfo;
	private Integer orderStatus = new Integer(0);
	private Date orderTime = new Timestamp(System.currentTimeMillis());
	private Integer totalPrice;
	private Integer finalPrice;
	private boolean isComment = new Boolean(false);
	private boolean valid = new Boolean(true);
	private Integer discount = new Integer(100);
	private List<TbOrderdetail> tbOrderdetails = new ArrayList<TbOrderdetail>(0);

	// Constructors

	/** default constructor */
	public TbOrder() {
	}

	/** minimal constructor */
	
	public TbOrder(TbCustomer tbCustomer, String receiverInfo,
	        Integer totalPrice,Integer finalPrice) {
		this.tbCustomer = tbCustomer;
		this.receiverInfo = receiverInfo;
		this.totalPrice = totalPrice;
		this.finalPrice = finalPrice;
	}

	/** full constructor */
	public TbOrder(TbCustomer tbCustomer, String receiverInfo,
			Integer orderStatus, Date orderTime, Integer totalPrice,
			Integer finalPrice, boolean isComment, boolean valid,
			Integer discount, List<TbOrderdetail> tbOrderdetails) {
		this.tbCustomer = tbCustomer;
		this.receiverInfo = receiverInfo;
		this.orderStatus = orderStatus;
		this.orderTime = orderTime;
		this.totalPrice = totalPrice;
		this.finalPrice = finalPrice;
		this.isComment = isComment;
		this.valid = valid;
		this.discount = discount;
		this.tbOrderdetails = tbOrderdetails;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "assigned")
	@Id
	@GeneratedValue(generator="generator")
	@Column(name = "OrderID", unique = true, nullable = false, length = 32)
	public String getOrderId() {
		return this.orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CustomerName", nullable = false)
	public TbCustomer getTbCustomer() {
		return this.tbCustomer;
	}

	public void setTbCustomer(TbCustomer tbCustomer) {
		this.tbCustomer = tbCustomer;
	}

	@Column(name = "ReceiverInfo", nullable = false, length = 65535)
	public String getReceiverInfo() {
		return this.receiverInfo;
	}

	public void setReceiverInfo(String receiverInfo) {
		this.receiverInfo = receiverInfo;
	}

	@Column(name = "OrderStatus", nullable = false)
	public Integer getOrderStatus() {
		return this.orderStatus;
	}

	public void setOrderStatus(Integer orderStatus) {
		this.orderStatus = orderStatus;
	}

	@Column(name = "OrderTime", nullable = false, length = 19)
	public Date getOrderTime() {
		return this.orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}

	@Column(name = "TotalPrice", nullable = false)
	public Integer getTotalPrice() {
		return this.totalPrice;
	}

	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Column(name = "FinalPrice", nullable = false)
	public Integer getFinalPrice() {
		return this.finalPrice;
	}

	public void setFinalPrice(Integer finalPrice) {
		this.finalPrice = finalPrice;
	}

	@Column(name = "IsComment", nullable = false)
	public boolean getIsComment() {
		return this.isComment;
	}

	public void setIsComment(boolean isComment) {
		this.isComment = isComment;
	}

	@Column(name = "Valid", nullable = false)
	public boolean getValid() {
		return this.valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	@Column(name = "Discount", nullable = false)
	public Integer getDiscount() {
		return this.discount;
	}

	public void setDiscount(Integer discount) {
		this.discount = discount;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbOrder")
	public List<TbOrderdetail> getTbOrderdetails() {
		return this.tbOrderdetails;
	}

	public void setTbOrderdetails(List<TbOrderdetail> tbOrderdetails) {
		this.tbOrderdetails = tbOrderdetails;
	}

}