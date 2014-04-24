package com.bookshopping.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * TbAddress entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_address", catalog = "db_bookshopping")
public class TbAddress implements java.io.Serializable {

	// Fields

	private Integer addressId;
	private TbTown tbTown;
	private TbProvince tbProvince;
	private TbCustomer tbCustomer;
	private TbCity tbCity;
	private String receiverName;
	private String receiverAddress;
	private Integer postcode;
	private String phone;
	private boolean isDefault = new Boolean(false);

	// Constructors

	/** default constructor */
	public TbAddress() {
	}
	
	/** minimal constructor */
	public TbAddress(TbCustomer tbCustomer, 
			TbProvince tbProvince, TbCity tbCity, TbTown tbTown, 
			String receiverName, String receiverAddress, 
			Integer postcode, String phone) {
		this.tbCustomer = tbCustomer;
		this.tbProvince = tbProvince;
		this.tbTown = tbTown;
		this.tbCity = tbCity;
		this.receiverName = receiverName;
		this.receiverAddress = receiverAddress;
		this.postcode = postcode;
		this.phone = phone;
	}
	/** full constructor */
	public TbAddress(TbTown tbTown, TbProvince tbProvince,
			TbCustomer tbCustomer, TbCity tbCity, String receiverName,
			String receiverAddress, Integer postcode, String phone,
			boolean isDefault) {
		this.tbTown = tbTown;
		this.tbProvince = tbProvince;
		this.tbCustomer = tbCustomer;
		this.tbCity = tbCity;
		this.receiverName = receiverName;
		this.receiverAddress = receiverAddress;
		this.postcode = postcode;
		this.phone = phone;
		this.isDefault = isDefault;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "AddressID", unique = true, nullable = false)
	public Integer getAddressId() {
		return this.addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "TownID", nullable = false)
	public TbTown getTbTown() {
		return this.tbTown;
	}

	public void setTbTown(TbTown tbTown) {
		this.tbTown = tbTown;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ProvinceID", nullable = false)
	public TbProvince getTbProvince() {
		return this.tbProvince;
	}

	public void setTbProvince(TbProvince tbProvince) {
		this.tbProvince = tbProvince;
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
	@JoinColumn(name = "CityID", nullable = false)
	public TbCity getTbCity() {
		return this.tbCity;
	}

	public void setTbCity(TbCity tbCity) {
		this.tbCity = tbCity;
	}

	@Column(name = "ReceiverName", nullable = false, length = 100)
	public String getReceiverName() {
		return this.receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	@Column(name = "ReceiverAddress", nullable = false, length = 200)
	public String getReceiverAddress() {
		return this.receiverAddress;
	}

	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}

	@Column(name = "Postcode", nullable = false)
	public Integer getPostcode() {
		return this.postcode;
	}

	public void setPostcode(Integer postcode) {
		this.postcode = postcode;
	}

	@Column(name = "Phone", nullable = false, length = 15)
	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Column(name = "IsDefault", nullable = false)
	public boolean getIsDefault() {
		return this.isDefault;
	}

	public void setIsDefault(boolean isDefault) {
		this.isDefault = isDefault;
	}

}