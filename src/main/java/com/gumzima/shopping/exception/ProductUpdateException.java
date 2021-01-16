package com.gumzima.shopping.exception;

public class ProductUpdateException extends RuntimeException{
	public ProductUpdateException(String msg) {
		super(msg);
	}
	
	public ProductUpdateException(String msg, Throwable e) {
		super(msg, e);
	}
}
