package com.gumzima.shopping.exception;

public class OrdersRegistException extends RuntimeException{
	
	public OrdersRegistException(String msg) {
		super(msg);
	}
	public OrdersRegistException(String msg, Throwable e) {
		super(msg, e);
	}
}