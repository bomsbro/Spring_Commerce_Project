package com.gumzima.shopping.model.orders.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.exception.OrderDetailRegistException;
import com.gumzima.shopping.model.domain.OrderDetail;

@Repository
public class MybatisOrderDetailDAO implements OrderDetailDAO{	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectAllById(int orders_id) {
		// TODO Auto-generated method stub
		System.out.println(orders_id);
		return sqlSessionTemplate.selectList("OrderDetail.selectAllById", orders_id);
	}

	@Override
	public OrderDetail select(int order_detail_id) {
		// TODO Auto-generated method stub
		return null;
	}

	public void insert(OrderDetail orderDetail) throws OrderDetailRegistException{
		int result = sqlSessionTemplate.insert("OrderDetail.insert", orderDetail);
		if(result==0) {
			throw new OrderDetailRegistException("상품 상세정보 등록실패");
		}
	}

	@Override
	public void update(OrderDetail orderDetail) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int Order_detail_id) {
		// TODO Auto-generated method stub
		
	}


}
