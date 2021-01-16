package com.gumzima.shopping.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.model.domain.P_topcategory;



@Repository
public class MybatisP_TopCategoryDAO implements P_TopCategoryDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("P_topcategory.selectAll");
	}

	@Override
	public P_topcategory select(int topcategory_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(P_topcategory topCategory) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(P_topcategory topCategory) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int topcategory_id) {
		// TODO Auto-generated method stub
		
	}
	

}
