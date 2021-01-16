package com.gumzima.shopping.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.model.domain.P_subcategory;

@Repository
public class MybatisP_SubCategoryDAO implements P_SubCategoryDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("P_subcategory.selectAll");
	}

	@Override
	public List selectAllById(int p_topcategory_id) {
		return sqlSessionTemplate.selectList("P_subcategory.selectById", p_topcategory_id);
	}

	@Override
	public P_subcategory select(int p_subcategory_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(P_subcategory p_subcategory) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(P_subcategory p_subcategory) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int p_subcategory_id) {
		// TODO Auto-generated method stub
		
	}

}
