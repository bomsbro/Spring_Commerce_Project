package com.gumzima.shopping.exception;

public class parseException extends RuntimeException{

	//  CRUD 작업 시 발생되는 예외
	public parseException(String msg) {
		super(msg);
	}
	
	public parseException(String msg,Throwable e) {
		super(msg,e);
	}
}
