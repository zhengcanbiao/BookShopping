package com.bookshopping.dao.provider;

import com.bookshopping.dao.provider.inter.AbstractTbOrderDetailProvider;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.exception.OrderdetailNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbOrderdetailProvider implements AbstractTbOrderDetailProvider{
	
	@Override
	public void addOrderDetail(TbOrderdetail orderdetail) {
		HibernateUtil.add(orderdetail);
	}
	
	@Override
	public void deleteOrderDetail(TbOrderdetail orderdetail) {
		HibernateUtil.delete(orderdetail);
	}
	
	@Override
	public void updateOrderDetail(TbOrderdetail orderDetail) {
		HibernateUtil.update(orderDetail);
	}
	
	@Override
	public TbOrderdetail getOrderdetailByOrderdetailId(Integer orderDetailId) throws OrderdetailNotFoundException {
		TbOrderdetail orderdetail = (TbOrderdetail) HibernateUtil.get(TbOrderdetail.class, orderDetailId);
		if (orderdetail == null) {
			throw new OrderdetailNotFoundException();
		} else {
			return orderdetail;
		}
	}
	
}
