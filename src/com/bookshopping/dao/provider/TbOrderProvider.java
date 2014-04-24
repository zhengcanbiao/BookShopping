package com.bookshopping.dao.provider;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;

import com.bookshopping.dao.provider.inter.AbstractTbOrderProvider;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.exception.OrderNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbOrderProvider implements AbstractTbOrderProvider{
	
	@Override
	public void addOrder(TbOrder order) {
		HibernateUtil.add(order);
	}
	
	@Override
	public void deleteOrder(TbOrder order) {
		HibernateUtil.delete(order);
	}
	
	@Override
	public void updateOrder(TbOrder order) {
		HibernateUtil.update(order);
	}
	
	@Override
	public TbOrder getOrderByOrderId(String orderId) throws OrderNotFoundException {
		TbOrder order = (TbOrder) HibernateUtil.get(TbOrder.class, orderId);
		if (order == null) {
			throw new OrderNotFoundException();
		} else {
			return order;
		}
	}

	@Override
	public List<TbOrderdetail> getOrdertailListByOrderId(String orderId) throws OrderNotFoundException {
		TbOrder order = getOrderByOrderId(orderId);
		List<TbOrderdetail> orderDetailList = order.getTbOrderdetails();
		return orderDetailList;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<TbOrder> getOrderList() throws OrderNotFoundException {
		List<TbOrder> orderList = HibernateUtil.executeQueryForMultiResults("from TbOrder", null);
		if (orderList == null) {
			throw new OrderNotFoundException();
		} else {
			return orderList;
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<TbOrder> getOrderListBetweenDates(Date beginDate, Date endDate)
			throws OrderNotFoundException {
		String hql ="from TbOrder where orderTime >:beginDate and orderTime <:endDate and orderStatus>-1";
		Query query=HibernateUtil.getCurrentSession().createQuery(hql);
		query.setTimestamp("beginDate", beginDate);//注意这里，用setTimestamp﻿e，不要用setDate  
		query.setTimestamp("endDate", endDate);
		List<TbOrder> list=query.list();
		if (list == null) {
			throw new OrderNotFoundException();
		} else {
			return list;
		}
	}
}
