package com.gumzima.shopping.exception;

public class MailSendException extends RuntimeException{

	//  CRUD 작업 시 발생되는 예외
	public MailSendException(String msg) {
		super(msg);
	}
	
	public MailSendException(String msg,Throwable e) {
		super(msg,e);
	}
}
