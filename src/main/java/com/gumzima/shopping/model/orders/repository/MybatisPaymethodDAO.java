package com.gumzima.shopping.model.orders.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.model.domain.Orders;
import com.gumzima.shopping.model.domain.Paymethod;

@Repository
public class MybatisPaymethodDAO implements PaymethodDAO{	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("Paymethod.selectAll");
	}

	@Override
	public List selectById(int subcategory_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Paymethod select(int paymethod_id) {
		return sqlSessionTemplate.selectOne("Paymethod.select", paymethod_id);
	}

	@Override
	public void insert(Paymethod paymethod) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Paymethod paymethod) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int Paymethod_id) {
		// TODO Auto-generated method stub
		
	}


}
