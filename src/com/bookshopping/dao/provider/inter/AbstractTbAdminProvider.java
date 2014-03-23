package com.bookshopping.dao.provider.inter;

import java.util.List;

import com.bookshopping.domain.TbAdmin;
import com.bookshopping.exception.AdminNotFoundException;

public interface AbstractTbAdminProvider {
	public void updateAdmin(TbAdmin admin);

	void addAdmin(TbAdmin admin);

	TbAdmin getAdminByAdminName(String AdminName) throws AdminNotFoundException;

	List<TbAdmin> getAdminList() throws AdminNotFoundException;
}
