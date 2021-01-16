package com.gumzima.shopping.model.recipe.repository;

import java.util.List;

import com.gumzima.shopping.model.domain.Recipe;
import com.gumzima.shopping.model.domain.RecipeSearch;

public interface RecipeDAO {
	public void insert(Recipe recipe);
		
	public List selectByOption(RecipeSearch recipeSearch);
	
	public List selectAll();
	
	public List selectAllByText(String text);
		
	public Recipe select(int recipe_id);
	
	public void update(Recipe recipe);
	
	public void delete(int recipe_id);
}
