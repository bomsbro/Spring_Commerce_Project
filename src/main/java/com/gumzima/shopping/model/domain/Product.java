package com.gumzima.shopping.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Product {
	private int product_id;
	private P_subcategory p_subcategory;
	private String product_name;
	private int price;
	private String detail;
	private String filename;
	private int hit;
	private int stock;
	private String regdate;
	
	private MultipartFile repImg;
	private MultipartFile[] addImg;
	
	private Score score;
	private List<Image> imageList;
	private List<Recipe> recipeList;
}
