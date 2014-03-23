package com.bookshopping.dao.provider.inter;

import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.exception.OrderdetailNotFoundException;

public interface AbstractTbOrderDetailProvider {
	public void addOrderDetail(TbOrderdetail orderdetail);
	public void updateOrderDetail(TbOrderdetail orderdetail);
	public void deleteOrderDetail(TbOrderdetail ordertail);
	TbOrderdetail getOrderdetailByOrderdetailId(Integer orderDetailId)
            throws OrderdetailNotFoundException;
}
