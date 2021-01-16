package com.gumzima.shopping.exception;

public class ImageDeleteException extends RuntimeException{
	public ImageDeleteException(String msg) {
		super(msg);
	}
	
	public ImageDeleteException(String msg, Throwable e) {
		super(msg, e);
	}
}
