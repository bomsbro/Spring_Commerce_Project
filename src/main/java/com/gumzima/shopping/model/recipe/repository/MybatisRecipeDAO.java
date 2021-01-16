package com.gumzima.shopping.model.recipe.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.model.domain.Recipe;
import com.gumzima.shopping.model.domain.RecipeSearch;

@Repository
public class MybatisRecipeDAO implements RecipeDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Override
	public void insert(Recipe recipe) {
		sqlSessionTemplate.insert("Recipe.insert", recipe);
	}
		
	public List selectByOption(RecipeSearch recipeSearch) {
		return sqlSessionTemplate.selectList("Recipe.selectByCategory", recipeSearch);
	}
	
	public List selectAll() {
		return sqlSessionTemplate.selectList("Recipe.selectAll");
	}

	public List selectAllByText(String text) {
		return sqlSessionTemplate.selectList("Recipe.selectAllByText", text);
	}
	
	public Recipe select(int recipe_id) {
		return sqlSessionTemplate.selectOne("Recipe.select", recipe_id);
	}

	public void update(Recipe recipe) {
		sqlSessionTemplate.update("Recipe.update", recipe);
	}

	public void delete(int recipe_id) {
		sqlSessionTemplate.delete("Recipe.delete", recipe_id);
	}
}
