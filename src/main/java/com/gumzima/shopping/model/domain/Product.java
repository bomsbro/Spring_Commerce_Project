package com.gumzima.shopping.model.domain;

//@viniyoon

public class Product {
	private int product_id;
	private int p_subcategory_id;
	private String product_name;
	private int price;
	private String content;
	private String filename;
	private int hit;
	private int stock;
	private String regdate;
	
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getP_subcategory_id() {
		return p_subcategory_id;
	}
	public void setP_subcategory_id(int p_subcategory_id) {
		this.p_subcategory_id = p_subcategory_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
