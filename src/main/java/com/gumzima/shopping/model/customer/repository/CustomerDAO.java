package com.gumzima.shopping.model.customer.repository;

import java.util.List;
import java.util.Map;

import com.gumzima.shopping.model.common.Search;
import com.gumzima.shopping.model.domain.Customer;
import com.gumzima.shopping.model.domain.Notice;


public interface CustomerDAO {
	public List selectAll();
	public Customer select(int customer_id);	
	public void insert(Customer customer);	
	// 처리여부
	public void update(int custover_id);
}
