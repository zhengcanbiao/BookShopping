package com.bookshopping.action.comment;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbComment;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.service.BooksService;
import com.bookshopping.service.CustomerService;
import com.bookshopping.service.OrderService;
import com.bookshopping.service.OrderdetailService;
import com.opensymphony.xwork2.ActionSupport;

public class AddCommentAction extends ActionSupport {
	private String commentsJson;
	private String result;
	
	@Override
	public String execute() throws Exception {
		JSONArray array = JSONArray.fromObject(commentsJson);
		TbCustomer customer = CustomerService.getCurrentCustomer();
		JSONObject orderObj = array.getJSONObject(0);
		String orderId = orderObj.getString("orderId");
		TbOrder order = OrderService.getOrderByOrderId(orderId);
		if (order.getOrderStatus().equals(OrderService.CONFIRM_DELIVERY)
				&& !order.getIsComment()) {
			for (int i = 1; i < array.size(); i++) {
				JSONObject obj = array.getJSONObject(i);
				int orderDetailId = obj.getInt("orderDetailId");
				String commentContent = obj.getString("commentContent");
				TbOrderdetail orderDetail = OrderdetailService.getOrderdetailByOderDetailId(orderDetailId);
				if (order.getTbOrderdetails().contains(orderDetail)) {
					TbBooks books = orderDetail.getTbBooks();
					TbComment comment = new TbComment(customer, books, commentContent);
					books.getTbComments().add(comment);
					BooksService.updateBooks(books);
				}
			}
			order.setIsComment(true);
			OrderService.updateOrder(order);
			result = "success";
		} else {
			result = "fail";
		}
	    return SUCCESS;
	}

	public String getCommentsJson() {
		return commentsJson;
	}

	public void setCommentsJson(String commentsJson) {
		this.commentsJson = commentsJson;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	
	
}
