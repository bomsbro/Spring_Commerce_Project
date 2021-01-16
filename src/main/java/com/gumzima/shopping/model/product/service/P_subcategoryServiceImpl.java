package com.gumzima.shopping.model.product.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gumzima.shopping.model.domain.P_subcategory;
import com.gumzima.shopping.model.product.repository.P_SubCategoryDAO;

@Service
public class P_subcategoryServiceImpl implements P_subcategoryService{
	@Autowired
	private P_SubCategoryDAO p_subcategoryDAO;
	
	@Override
	public List selectAll() {
		return p_subcategoryDAO.selectAll();
	}

	@Override
	public List selectAllById(int p_topcategory_id) {
		return p_subcategoryDAO.selectAllById(p_topcategory_id);
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
