package com.gumzima.shopping.model.customer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gumzima.shopping.model.common.MailSender;
import com.gumzima.shopping.model.customer.repository.CustomerDAO;
import com.gumzima.shopping.model.domain.Customer;

@Service
public class CustomerServiceImpl implements CustomerService {
	@Autowired
	private CustomerDAO customerDAO;
	// 메일발송 객체
	@Autowired
	private MailSender mailSender;
	
	public List selectAll() {
		return customerDAO.selectAll();
	}

	
	public Customer select(int customer_id) {
		Customer customer = customerDAO.select(customer_id);
		return customer; 
	}

	// 등록하기 -> 메일발송하기
	public void insert(Customer customer) {
		
		customerDAO.insert(customer);
		String title = customer.getTitle();
		String writer = customer.getWriter()+"@"+customer.getWriter_server();
		String content = customer.getContent();		
		mailSender.send(writer, title, content);
	}

	// 답변보내기
	public void replyMail(Customer customer) {		
		String title = "Re : "+customer.getTitle();
		String writer = customer.getWriter()+"@"+customer.getWriter_server();
		String content = customer.getContent();
		System.out.println("title"+title);
		System.out.println("writer"+writer);
		System.out.println("content"+content);
		mailSender.send(writer, title, content);
		customerDAO.update(customer.getCustomer_id());
		
	}
}
