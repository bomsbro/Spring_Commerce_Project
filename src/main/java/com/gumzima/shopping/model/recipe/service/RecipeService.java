package com.gumzima.shopping.model.recipe.service;

import java.util.List;

import com.gumzima.shopping.model.common.FileManager;
import com.gumzima.shopping.model.domain.Recipe;
import com.gumzima.shopping.model.domain.RecipeSearch;

public interface RecipeService {
	public List selectAll();
	
	public void regist(FileManager fileManager, Recipe recipe);
	
	public List selectByOption(RecipeSearch recipeSearch) ;
	
	public Recipe select(int recipe_id);
	
	public List selectProductByRecipe(int recipe_id);
	
	public List selectProductIDByRecipe(int recipe_id);
	
	public List selectRecipeByProduct(int product_id);
	
	public void update(FileManager fileManager, Recipe recipe, String basicRepImg, String[] delBasicRepImg);
	
	public void delete(FileManager fileManager, int recipe_id);
}
