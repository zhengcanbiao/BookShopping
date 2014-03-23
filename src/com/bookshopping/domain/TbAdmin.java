package com.bookshopping.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TbAdmin entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_admin", catalog = "db_bookshopping")
public class TbAdmin implements java.io.Serializable {

	// Fields

	private String adminName;
	private String password;

	// Constructors

	/** default constructor */
	public TbAdmin() {
	}

	/** full constructor */
	public TbAdmin(String adminName,String password) {
		this.adminName = adminName;
		this.password = password;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "AdminName", unique = true, nullable = false, length = 25)
	public String getAdminName() {
		return this.adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	@Column(name = "Password", nullable = false, length = 32)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}