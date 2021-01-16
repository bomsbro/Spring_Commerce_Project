package com.gumzima.shopping.model.product.service;

import java.util.List;

import com.gumzima.shopping.model.domain.P_subcategory;

public interface P_subcategoryService {
public List selectAll();

public List selectAllById(int p_topcategory_id);

public P_subcategory select(int p_subcategory_id);

public void insert(P_subcategory p_subcategory);

public void update(P_subcategory p_subcategory);

public void delete(int p_subcategory_id);
}
