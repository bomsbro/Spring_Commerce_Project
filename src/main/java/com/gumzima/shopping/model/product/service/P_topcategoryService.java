package com.gumzima.shopping.model.product.service;

import java.util.List;

import com.gumzima.shopping.model.domain.P_topcategory;

public interface P_topcategoryService {
public List selectAll();
	
	public P_topcategory select(int p_topcategory_id);
	
	public void insert(P_topcategory p_TopCategory);
	
	public void update(P_topcategory p_TopCategory);
	
	public void delete(int p_topcategory_id);
}
