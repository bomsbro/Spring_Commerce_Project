package com.gumzima.shopping.model.domain;

//@viniyoon

public class P_subcategory {
	
	private int p_sucbcategory_id;
	private int p_topcategory_id;
	private String name;
	
	public int getP_sucbcategory_id() {
		return p_sucbcategory_id;
	}
	public void setP_sucbcategory_id(int p_sucbcategory_id) {
		this.p_sucbcategory_id = p_sucbcategory_id;
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
