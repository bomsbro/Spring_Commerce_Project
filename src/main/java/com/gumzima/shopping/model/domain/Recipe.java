package com.gumzima.shopping.model.domain;

//@viniyoon

public class Recipe {
	private int recipe_id;
	private int r_subcategory_id;
	private String product_name;
	private String content;
	private String cooking_tiem;
	
	public int getRecipe_id() {
		return recipe_id;
	}
	public void setRecipe_id(int recipe_id) {
		this.recipe_id = recipe_id;
	}
	public int getR_subcategory_id() {
		return r_subcategory_id;
	}
	public void setR_subcategory_id(int r_subcategory_id) {
		this.r_subcategory_id = r_subcategory_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCooking_tiem() {
		return cooking_tiem;
	}
	public void setCooking_tiem(String cooking_tiem) {
		this.cooking_tiem = cooking_tiem;
	}

}
