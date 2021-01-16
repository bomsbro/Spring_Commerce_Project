package com.gumzima.shopping.model.domain;

//@viniyoon

public class P_subcategory {
	
	private int p_subcategory_id;
	private int p_topcategory_id;
	private String name;
	
	public int getP_subcategory_id() {
		return p_subcategory_id;
	}
	public void setP_subcategory_id(int p_subcategory_id) {
		this.p_subcategory_id = p_subcategory_id;
	}
	public int getP_topcategory_id() {
		return p_topcategory_id;
	}
	public void setP_topcategory_id(int p_topcategory_id) {
		this.p_topcategory_id = p_topcategory_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	

}
