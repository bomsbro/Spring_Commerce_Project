package com.gumzima.shopping.model.domain;

import lombok.Data;

@Data
public class Customer {
	private int customer_id;
	private String title;
	private String writer;
	private String writer_server;
	private String content;
	private String regdate;	
	
	// 문의답변 처리여부..
	private int c_ok;
}
