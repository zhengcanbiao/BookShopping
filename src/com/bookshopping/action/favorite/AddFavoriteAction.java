package com.bookshopping.action.favorite;

import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.exception.FavoriteExistException;
import com.bookshopping.exception.NoMoreFavoriteException;
import com.bookshopping.service.FavoriteService;
import com.opensymphony.xwork2.ActionSupport;

public class AddFavoriteAction extends ActionSupport {

	private int booksId;
	private String result;

	public int getBooksId() {
		return booksId;
	}

	public void setBooksId(int booksId) {
		this.booksId = booksId;
	}

	@Override
	public String execute() throws Exception {
		try {
			FavoriteService.addFavorite(booksId);
			result = "success";
		} catch (CustomerNotFoundException ex) {
			result = "notLogin";
		} catch (FavoriteExistException ex) {
			result = "exist";
		} catch (NoMoreFavoriteException ex) {
			result = "full";
		}
		return SUCCESS;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	

}
