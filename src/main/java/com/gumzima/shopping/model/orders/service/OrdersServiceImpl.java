package com.gumzima.shopping.model.orders.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gumzima.shopping.model.domain.OrderDetail;
import com.gumzima.shopping.model.domain.Orders;
import com.gumzima.shopping.model.member.repository.MemberDAO;
import com.gumzima.shopping.model.orders.repository.OrderDetailDAO;
import com.gumzima.shopping.model.orders.repository.OrderStatusDAO;
import com.gumzima.shopping.model.orders.repository.OrdersDAO;
import com.gumzima.shopping.model.orders.repository.PaymethodDAO;



@Service
public class OrdersServiceImpl implements OrdersService{
	private static final Logger logger=LoggerFactory.getLogger(OrdersServiceImpl.class);

	@Autowired
	private OrdersDAO ordersDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private PaymethodDAO paymethodDAO;
	
	@Autowired
	private OrderStatusDAO orderStatusDAO;
	
	@Autowired
	private OrderDetailDAO orderDetailDAO;
	
	@Autowired
	private OrderStatusDAO orderstatusDAO;
 
	@Override
	public List selectAll() {
		
		List<Orders> ordersList = ordersDAO.selectAll();
		
		for(int i=0; i<ordersList.size(); i++) {
			ordersList.get(i).setMember(memberDAO.select(ordersList.get(i).getMember_id()));
			ordersList.get(i).setPaymethod(paymethodDAO.select(ordersList.get(i).getPaymethod_id()));
			System.out.println(ordersList.get(i).getOrder_status_id());
			ordersList.get(i).setOrderStatus(orderStatusDAO.select(ordersList.get(i).getOrder_status_id()));
		}

		return ordersList;
	}
	
	@Override
	public Orders getDescription(int orders_id) {
		Orders orders = ordersDAO.selectOne(orders_id);
		orders.setMember(memberDAO.select(orders.getMember_id()));
		List<OrderDetail> order_detail_list=orderDetailDAO.selectAllById(orders_id);
		orders.setOrder_detail_list(order_detail_list);
		return orders;
	}
	
	@Override
	public void updateStatus(List<Integer> chkArr, List<Integer> selArr) {
		for(int i=0; i<chkArr.size(); i++) {
			Orders orders=new Orders();
			orders.setOrders_id(chkArr.get(i));
			orders.setOrder_status_id(selArr.get(i));
			ordersDAO.update(orders);
		}
	}
	
	@Override
	public void deleteOrders(List<Integer> ordersIdList) {
		// TODO Auto-generated method stub
		for(int i=0; i<ordersIdList.size(); i++){
			ordersDAO.delete(ordersIdList.get(i));
		}
	}

	@Override
	public List selectById(int member_id) {
		// TODO Auto-generated method stub
		return ordersDAO.selectById(member_id);
	}

	@Override
	public Orders select(int orders_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(Orders orders) {
		ordersDAO.update(orders);
	}

	@Override
	public void delete(int orders_id) {
		// TODO Auto-generated method stub
		
	}

}
