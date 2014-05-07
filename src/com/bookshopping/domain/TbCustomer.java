package com.bookshopping.domain;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/**
 * TbCustomer entity. @author MyEclipse Persistence Tools
 */
@Entity
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
@Table(name = "tb_customer", catalog = "db_bookshopping", uniqueConstraints = @UniqueConstraint(columnNames = "NickName"))
public class TbCustomer implements java.io.Serializable {

	// Fields

	private String customerName;
	private String nickName;
	private String password;
	private Date registerTime=new Timestamp(System.currentTimeMillis());
	private Integer sex = new Integer(0);
	private Integer points = new Integer(0);
	private Boolean valid = new Boolean(true);
	private List<TbAddress> tbAddresses = new ArrayList<TbAddress>(0);
	private List<TbOrder> tbOrders = new ArrayList<TbOrder>(0);
	private List<TbCart> tbCarts = new ArrayList<TbCart>(0);
	private List<TbComment> tbComments = new ArrayList<TbComment>(0);
	private List<TbFavorite> tbFavorites = new ArrayList<TbFavorite>(0);

	// Constructors

	/** default constructor */
	public TbCustomer() {
	}

	/** minimal constructor */
//	public TbCustomer(String nickName, String password, Date registerTime,
//			Integer sex, Integer points, boolean valid) {
//		this.nickName = nickName;
//		this.password = password;
//		this.registerTime = registerTime;
//		this.sex = sex;
//		this.points = points;
//		this.valid = valid;
//	}
	public TbCustomer(String customerName, String nickName, String password) {
		this.customerName = customerName;
		this.nickName = nickName;
		this.password = password;
	}
	/** full constructor */
	public TbCustomer(String customerName,String nickName, String password, Date registerTime,
			Integer sex, Integer points, boolean valid,
			List<TbAddress> tbAddresses, List<TbOrder> tbOrders,
			List<TbCart> tbCarts, List<TbComment> tbComments,
			List<TbFavorite> tbFavorites) {
		this.customerName = customerName;
		this.nickName = nickName;
		this.password = password;
		this.registerTime = registerTime;
		this.sex = sex;
		this.points = points;
		this.valid = valid;
		this.tbAddresses = tbAddresses;
		this.tbOrders = tbOrders;
		this.tbCarts = tbCarts;
		this.tbComments = tbComments;
		this.tbFavorites = tbFavorites;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "assigned")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "CustomerName", unique = true, nullable = false, length = 100)
	public String getCustomerName() {
		return this.customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	@Column(name = "NickName", unique = true, nullable = false, length = 25)
	public String getNickName() {
		return this.nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	@Column(name = "Password", nullable = false, length = 32)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "RegisterTime", nullable = false, length = 19)
	public Date getRegisterTime() {
//		SimpleDateFormat sDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");     
//		String date = sDateFormat.format();
		return this.registerTime;  
	
	}

	public void setRegisterTime(Date registerTime) {
		
		this.registerTime = registerTime;
	}

	@Column(name = "Sex", nullable = false)
	public Integer getSex() {
		return this.sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	@Column(name = "Points", nullable = false)
	public Integer getPoints() {
		return this.points;
	}

	public void setPoints(Integer points) {
		this.points = points;
	}

	@Column(name = "Valid", nullable = false)
	public boolean getValid() {
		return this.valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbCustomer")
	public List<TbAddress> getTbAddresses() {
		return this.tbAddresses;
	}

	public void setTbAddresses(List<TbAddress> tbAddresses) {
		this.tbAddresses = tbAddresses;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbCustomer")
	public List<TbOrder> getTbOrders() {
		return this.tbOrders;
	}

	public void setTbOrders(List<TbOrder> tbOrders) {
		this.tbOrders = tbOrders;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbCustomer")
	public List<TbCart> getTbCarts() {
		return this.tbCarts;
	}

	public void setTbCarts(List<TbCart> tbCarts) {
		this.tbCarts = tbCarts;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbCustomer")
	public List<TbComment> getTbComments() {
		return this.tbComments;
	}

	public void setTbComments(List<TbComment> tbComments) {
		this.tbComments = tbComments;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbCustomer")
	public List<TbFavorite> getTbFavorites() {
		return this.tbFavorites;
	}

	public void setTbFavorites(List<TbFavorite> tbFavorites) {
		this.tbFavorites = tbFavorites;
	}

}