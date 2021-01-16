package com.gumzima.shopping.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//@viniyoon
@Data
public class Recipe {
	private int recipe_id;
	private int r_category_id;
	private String title;
	private String content;
	private String cooking_time;
	private String filename;
	private String regdate;
	private int hit;
	
	private MultipartFile foodImg;
	private List<Integer> materialList;
	private int product_id;
	
	private List<Product> productList;
}
