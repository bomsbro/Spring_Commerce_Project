package com.gumzima.shopping.model.product.repository;

import java.util.List;

import com.gumzima.shopping.model.domain.P_subcategory;

public interface P_SubCategoryDAO {
	public List selectAll(); // 모든 레코드 가져오기

	public List selectAllById(int p_topcategory_id);// 선택한 상위 카테고리에 소속된 하위 카테고리 목록 가져오기

	public P_subcategory select(int p_subcategory_id);

	public void insert(P_subcategory p_subcategory);

	public void update(P_subcategory p_subcategory);

	public void delete(int p_subcategory_id);
}
