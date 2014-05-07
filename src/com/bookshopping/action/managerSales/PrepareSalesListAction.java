package com.bookshopping.action.managerSales;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Hibernate;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.exception.OrderNotFoundException;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PrepareSalesListAction extends ActionSupport implements ServletRequestAware {
	
	private String Date;
	private int categoryId;
	private HttpServletRequest request;
	
	public String getDate() {
		return Date;
	}
	
	public void setDate(String date) {
		Date = date;
	}
	
	public int getCategoryId() {
		return categoryId;
	}
	
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() throws Exception {
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Date curDate, beginDate, endDate;   //当前天、月头和下月头
		try {
			curDate =sdf.parse(Date);
		} catch (ParseException e) {
			addActionError("日期： " + Date + " 格式错误");
			return INPUT;
		}
		request.setAttribute("Date", sdf.format(curDate));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(curDate);
		calendar.set(Calendar.DATE, 1);
		beginDate = calendar.getTime();
		calendar.add(Calendar.MONTH, 1);
		endDate = calendar.getTime();
		try {
			List<TbOrder> orderList = OrderService.getOrderListBetweenDates(beginDate, endDate);
			Map<TbBooks, Integer[]> booksMap = OrderService.getBooksMapFromOrderListByCategoryId(orderList, categoryId);
			List<TbBooks> booksList = new ArrayList<TbBooks>(booksMap.size());
			List<Integer[]> salesList = new ArrayList<Integer[]>(booksMap.size());
			for (Map.Entry<TbBooks, Integer[]> entry : booksMap.entrySet()) {
				booksList.add(entry.getKey());
				salesList.add(entry.getValue());
				Hibernate.initialize(entry.getKey().getBookName());
			}
			request.setAttribute("booksList", booksList);
			request.setAttribute("salesList", salesList);
			calendar.setTime(curDate);
			calendar.add(Calendar.DATE, 1);   //第二天头
			orderList = OrderService.getOrderListBetweenDates(curDate, calendar.getTime());
			booksMap = OrderService.getBooksMapFromOrderListByCategoryId(orderList, categoryId);
			List<Integer[]> salesList2 = new ArrayList<Integer[]>(booksMap.size());
			for (int i = 0; i < booksList.size(); i++) {
				salesList2.add(new Integer[]{0, 0});
			}
			for (int i = 0; i < booksList.size(); i++) {
				Integer[] temp = booksMap.get(booksList.get(i));
				if (temp != null) {
					salesList2.set(i, temp);
				}
			}
			request.setAttribute("salesList2", salesList2);
		} catch (OrderNotFoundException e) {
		}
		return SUCCESS;
	}

}
