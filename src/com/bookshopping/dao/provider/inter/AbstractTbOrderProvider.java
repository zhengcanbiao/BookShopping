package com.bookshopping.dao.provider.inter;

import java.util.Date;
import java.util.List;

import com.bookshopping.domain.TbOrder;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.exception.OrderNotFoundException;

public interface AbstractTbOrderProvider {
	public void addOrder(TbOrder order);
	public void updateOrder(TbOrder order);
	public void deleteOrder(TbOrder order);
	TbOrder getOrderByOrderId(String orderId) throws OrderNotFoundException;
	List<TbOrderdetail> getOrdertailListByOrderId(String orderId)
            throws OrderNotFoundException;
	List<TbOrder> getOrderList() throws OrderNotFoundException;
	List<TbOrder> getOrderListBetweenDates(Date beginDate, Date endDate)
            throws OrderNotFoundException;
}
