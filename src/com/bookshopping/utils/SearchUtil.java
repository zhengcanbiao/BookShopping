package com.bookshopping.utils;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import com.bookshopping.exception.TargetNotFoundException;

final public class SearchUtil {
	
	private SearchUtil() {
	}

	/**
	 * 
	 * @param keyword 搜索关键字
	 * @param table 要搜索的表名，如TbClothes
	 * @param fields 要搜索的字段数组，如ClothesName、Producer等
	 * @return 搜索结果列表
	 * @throws TargetNotFoundException 找不到结果
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List searchForKeyword(String[] keywords, String table, String[] fields)
			throws TargetNotFoundException {
		//没有设置查询字段
		if (fields.length == 0) {
			throw new TargetNotFoundException();
		}
		
		//0个关键字，默认列出表的所有数据
		if (keywords.length == 0) {
			List result = HibernateUtil.executeQueryForMultiResults("from "+table, null);
			if (result == null) {
				throw new TargetNotFoundException();
			}
			else {
				return result;
			}
		}
		else {
			List result = new ArrayList();
			//hql语句
			String hql = "from " + table + " where " + fields[0] + " like ?";
			for (int i=1; i<fields.length; i++) {
				hql+=" or " + fields[i] + " like ?";
			}
			Object[] obj = new Object[fields.length];
			for (int i=0; i<keywords.length; i++) {
				//加%进行模糊搜索，放在hql参数里面避免hibernate3中文关键字无法解析%符号
				String parm = '%' + keywords[i] + '%';
				for (int j=0; j<fields.length; j++) {
					obj[j] = parm;
				}
				List list = HibernateUtil.executeQueryForMultiResults(hql, obj);
				if(list != null) {
					result.addAll(list);
				}
			}
			if(result.isEmpty()) {
				throw new TargetNotFoundException();
			}
			else {
				HashSet resultSet = new HashSet();
				for (Object o : result) {
					resultSet.add(o);
				}
				return new ArrayList(resultSet);
			}
		}
	}
	
}
