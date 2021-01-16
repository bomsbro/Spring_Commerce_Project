package com.gumzima.shopping.model.recipe.repository;

import java.util.List;

import com.gumzima.shopping.model.domain.Recipe;

public interface Recipe_ProductDAO {
	public List selectAll();
	
	public List selectProductByRecipe(int recipe_id);
	
	public List selectRecipeByProduct(int product_id);
	
	public void insert(Recipe recipe);
	
	public void delete(int recipe_id);
}
