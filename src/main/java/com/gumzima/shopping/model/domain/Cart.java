package com.gumzima.shopping.model.domain;

import lombok.Data;

@Data
public class Cart extends Product{
	private int cart_id;
	private int member_id;
	private int quantity;
}