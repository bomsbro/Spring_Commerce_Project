package com.gumzima.shopping.model.domain;

import java.util.List;

import lombok.Data;

@Data
public class Orders {
	//주문 기본 정보 7칼럼
	private int orders_id;
	private int member_id;//fk
	private int paymethod_id;//fk
	private int order_status_id;//fk
	
	private Member member;
	private Paymethod paymethod;
	private OrderStatus orderStatus;
	
	private List<OrderDetail> order_detail_list;
	
	private String order_date;
	private int order_price;
	private int delivery_price;
	private int discount_price;
	private int total_price;
	
	//배송결제정보 3칼럼
	private String money_sender;
	private String invoice_number;
	private String shipment_date;

	//수취인 정보 7칼럼
	private String receiver_name;
	private String receiver_cellphone;
	private String receiver_postcode;
	private String receiver_address1;
	private String receiver_address2;
	private String receiver_request;
	private String receiver_cancle_reason; 
}
