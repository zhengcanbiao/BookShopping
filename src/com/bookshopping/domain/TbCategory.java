package com.bookshopping.domain;

import java.util.ArrayList;
import java.util.List;
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
 * TbCategory entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_category", catalog = "db_bookshopping")
public class TbCategory implements java.io.Serializable {

	// Fields

	private Integer categoryId;
	private String categoryName;
	private Integer parentId;
	private boolean valid;
	private List<TbBooks> tbBookses = new ArrayList<TbBooks>(0);


	// Constructors

	/** default constructor */
	public TbCategory() {
	}

	/** minimal constructor */
	public TbCategory(String categoryName, Integer parentId, boolean valid) {
		this.categoryName = categoryName;
		this.parentId = parentId;
		this.valid = valid;
	}

	/** full constructor */
	public TbCategory(String categoryName, Integer parentId, boolean valid,
			List<TbBooks> tbBookses) {
		this.categoryName = categoryName;
		this.parentId = parentId;
		this.valid = valid;
		this.tbBookses = tbBookses;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "CategoryID", unique = true, nullable = false)
	public Integer getCategoryId() {
		return this.categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	@Column(name = "CategoryName", nullable = false, length = 100)
	public String getCategoryName() {
		return this.categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Column(name = "ParentID", nullable = false)
	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	@Column(name = "Valid", nullable = false)
	public boolean getValid() {
		return this.valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbCategory")
	public List<TbBooks> getTbBookses() {
		return this.tbBookses;
	}

	public void setTbBookses(List<TbBooks> tbBookses) {
		this.tbBookses = tbBookses;
	}

}