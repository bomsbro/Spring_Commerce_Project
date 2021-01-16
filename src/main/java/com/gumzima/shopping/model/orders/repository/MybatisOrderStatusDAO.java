package com.gumzima.shopping.model.orders.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.model.domain.OrderStatus;
import com.gumzima.shopping.model.domain.Orders;

@Repository
public class MybatisOrderStatusDAO implements OrderStatusDAO{	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("OrderStatus.selectAll");
	}

	@Override
	public List selectById(int subcategory_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public OrderStatus select(int order_status_id) {
		return sqlSessionTemplate.selectOne("OrderStatus.select", order_status_id);
	}

	@Override
	public void insert(OrderStatus orderStatus) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(OrderStatus orderStatus) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int Order_status_id) {
		// TODO Auto-generated method stub
		
	}


}
