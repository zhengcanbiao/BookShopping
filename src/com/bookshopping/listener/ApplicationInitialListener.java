package com.bookshopping.listener;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.ContextLoaderListener;

import com.bookshopping.domain.TbAdmin;
import com.bookshopping.domain.TbCategory;
import com.bookshopping.domain.TbDiscount;
import com.bookshopping.exception.DiscountNotFoundException;
import com.bookshopping.service.AdminService;
import com.bookshopping.service.CategoryService;
import com.bookshopping.service.DiscountService;
import com.bookshopping.utils.PropertiesLoader;
import com.bookshopping.utils.SHAEncypherUtil;

public class ApplicationInitialListener extends ContextLoaderListener implements ServletContextListener {
	private ServletContext context;

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		super.contextDestroyed(event);
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		super.contextInitialized(event);
		context = event.getServletContext();
		initialUrls();
		initialCategory();
		initialDiscount();
		initAdmin();
	}
	
	private void initialUrls() {
		PropertiesLoader loader;
		try {
	        loader = new PropertiesLoader("urls.properties");
			Enumeration<String> keys = loader.getKeys();
			String key, value;
			while (keys.hasMoreElements()) {
				key = keys.nextElement();
				value = loader.getProperty(key);
				context.setAttribute(key, value);
			}
        } catch (IOException e) {
	        e.printStackTrace();
        }
	}
	
	private void initialCategory() {
		List<TbCategory> list = CategoryService.getTopCategory();
		System.out.println(list);
		//int toIndex = (list.size() > 4) ? 4 : list.size();
		context.setAttribute("topCategoryList", list);
	}
	
	private void initialDiscount() {
		try {
			List<TbDiscount> discountList = DiscountService.getDiscountList();
			System.out.println(discountList);
			context.setAttribute("discountList", discountList);
		} catch (DiscountNotFoundException ex) {
			ex.printStackTrace();
		}
	}
	
	private void initAdmin() {
		try {
			//System.out.println(AdminService.getTbAdminProvider().getAdminList());
			if(AdminService.getTbAdminProvider().getAdminList().isEmpty())
			AdminService.getTbAdminProvider().addAdmin(new TbAdmin("admin", SHAEncypherUtil.encryptSHA("111111")));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}
