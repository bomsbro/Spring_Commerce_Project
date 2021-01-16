package com.gumzima.shopping.model.recipe.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.model.domain.Recipe;

@Repository
public class MybatisRecipe_ProductDAO implements Recipe_ProductDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Recipe_Product.selectAll");
	}

	@Override
	public List selectProductByRecipe(int recipe_id) {
		return sqlSessionTemplate.selectList("Recipe_Product.selectProductByRecipe", recipe_id);
	}
	
	public List selectRecipeByProduct(int product_id) {
		return sqlSessionTemplate.selectList("Recipe_Product.selectRecipeByProduct", product_id);
	}

	public void insert(Recipe recipe) {
		sqlSessionTemplate.insert("Recipe_Product.insert", recipe);
	}

	@Override
	public void delete(int recipe_id) {
		sqlSessionTemplate.delete("Recipe_Product.delete", recipe_id);
	}
}
