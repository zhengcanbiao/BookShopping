package com.bookshopping.action.manager;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class JumpAction extends ActionSupport {
	
	private int jumpId;
	
	public int getJumpId() {
		return jumpId;
	}

	public void setJumpId(int jumpId) {
		this.jumpId = jumpId;
	}

	@Override
	public String execute() {
		if (jumpId > 7 || jumpId < 0) {
			addActionError("jumpId："+jumpId+" 错误！");
			return INPUT;
		}
		return String.valueOf(jumpId);
	}

}
