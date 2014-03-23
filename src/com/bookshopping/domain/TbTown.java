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
 * TbTown entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_town", catalog = "db_bookshopping")
public class TbTown implements java.io.Serializable {

	// Fields

	private Integer townId;
	private TbCity tbCity;
	private String townName;
	private Set<TbAddress> tbAddresses = new HashSet<TbAddress>(0);

	// Constructors

	/** default constructor */
	public TbTown() {
	}

	/** minimal constructor */
	public TbTown(TbCity tbCity, String townName) {
		this.tbCity = tbCity;
		this.townName = townName;
	}

	/** full constructor */
	public TbTown(TbCity tbCity, String townName, Set<TbAddress> tbAddresses) {
		this.tbCity = tbCity;
		this.townName = townName;
		this.tbAddresses = tbAddresses;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "TownID", unique = true, nullable = false)
	public Integer getTownId() {
		return this.townId;
	}

	public void setTownId(Integer townId) {
		this.townId = townId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CityID", nullable = false)
	public TbCity getTbCity() {
		return this.tbCity;
	}

	public void setTbCity(TbCity tbCity) {
		this.tbCity = tbCity;
	}

	@Column(name = "TownName", nullable = false, length = 32)
	public String getTownName() {
		return this.townName;
	}

	public void setTownName(String townName) {
		this.townName = townName;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbTown")
	public Set<TbAddress> getTbAddresses() {
		return this.tbAddresses;
	}

	public void setTbAddresses(Set<TbAddress> tbAddresses) {
		this.tbAddresses = tbAddresses;
	}

}