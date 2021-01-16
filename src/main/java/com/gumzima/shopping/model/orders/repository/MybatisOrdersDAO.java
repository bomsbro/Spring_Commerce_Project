package com.gumzima.shopping.model.orders.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.exception.OrdersRegistException;
import com.gumzima.shopping.model.domain.Orders;

@Repository
public class MybatisOrdersDAO implements OrdersDAO{	
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Orders.selectAll");
	}

	@Override
	public List selectById(int member_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("Orders.selectById", member_id);
	}

	@Override
	public Orders selectOne(int orders_id) {
		return sqlSessionTemplate.selectOne("Orders.selectOne", orders_id); /*sqlSessionTemplate.selectList("Orders.selectAll")*/
	}
	
	@Override
	public int insert(Orders orders) throws OrdersRegistException{
		int result=sqlSessionTemplate.insert("Orders.insert", orders);
		if(result==0) {
			throw new OrdersRegistException("주문요약 등록실패");
		}
		
		return orders.getOrders_id();
	}

	@Override
	public void update(Orders orders) {
		sqlSessionTemplate.update("Orders.update", orders);
		
	}

	@Override
	public void delete(int orders_id) {
		sqlSessionTemplate.selectOne("Orders.delete", orders_id);
	}
}
