package com.gumzima.shopping.model.domain;
//@viniyoon

public class Orders {
	private int orders_id;
	private int receiverinfo_id;
	private int member_id;
	private String order_date;
	private String paymethod;
	private String state;
	private int order_price;
	private int delivery_price;
	private int discout_price;
	private int total_price;
	
	public int getOrders_id() {
		return orders_id;
	}
	public void setOrders_id(int orders_id) {
		this.orders_id = orders_id;
	}
	public int getReceiverinfo_id() {
		return receiverinfo_id;
	}
	public void setReceiverinfo_id(int receiverinfo_id) {
		this.receiverinfo_id = receiverinfo_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getPaymethod() {
		return paymethod;
	}
	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getOrder_price() {
		return order_price;
	}
	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}
	public int getDelivery_price() {
		return delivery_price;
	}
	public void setDelivery_price(int delivery_price) {
		this.delivery_price = delivery_price;
	}
	public int getDiscout_price() {
		return discout_price;
	}
	public void setDiscout_price(int discout_price) {
		this.discout_price = discout_price;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	

}
