package com.gumzima.shopping.exception;

public class MemberNotFoundException extends RuntimeException{

	//  CRUD 작업 시 발생되는 예외
	public MemberNotFoundException(String msg) {
		super(msg);
	}
	
	public MemberNotFoundException(String msg,Throwable e) {
		super(msg,e);
	}
}
