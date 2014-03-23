package com.bookshopping.utils;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

public class HibernateUtil {
	public static ThreadLocal<Session> currentSession = new ThreadLocal<Session>();
	public static SessionFactory sessionFactory;

	private HibernateUtil() {
	}
	
	public static SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public static Session getCurrentSession() {
		Session s = (Session) currentSession.get();
		if (s == null) {
			s = sessionFactory.openSession();
			currentSession.set(s);
		}
		return s;
	}
	
	public static void closeCurrentSession() {
		Session s = (Session) currentSession.get();
		if (s != null)
			s.close();
		currentSession.set(null);
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public static Object executeQueryForUniqueResult(String hql,
	        Object[] parameters) {
		Session s = null;
		Object obj = null;
		s = HibernateUtil.getCurrentSession();
		Query query = s.createQuery(hql);
		if (parameters != null && parameters.length > 0) {
			for (int i = 0; i < parameters.length; i++) {
				query.setParameter(i, parameters[i]);
			}
		}
		obj = query.uniqueResult();
		s.flush();
		return obj;
	}

	@SuppressWarnings("rawtypes")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public static List executeQueryForMultiResults(String hql,
	        Object[] parameters) {
		Session s = null;
		List list = null;
		s = HibernateUtil.getCurrentSession();
		
		Query query = s.createQuery(hql);
		if (parameters != null && parameters.length > 0) {
			for (int i = 0; i < parameters.length; i++) {
				query.setParameter(i, parameters[i]);
			}
		}
		list = query.list();
		s.flush();
		return list;
	}

	@SuppressWarnings("rawtypes")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public static List executeQueryWithPage(String hql, Object[] parameters,
	        int pageSize, int pageNow) {
		Session s = null;
		List list = null;
		s = HibernateUtil.getCurrentSession();
		Query query = s.createQuery(hql);
		if (parameters != null && parameters.length > 0) {
			for (int i = 0; i < parameters.length; i++) {
				query.setParameter(i, parameters[i]);
			}
		}
		query.setFirstResult((pageNow - 1) * pageSize).setMaxResults(pageSize);
		list = query.list();
		s.flush();
		return list;
	}

	@Transactional(propagation=Propagation.REQUIRED)
	public static void add(Object obj) {
		Session s = null;
		s = HibernateUtil.getCurrentSession();
		s.save(obj);
		s.flush();
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public static void update(Object obj) {
		Session s = null;
		s = HibernateUtil.getCurrentSession();
		s.update(obj);
		s.flush();
	}

	@SuppressWarnings("rawtypes")
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true, rollbackFor=Exception.class)
	public static Object get(Class clazz, Serializable id) {
		Session s = null;
		s = HibernateUtil.getCurrentSession();
		Object obj = s.get(clazz, id);
		s.flush();
		return obj;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public static void delete(Object obj) {
		Session s = null;
		s = HibernateUtil.getCurrentSession();
		s.delete(obj);
		s.flush();
	}

	static {
		sessionFactory = (SessionFactory) SpringUtil
		        .getBeanById("sessionFactory");
	}
}
