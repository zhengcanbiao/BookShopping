package com.bookshopping.service;

import java.util.List;

import com.bookshopping.dao.provider.TbOrderProvider;
import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbCart;
import com.bookshopping.domain.TbCustomer;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.exception.CustomerNotFoundException;
import com.bookshopping.exception.DiscountNotFoundException;
import com.bookshopping.exception.OrderNotFoundException;
import com.bookshopping.utils.OrderIdGenerator;
import com.bookshopping.utils.SearchUtil;
import com.bookshopping.utils.SpringUtil;

public class OrderService {
	public static final int ORDER_FAIL = -1;
	public static final int NOT_DELEVERY = 1;
	public static final int HAS_DELEVERY = 2;
	public static final int CONFIRM_DELIVERY = 3;

	private OrderService() {
	}
	
	public static TbOrderProvider getTbOrderProvider() {
		return (TbOrderProvider) (SpringUtil.getBeanById("tbOrderProvider"));
	}

	public static boolean addOrder(List<TbCart> cartList, String receiverInfo, String customerName) throws CustomerNotFoundException {
		TbCustomer customer = CustomerService.getCustomerByCustomerName(customerName);
		TbOrder order = new TbOrder(customer, receiverInfo, 0, 0);
		order.setOrderId(OrderIdGenerator.generate());
		try {
			int totalPrice = 0;
			List<TbOrderdetail> orderdetailList = OrderdetailService.generateOrderDetailListByCartList(cartList);
			for (TbOrderdetail orderdetail : orderdetailList) {
				TbBooks booksDetail = orderdetail.getTbBooks();
				int remainder = booksDetail.getRemainder() - orderdetail.getQuantity();
				if (remainder >= 0) {
					booksDetail.setRemainder(remainder);
					BooksService.updateBooks(booksDetail);
					orderdetail.setTbOrder(order);
					order.getTbOrderdetails().add(orderdetail);
					totalPrice += orderdetail.getPrice();
				} else {
					return false;
				}
			}
			order.setTotalPrice(totalPrice);
			try {
				order.setDiscount(DiscountService.getDiscountList().get(DiscountService.getDiscountLevelByPoints(customer.getPoints())).getDiscountRate());
			} catch (DiscountNotFoundException ex) {
				ex.printStackTrace();
				order.setDiscount(1);
			}
			order.setOrderStatus(OrderService.NOT_DELEVERY);
			order.setFinalPrice((int) (order.getTotalPrice()/100.0*order.getDiscount()));
			getTbOrderProvider().addOrder(order);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return true;
    }

	public static TbOrder getOrderByOrderId(String orderId) {
	    return getTbOrderProvider().getOrderByOrderId(orderId);
    }

	public static void deleteOrderByOrderId(String orderId) {
	    getTbOrderProvider().deleteOrder(getOrderByOrderId(orderId));
    }

	public static void cancelOrderByOrderIdForCusomter(String orderId,
            String customerName) throws OrderNotFoundException {
		TbOrder order = getOrderByOrderId(orderId);
		if (CustomerService.isOrderBelongToCustomer(order, customerName) 
				&& order.getOrderStatus().equals(NOT_DELEVERY)) {
			order.setOrderStatus(ORDER_FAIL);
			getTbOrderProvider().updateOrder(order);
			List<TbOrderdetail> orderDetails = order.getTbOrderdetails();
			for (TbOrderdetail orderDetail : orderDetails) {
				TbBooks booksDetail = orderDetail.getTbBooks();
				booksDetail.setRemainder(booksDetail.getRemainder() + orderDetail.getQuantity());
				BooksService.updateBooks(booksDetail);
			}
		} else {
			throw new OrderNotFoundException();
		}
    }

	public static List<TbOrderdetail> getOrderdetailListByOrderIdForCustomer(
            String orderId, String customerName) throws CustomerNotFoundException, OrderNotFoundException {
		TbOrder order = getOrderByOrderId(orderId);
		if (CustomerService.isOrderBelongToCustomer(order, customerName)) {
			return order.getTbOrderdetails();
		} else {
			throw new OrderNotFoundException();
		}
    }

	public static void confirmDeliveryByOrderIdForCustomer(String orderId,
            String customerName) {
		TbOrder order = getOrderByOrderId(orderId);
	    if (CustomerService.isOrderBelongToCustomer(order, customerName) 
	    		&& order.getOrderStatus().equals(HAS_DELEVERY)) {
	    	order.setOrderStatus(CONFIRM_DELIVERY);
	    	getTbOrderProvider().updateOrder(order);
	    	TbCustomer customer = CustomerService.getCustomerByCustomerName(customerName);
	    	customer.setPoints(customer.getPoints() + order.getTotalPrice()/100);
	    	CustomerService.updateCustomer(customer);
	    } else {
	    	throw new OrderNotFoundException();
	    }
    }

	public static void updateOrder(TbOrder order) {
	    getTbOrderProvider().updateOrder(order);
    }
	public static List<TbOrder> getOrderList() throws OrderNotFoundException {
		return getTbOrderProvider().getOrderList();
	}
	public static List<TbOrderdetail> getOrdertailListByOrderId(String orderId) throws OrderNotFoundException {
		return getTbOrderProvider().getOrdertailListByOrderId(orderId);
	}
	@SuppressWarnings("unchecked")
	public static List<TbOrder> searchOrder(String keyword) {
		return SearchUtil.searchForKeyword(keyword.split("\\s+"), "TbOrder",
				new String[]{"OrderID", "CustomerName"});
	}
}
