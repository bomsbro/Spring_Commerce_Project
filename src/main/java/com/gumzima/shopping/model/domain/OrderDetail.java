package com.gumzima.shopping.model.domain;

import lombok.Data;

//@viniyoon

@Data
public class OrderDetail {
	private int order_detail_id;
	private int orders_id;//fk
	private int product_id;//fk
	private String filename;//fk
	private String product_name;
	private int product_price;
	private int quantity;
}
