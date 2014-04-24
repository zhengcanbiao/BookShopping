package com.bookshopping.service;

import java.util.ArrayList;
import java.util.List;

import com.bookshopping.dao.provider.TbOrderdetailProvider;
import com.bookshopping.domain.TbCart;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.utils.SpringUtil;

public class OrderdetailService {
	private OrderdetailService() {
	}
	
	public static TbOrderdetailProvider getTbOrderdetailProvider() {
		return (TbOrderdetailProvider) SpringUtil.getBeanById("tbOrderdetailProvider");
	}
	
	public static List<TbOrderdetail> generateOrderDetailListByCartList(List<TbCart> cartList) {
		List<TbOrderdetail> orderDetailList = new ArrayList<TbOrderdetail>(0);
		for (TbCart cart : cartList) {
			TbOrderdetail orderDetail = new TbOrderdetail();
			orderDetail.setQuantity(cart.getBooksNumber());
			orderDetail.setPrice(cart.getBooksNumber() * cart.getTbBooks().getPrice());
			orderDetail.setTbBooks(cart.getTbBooks());
			orderDetailList.add(orderDetail);
		}
		return orderDetailList;
	}

	public static TbOrderdetail getOrderdetailByOderDetailId(int orderDetailId) {
	    return getTbOrderdetailProvider().getOrderdetailByOrderdetailId(orderDetailId);
    }
	
}
