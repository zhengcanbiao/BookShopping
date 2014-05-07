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
public class PrepareSalesAction extends ActionSupport implements ServletRequestAware {
	
	private String beginDate;
	private String endDate;
	private int categoryId;
	private HttpServletRequest request;
	
	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
		Date date1, date2;
		try {
			date1 =sdf.parse(beginDate);
			date2 =sdf.parse(endDate);
		} catch (ParseException e) {
			addActionError("日期： " + beginDate + " 或 " + endDate + " 错误");
			return INPUT;
		}
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date1);
		calendar.set(Calendar.DATE, 1);
		Date begin = calendar.getTime();
		calendar.setTime(date2);
		calendar.set(Calendar.DATE, 1);
		request.setAttribute("endDate2", sdf.format(calendar.getTime()));
		calendar.add(Calendar.MONTH, 1);//加上一个月
		Date end = calendar.getTime();
		try {
			List<TbOrder> orderList = OrderService.getOrderListBetweenDates(begin, end);
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
			request.setAttribute("beginDate", sdf.format(begin));
			request.setAttribute("endDate", sdf.format(end));
		} catch (OrderNotFoundException e) {
		}
		return SUCCESS;
	}

}
