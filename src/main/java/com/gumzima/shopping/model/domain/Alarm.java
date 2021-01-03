package com.gumzima.shopping.model.domain;

//@viniyoon

public class Alarm {
	private int alarm_id;
	private String uri;
	private char ischeck;
	
	public int getAlarm_id() {
		return alarm_id;
	}
	public void setAlarm_id(int alarm_id) {
		this.alarm_id = alarm_id;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public char getIscheck() {
		return ischeck;
	}
	public void setIscheck(char ischeck) {
		this.ischeck = ischeck;
	}

}
