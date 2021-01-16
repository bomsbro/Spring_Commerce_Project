package com.gumzima.shopping.model.orders.repository;

import java.util.List;

import com.gumzima.shopping.model.domain.Orders;

public interface OrdersDAO {
	public List selectAll(); //모든 상품 
	public List selectById(int member_id); //하위 카테고리에 소속된 모든 상품
	public Orders selectOne(int orders_id);
	public int insert(Orders orders);
	public void update(Orders orders);//주문상태업데이트
	public void delete(int orders_id);
}
