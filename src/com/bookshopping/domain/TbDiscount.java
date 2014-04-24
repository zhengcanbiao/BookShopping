package com.bookshopping.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/**
 * TbDiscount entity. @author MyEclipse Persistence Tools
 */
@Entity
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
@Table(name = "tb_discount", catalog = "db_bookshopping")
public class TbDiscount implements java.io.Serializable {

	// Fields

	private Integer discountPoints;
	private Integer discountRate = new Integer(100);;

	// Constructors

	/** default constructor */
	public TbDiscount() {
	}

	/** full constructor */
	public TbDiscount(Integer discountRate) {
		this.discountRate = discountRate;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "assigned")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "DiscountPoints", unique = true, nullable = false)
	public Integer getDiscountPoints() {
		return this.discountPoints;
	}

	public void setDiscountPoints(Integer discountPoints) {
		this.discountPoints = discountPoints;
	}

	@Column(name = "DiscountRate", nullable = false)
	public Integer getDiscountRate() {
		return this.discountRate;
	}

	public void setDiscountRate(Integer discountRate) {
		this.discountRate = discountRate;
	}

}