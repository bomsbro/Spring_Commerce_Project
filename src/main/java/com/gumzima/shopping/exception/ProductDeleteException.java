package com.gumzima.shopping.exception;

public class ProductDeleteException extends RuntimeException{
	public ProductDeleteException(String msg) {
		super(msg);
	}
	
	public ProductDeleteException(String msg, Throwable e) {
		super(msg, e);
	}
}
