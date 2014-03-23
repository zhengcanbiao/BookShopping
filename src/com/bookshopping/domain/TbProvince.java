package com.bookshopping.domain;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * TbProvince entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_province", catalog = "db_bookshopping")
public class TbProvince implements java.io.Serializable {

	// Fields

	private Integer provinceId;
	private String provinceName;
	private Set<TbAddress> tbAddresses = new HashSet<TbAddress>(0);
	private Set<TbCity> tbCities = new HashSet<TbCity>(0);

	// Constructors

	/** default constructor */
	public TbProvince() {
	}

	/** minimal constructor */
	public TbProvince(String provinceName) {
		this.provinceName = provinceName;
	}

	/** full constructor */
	public TbProvince(String provinceName, Set<TbAddress> tbAddresses,
			Set<TbCity> tbCities) {
		this.provinceName = provinceName;
		this.tbAddresses = tbAddresses;
		this.tbCities = tbCities;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "ProvinceID", unique = true, nullable = false)
	public Integer getProvinceId() {
		return this.provinceId;
	}

	public void setProvinceId(Integer provinceId) {
		this.provinceId = provinceId;
	}

	@Column(name = "ProvinceName", nullable = false, length = 32)
	public String getProvinceName() {
		return this.provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbProvince")
	public Set<TbAddress> getTbAddresses() {
		return this.tbAddresses;
	}

	public void setTbAddresses(Set<TbAddress> tbAddresses) {
		this.tbAddresses = tbAddresses;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbProvince")
	public Set<TbCity> getTbCities() {
		return this.tbCities;
	}

	public void setTbCities(Set<TbCity> tbCities) {
		this.tbCities = tbCities;
	}

}