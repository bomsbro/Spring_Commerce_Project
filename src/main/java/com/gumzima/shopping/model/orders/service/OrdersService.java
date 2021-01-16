package com.gumzima.shopping.model.orders.service;

import java.util.List;

import com.gumzima.shopping.model.domain.Orders;

public interface OrdersService {
	public List selectAll(); //모든 상품 
	public List selectById(int member_id); //하위 카테고리에 소속된 모든 상품
	public Orders select(int orders_id);
	public Orders getDescription(int orders_id); //오더스 정보와 상품들 구하기
	public void updateStatus(List<Integer> chkArr,List<Integer> selArr);
	public void deleteOrders(List<Integer> ordersIdList);
	public void update(Orders orders);
	public void delete(int orders_id);
}
