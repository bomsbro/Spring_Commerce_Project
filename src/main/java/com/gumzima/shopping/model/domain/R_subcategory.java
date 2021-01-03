package com.gumzima.shopping.model.domain;

//@viniyoon

public class R_subcategory {
	private int r_subcategory_id;
	private int r_topcategory_id;
	private String name;
	
	public int getR_subcategory_id() {
		return r_subcategory_id;
	}
	public void setR_subcategory_id(int r_subcategory_id) {
		this.r_subcategory_id = r_subcategory_id;
	}
	public int getR_topcategory_id() {
		return r_topcategory_id;
	}
	public void setR_topcategory_id(int r_topcategory_id) {
		this.r_topcategory_id = r_topcategory_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	

}
