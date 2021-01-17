package com.gumzima.shopping.controller.admin;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.model.common.FileManager;
import com.gumzima.shopping.model.domain.Recipe;
import com.gumzima.shopping.model.domain.RecipeSearch;
import com.gumzima.shopping.model.product.service.ProductService;
import com.gumzima.shopping.model.recipe.service.R_categoryService;
import com.gumzima.shopping.model.recipe.service.RecipeService;
@Controller
public class AdminRecipeController implements ServletContextAware{
	@Autowired
	private R_categoryService r_categoryService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private RecipeService recipeService;
	
	@Autowired
	private FileManager fileManager;
	
	private ServletContext servletContext;
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext=servletContext;
		fileManager.setSaveFoodDir(servletContext.getRealPath(fileManager.getSaveFoodDir()));
	}
	
	@RequestMapping(value="/admin/recipe/registform", method=RequestMethod.GET)
	public ModelAndView getRecipeCategoryList(HttpServletRequest request) {
		ModelAndView mav=new ModelAndView();
		List categoryList=r_categoryService.selectAll();
		mav.addObject("categoryList", categoryList);
		List productList=productService.selectAll();
		mav.addObject("productList", productList);
		mav.setViewName("admin/recipe/regist_form");
		return mav; 
	}
	
	@RequestMapping(value="/admin/recipe/regist", method=RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String recipeRegist(HttpServletRequest request, Recipe recipe) {
		recipeService.regist(fileManager, recipe);
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"result\":\"1\",");
		sb.append("\"msg\":\"레시피 등록 성공\"");
		sb.append("}");
		return sb.toString();
	}
	
	@RequestMapping(value = "/admin/recipe/list", method = RequestMethod.GET)
	public ModelAndView productList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/recipe/recipe_list");
		List categoryList=r_categoryService.selectAll();
		mav.addObject("categoryList", categoryList);
		List productList=productService.selectAll();
		mav.addObject("productList", productList);
		return mav;
	}
	
	@RequestMapping(value = "/admin/recipe/getRecipe", method = RequestMethod.POST)
	@ResponseBody
	public List getRecipeList(HttpServletRequest request, int r_category_id, String text) {
		RecipeSearch recipeSearch=new RecipeSearch();
		recipeSearch.setR_category_id(r_category_id);
		recipeSearch.setText(text);
		List recipeList=recipeService.selectByOption(recipeSearch);
		return recipeList;
	}
	
	@RequestMapping(value = "/admin/recipe/detail", method = RequestMethod.GET)
	public ModelAndView getDetail(HttpServletRequest request, int recipe_id) {
		ModelAndView mav = new ModelAndView("admin/recipe/recipe_detail");
		List categoryList=r_categoryService.selectAll();
		mav.addObject("categoryList", categoryList);
		List productList=productService.selectAll();
		mav.addObject("productList", productList);
		Recipe recipe=recipeService.select(recipe_id);
		mav.addObject("recipe", recipe);
		List selectProductList=recipeService.selectProductIDByRecipe(recipe_id);
		mav.addObject("selectProductList", selectProductList);
		return mav;
	}
	
	@RequestMapping(value="/admin/recipe/edit", method=RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String edit(HttpServletRequest request, Recipe recipe, String basicRepImg, String[] delBasicRepImg) {
		recipeService.update(fileManager, recipe, basicRepImg, delBasicRepImg);
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"result\":\"1\",");
		sb.append("\"msg\":\"상품 수정 성공\"");
		sb.append("}");
		return sb.toString();
	}
	
	@RequestMapping(value="/admin/recipe/del", method=RequestMethod.GET, produces = "text/html;charset=utf-8")
	public String delete(HttpServletRequest request, int recipe_id) {
		recipeService.delete(fileManager, recipe_id);
		return "redirect:/admin/recipe/list";
	}
}
