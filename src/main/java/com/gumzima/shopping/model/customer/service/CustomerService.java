package com.gumzima.shopping.model.customer.service;

import java.util.List;

import com.gumzima.shopping.model.domain.Customer;
import com.gumzima.shopping.model.domain.Notice;


public interface CustomerService {
	public List selectAll();
	public Customer select(int customer_id);
	public void insert(Customer customer);	
	//처리여부
	public void replyMail(Customer customer);	
}
