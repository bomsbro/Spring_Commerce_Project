package com.gumzima.shopping.model.domain;

public class Receiverinfo {
	
	//@viniyoon
	
	private int receiverinfo_id;
	private int member_id;
	private String r_name;
	private String r_phone;
	private String r_addr;
	private String r_addr_detail;
	private char isdefault;
	public int getReceiverinfo_id() {
		return receiverinfo_id;
	}
	public void setReceiverinfo_id(int receiverinfo_id) {
		this.receiverinfo_id = receiverinfo_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getR_name() {
		return r_name;
	}
	public void setR_name(String r_name) {
		this.r_name = r_name;
	}
	public String getR_phone() {
		return r_phone;
	}
	public void setR_phone(String r_phone) {
		this.r_phone = r_phone;
	}
	public String getR_addr() {
		return r_addr;
	}
	public void setR_addr(String r_addr) {
		this.r_addr = r_addr;
	}
	public String getR_addr_detail() {
		return r_addr_detail;
	}
	public void setR_addr_detail(String r_addr_detail) {
		this.r_addr_detail = r_addr_detail;
	}
	public char getIsdefault() {
		return isdefault;
	}
	public void setIsdefault(char isdefault) {
		this.isdefault = isdefault;
	}
	
}
