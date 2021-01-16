package com.gumzima.shopping.model.domain;

import java.util.List;

import lombok.Data;

@Data
public class Recipe_Product {
	private int recipe_product_id;
	private int recipe_id;
	private int product_id;
	
	private List<Product> productList;
	private List<Recipe> recipeList;
}
