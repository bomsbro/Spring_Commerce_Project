package com.gumzima.shopping.exception;

public class MemberRegistException extends RuntimeException{

	//  CRUD 작업 시 발생되는 예외
	public MemberRegistException(String msg) {
		super(msg);
	}
	
	public MemberRegistException(String msg,Throwable e) {
		super(msg,e);
	}
}
