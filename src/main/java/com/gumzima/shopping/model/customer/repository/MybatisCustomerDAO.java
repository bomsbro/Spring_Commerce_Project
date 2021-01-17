package com.gumzima.shopping.model.customer.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.exception.NoticeException;
import com.gumzima.shopping.model.common.Search;
import com.gumzima.shopping.model.domain.Customer;
import com.gumzima.shopping.model.domain.Notice;

@Repository
public class MybatisCustomerDAO implements CustomerDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	
	public List selectAll() {
		return sqlSessionTemplate.selectList("Customer.selectAll");
	}

	
	public Customer select(int customer_id) {
		return sqlSessionTemplate.selectOne("Customer.select", customer_id);
	}

	
	public void insert(Customer customer) {
		System.out.println("dao:"+customer);
		sqlSessionTemplate.insert("Customer.insert", customer);		
	}

	
	public void update(int customer_id) {
		System.out.println("cus_id:"+customer_id);
		sqlSessionTemplate.update("Customer.update",customer_id);		
	}
	
	
}
