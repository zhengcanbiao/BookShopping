package com.bookshopping.action.favorite;

import com.bookshopping.service.FavoriteService;
import com.opensymphony.xwork2.ActionSupport;

public class DeleteFavoriteAction extends ActionSupport{

	private int favoriteId;
	private String result;
	
	@Override
	public String execute() throws Exception {
		System.out.println("execute" + favoriteId);
		FavoriteService.deleteFavoriteByFavoriteId(favoriteId);
		return SUCCESS;
	}

	public int getFavoriteId() {
		return favoriteId;
	}

	public void setFavoriteId(int favoriteId) {
		this.favoriteId = favoriteId;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	
}
