package com.bookshopping.action.managerSales;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.data.category.DefaultCategoryDataset;

import com.bookshopping.domain.TbBooks;
import com.bookshopping.domain.TbOrder;
import com.bookshopping.domain.TbOrderdetail;
import com.bookshopping.exception.CategoryNotFoundException;
import com.bookshopping.service.BooksService;
import com.bookshopping.service.OrderService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class PrepareSalesChartAction extends ActionSupport implements ServletRequestAware {
	
	private String beginDate;
	private String endDate;
	private String booksId;
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


	public String getBooksId() {
		return booksId;
	}

	public void setBooksId(String booksId) {
		this.booksId = booksId;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	@Override
	public String execute() throws Exception {
		int Id;
		TbBooks books;
		try {
			Id = Integer.parseInt(booksId);
			books = BooksService.getBooksByBooksId(Id);
		} catch (NumberFormatException e) {
			addActionError("booksId： " + booksId + " 格式错误");
			return INPUT;
		} catch (CategoryNotFoundException e) {
			addActionError("booksId： " + booksId + " 不存在");
			return INPUT;
		}
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Date date1, date2;
		try {
			date1 =sdf.parse(beginDate);
			date2 =sdf.parse(endDate);
		} catch (ParseException e) {
			addActionError("日期： " + beginDate + " 或 " + endDate + " 错误");
			return INPUT;
		}
		GregorianCalendar beginCalendar = new GregorianCalendar();
		beginCalendar.setTime(date1);
		GregorianCalendar endCalendar = new GregorianCalendar();
		endCalendar.setTime(date2);
		//beginDate到endDate中每月1日的列表，不包括endDate当月
		List<Date> dateList = new ArrayList<Date>(0);
		while (beginCalendar.before(endCalendar)) {
			dateList.add(beginCalendar.getTime());
			beginCalendar.add(Calendar.MONTH, 1);
		}
		List<TbOrder> orderList = OrderService.getOrderListBetweenDates(date1, date2);
		int salesList[] = new int[dateList.size()];//每一个订单日期对应的量
		for (TbOrder order : orderList) {
			Date orderDate = new Date(order.getOrderTime().getTime());
			//循环判断此订单所处日期是在每月1日的列表中的哪一个月份
			int index = 1;
			for (; index < salesList.length; index++) {
				if (orderDate.compareTo(dateList.get(index)) < 0) {
					break;
				}
			}
			List<TbOrderdetail> orderDetailList = OrderService.getOrdertailListByOrderId(order.getOrderId());
			for (TbOrderdetail orderDetail : orderDetailList) {
				if (orderDetail.getTbBooks().getBooksId() == Id) {
					salesList[index-1] += orderDetail.getQuantity();
				}
			}
		}
		DefaultCategoryDataset lineDataset = new DefaultCategoryDataset();
		sdf= new SimpleDateFormat("yyyy年MM月");
		for (int i = 0; i < salesList.length; i++) {
			lineDataset.addValue(salesList[i], books.getBookName(), sdf.format(dateList.get(i)));
		}
		JFreeChart chart = ChartFactory.createLineChart("书销售量", // chart title
			    "时间", // domain axis label
			    "销售额", // range axis label
			    lineDataset, // data
			    PlotOrientation.VERTICAL, // orientation
			    true, // include legend
			    true, // tooltips
			    false // urls
			    );
		CategoryPlot plot = chart.getCategoryPlot();   //获得图表区域对象
		CategoryAxis domainAxis = plot.getDomainAxis();
		domainAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45);   //X轴上的Lable让其45度倾斜 
		NumberAxis numberAxis = (NumberAxis) plot.getRangeAxis();
		DecimalFormat decimalFormat = new DecimalFormat("0");
		numberAxis.setNumberFormatOverride(decimalFormat);   //纵坐标显示整数
		//ServletUtilities是面向web开发的工具类，返回一个字符串文件名,文件名自动生成，生成好的图片会自动放在服务器（tomcat）的临时文件下（temp）
		String fileName = ServletUtilities.saveChartAsPNG(chart, 800, 600, request.getSession()); 
		//根据文件名去临时目录下寻找该图片，这里的/DisplayChart路径要与配置文件里用户自定义的<url-pattern>一致
	    String url = request.getContextPath() + "/DisplayChart?filename=" + fileName;
	    request.setAttribute("picUrl", url);
		return SUCCESS;
	}

}
