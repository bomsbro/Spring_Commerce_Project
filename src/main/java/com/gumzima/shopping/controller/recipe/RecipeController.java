package com.gumzima.shopping.controller.recipe;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.exception.ProductRegistException;
import com.gumzima.shopping.model.common.FileManager;
import com.gumzima.shopping.model.domain.Product;
import com.gumzima.shopping.model.domain.Recipe;
import com.gumzima.shopping.model.domain.RecipeSearch;
import com.gumzima.shopping.model.domain.SearchText;
import com.gumzima.shopping.model.product.service.ProductService;
import com.gumzima.shopping.model.recipe.repository.Recipe_ProductDAO;
import com.gumzima.shopping.model.recipe.service.R_categoryService;
import com.gumzima.shopping.model.recipe.service.RecipeService;

@Controller
public class RecipeController{
	@Autowired
	private R_categoryService r_categoryService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private RecipeService recipeService;
	
	@Autowired
	private FileManager fileManager;
	
	private ServletContext servletContext;
	
	/*-------------------------------------------------------------------------
	 * 이용자 페이지
	 *----------------------------------------------------------------------- */
	
	@GetMapping(value="/shop/recipe/list")
	public ModelAndView getrecipeList() {
		ModelAndView mav= new ModelAndView("shop/recipe/recipe_list");
		List categoryList=r_categoryService.selectAll();
		mav.addObject("categoryList", categoryList);
		List productList=productService.selectAll();
		mav.addObject("productList", productList);		
		return mav;
	}
	
	@RequestMapping(value = "/admin/shop/getShopRecipe", method = RequestMethod.POST)
	@ResponseBody
	public List getShopRecipeList(int r_category_id, String text) {
		RecipeSearch recipeSearch=new RecipeSearch();
		recipeSearch.setR_category_id(r_category_id);
		recipeSearch.setText(text);
		List recipeList=recipeService.selectByOption(recipeSearch);
		return recipeList;
	}
	
	@RequestMapping(value="/shop/recipe/detail", method=RequestMethod.GET)
	public ModelAndView detail(int recipe_id) {
		ModelAndView mav = new ModelAndView("shop/recipe/detail");
		Recipe recipe=recipeService.select(recipe_id);
		mav.addObject("recipe", recipe);
		List productList=recipeService.selectProductByRecipe(recipe_id);
		mav.addObject("productList", productList);
		return mav;
	}
}
