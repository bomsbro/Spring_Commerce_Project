package com.gumzima.shopping.model.orders.service;

import java.util.List;

import com.gumzima.shopping.model.domain.OrderStatus;

public interface OrderStatusService {
	public List selectAll(); //모든 페이메써드
	public OrderStatus select(int order_status_id);
	public void update(OrderStatus orderStatus);
	public void delete(int order_status_id);
}
