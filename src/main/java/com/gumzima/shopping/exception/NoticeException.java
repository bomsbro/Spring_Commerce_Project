package com.gumzima.shopping.exception;

public class NoticeException extends RuntimeException{
	//  CRUD 작업 시 발생되는 예외
	public NoticeException(String msg) {
		super(msg);
	}
	
	public NoticeException(String msg,Throwable e) {
		super(msg,e);
	}
}
