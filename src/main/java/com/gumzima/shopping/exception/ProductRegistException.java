package com.gumzima.shopping.exception;

public class ProductRegistException extends RuntimeException{
	public ProductRegistException(String msg) {
		super(msg);
	}
	
	public ProductRegistException(String msg, Throwable e) {
		super(msg, e);
	}
}
