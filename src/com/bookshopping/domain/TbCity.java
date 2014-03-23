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
 * TbCity entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_city", catalog = "db_bookshopping")
public class TbCity implements java.io.Serializable {

	// Fields

	private Integer cityId;
	private TbProvince tbProvince;
	private String cityName;
	private Set<TbAddress> tbAddresses = new HashSet<TbAddress>(0);
	private Set<TbTown> tbTowns = new HashSet<TbTown>(0);

	// Constructors

	/** default constructor */
	public TbCity() {
	}

	/** minimal constructor */
	public TbCity(TbProvince tbProvince, String cityName) {
		this.tbProvince = tbProvince;
		this.cityName = cityName;
	}

	/** full constructor */
	public TbCity(TbProvince tbProvince, String cityName,
			Set<TbAddress> tbAddresses, Set<TbTown> tbTowns) {
		this.tbProvince = tbProvince;
		this.cityName = cityName;
		this.tbAddresses = tbAddresses;
		this.tbTowns = tbTowns;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "CityID", unique = true, nullable = false)
	public Integer getCityId() {
		return this.cityId;
	}

	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ProvinceID", nullable = false)
	public TbProvince getTbProvince() {
		return this.tbProvince;
	}

	public void setTbProvince(TbProvince tbProvince) {
		this.tbProvince = tbProvince;
	}

	@Column(name = "CityName", nullable = false, length = 32)
	public String getCityName() {
		return this.cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbCity")
	public Set<TbAddress> getTbAddresses() {
		return this.tbAddresses;
	}

	public void setTbAddresses(Set<TbAddress> tbAddresses) {
		this.tbAddresses = tbAddresses;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbCity")
	public Set<TbTown> getTbTowns() {
		return this.tbTowns;
	}

	public void setTbTowns(Set<TbTown> tbTowns) {
		this.tbTowns = tbTowns;
	}

}