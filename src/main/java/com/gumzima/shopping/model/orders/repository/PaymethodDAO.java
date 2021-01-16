package com.gumzima.shopping.model.orders.repository;

import java.util.List;

import com.gumzima.shopping.model.domain.Paymethod;

public interface PaymethodDAO {
	public List selectAll(); //모든 상품 
	public List selectById(int subcategory_id); //하위 카테고리에 소속된 모든 상품
	public Paymethod select(int paymethod_id);
	public void insert(Paymethod paymethod);
	public void update(Paymethod paymethod);//주문상태업데이트
	public void delete(int Paymethod_id);
}
