package com.gumzima.shopping.model.recipe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gumzima.shopping.common.FileManager;
import com.gumzima.shopping.model.domain.Product;
import com.gumzima.shopping.model.domain.Recipe;
import com.gumzima.shopping.model.recipe.repository.R_categoryDAO;
import com.gumzima.shopping.model.recipe.repository.RecipeDAO;

@Service
public class R_categoryServiceImpl implements R_categoryService{
	@Autowired
	private R_categoryDAO r_categoryDAO;

	@Autowired
	private RecipeDAO recipeDAO;
	
	@Override
	public List selectAll() {
		return r_categoryDAO.selectAll();
	}
		
}
