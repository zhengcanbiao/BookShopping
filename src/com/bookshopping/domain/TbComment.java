package com.bookshopping.domain;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/**
 * TbComment entity. @author MyEclipse Persistence Tools
 */
@Entity
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
@Table(name = "tb_comment", catalog = "db_bookshopping")
public class TbComment implements java.io.Serializable {

	// Fields

	private Integer commentId;
	private TbCustomer tbCustomer;
	private TbBooks tbBooks;
	private Date commentTime;
	private String commentContent;

	// Constructors

	/** default constructor */
	public TbComment() {
	}

	/** full constructor */
	public TbComment(TbCustomer tbCustomer, TbBooks tbBooks, Date commentTime,
			String commentContent) {
		this.tbCustomer = tbCustomer;
		this.tbBooks = tbBooks;
		this.commentTime = commentTime;
		this.commentContent = commentContent;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "CommentID", unique = true, nullable = false)
	public Integer getCommentId() {
		return this.commentId;
	}

	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
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
	@JoinColumn(name = "BooksID", nullable = false)
	public TbBooks getTbBooks() {
		return this.tbBooks;
	}

	public void setTbBooks(TbBooks tbBooks) {
		this.tbBooks = tbBooks;
	}

	@Column(name = "CommentTime", nullable = false, length = 19)
	public Date getCommentTime() {
		return this.commentTime;
	}

	public void setCommentTime(Date commentTime) {
		this.commentTime = commentTime;
	}

	@Column(name = "CommentContent", nullable = false, length = 65535)
	public String getCommentContent() {
		return this.commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

}