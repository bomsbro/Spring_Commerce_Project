package com.gumzima.shopping.model.orders.repository;

import java.util.List;

import com.gumzima.shopping.model.domain.OrderDetail;

public interface OrderDetailDAO {
	public List selectAll(); //모든 상품 
	public List selectAllById(int orders_id); //하위 카테고리에 소속된 모든 상품
	public OrderDetail select(int order_detail_id);
	public void insert(OrderDetail orderDetail);
	public void update(OrderDetail orderDetail);//주문상태업데이트
	public void delete(int Order_detail_id);
}
