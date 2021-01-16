package com.gumzima.shopping.exception;

public class ImageRegistException extends RuntimeException{
	public ImageRegistException(String msg) {
		super(msg);
	}
	
	public ImageRegistException(String msg, Throwable e) {
		super(msg, e);
	}
}
