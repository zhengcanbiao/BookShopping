package com.bookshopping.dao.provider;

import java.util.List;

import com.bookshopping.dao.provider.inter.AbstractTbAdminProvider;
import com.bookshopping.domain.TbAdmin;
import com.bookshopping.exception.AdminNotFoundException;
import com.bookshopping.utils.HibernateUtil;

public class TbAdminProvider implements AbstractTbAdminProvider{
	
	@Override
	public void addAdmin(TbAdmin admin) {
		HibernateUtil.add(admin);
	}
	
	@Override
	public void updateAdmin(TbAdmin Admin) {
		HibernateUtil.update(Admin);
	}
	
	@Override
	public TbAdmin getAdminByAdminName(String AdminName) throws AdminNotFoundException {
		TbAdmin admin = (TbAdmin) HibernateUtil.get(TbAdmin.class, AdminName);
		if (admin == null) {
			throw new AdminNotFoundException();
		} else {
			return admin;
		}
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<TbAdmin> getAdminList() throws AdminNotFoundException {
		List<TbAdmin> list = HibernateUtil.executeQueryForMultiResults("from TbAdmin", null);
		if (list == null) {
			throw new AdminNotFoundException();
		} else {
			return list;
		}
	}

}
