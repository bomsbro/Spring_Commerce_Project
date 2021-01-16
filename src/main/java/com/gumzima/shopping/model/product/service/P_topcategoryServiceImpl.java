package com.gumzima.shopping.model.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gumzima.shopping.model.domain.P_topcategory;
import com.gumzima.shopping.model.product.repository.P_TopCategoryDAO;

@Service
public class P_topcategoryServiceImpl implements P_topcategoryService{
	@Autowired
	private P_TopCategoryDAO p_TopCategoryDAO;
	
	@Override
	public List selectAll() {
		return p_TopCategoryDAO.selectAll();
	}

	@Override
	public P_topcategory select(int p_topcategory_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(P_topcategory p_TopCategory) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(P_topcategory p_TopCategory) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int p_topcategory_id) {
		// TODO Auto-generated method stub
		
	}

}
