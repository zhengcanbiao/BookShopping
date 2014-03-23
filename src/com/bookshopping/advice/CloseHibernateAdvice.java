package com.bookshopping.advice;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;

import com.bookshopping.utils.HibernateUtil;

@Aspect
public class CloseHibernateAdvice {
	@AfterReturning("execution(* com.bookshopping.action..execute(..))")
	public void afterExecute() {
		HibernateUtil.closeCurrentSession();
	}
	
	@AfterReturning("execution(* com.bookshopping.action..validate(..))")
	public void afterValidate() {
		HibernateUtil.closeCurrentSession();
	}
}
