package com.gumzima.shopping.model.orders.repository;

import java.util.List;

import com.gumzima.shopping.model.domain.OrderStatus;

public interface OrderStatusDAO {
	public List selectAll(); //모든 상품 
	public List selectById(int subcategory_id); //하위 카테고리에 소속된 모든 상품
	public OrderStatus select(int order_status_id);
	public void insert(OrderStatus orderStatus);
	public void update(OrderStatus orderStatus);//주문상태업데이트
	public void delete(int Order_status_id);
}
