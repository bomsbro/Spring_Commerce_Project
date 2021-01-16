package com.gumzima.shopping.model.orders.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gumzima.shopping.model.domain.OrderStatus;
import com.gumzima.shopping.model.orders.repository.OrderStatusDAO;



@Service
public class OrderStatusServiceImpl implements OrderStatusService{
	private static final Logger logger=LoggerFactory.getLogger(OrderStatusServiceImpl.class);
	
	@Autowired
	private OrderStatusDAO orderStatusDAO;
	
	@Override
	public List selectAll() {
		return orderStatusDAO.selectAll();
	}

	@Override
	public OrderStatus select(int orderStatus_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(OrderStatus orderStatus) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int order_status_id) {
		// TODO Auto-generated method stub
		
	}
	
}
