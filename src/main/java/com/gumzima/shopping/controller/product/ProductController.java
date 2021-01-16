package com.gumzima.shopping.controller.product;

import java.util.List;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.gumzima.shopping.common.FileManager;
import com.gumzima.shopping.exception.ImageRegistException;
import com.gumzima.shopping.exception.ProductDeleteException;
import com.gumzima.shopping.exception.ProductRegistException;
import com.gumzima.shopping.exception.ProductUpdateException;
import com.gumzima.shopping.model.domain.P_subcategory;
import com.gumzima.shopping.model.domain.Product;
import com.gumzima.shopping.model.domain.SearchText;
import com.gumzima.shopping.model.product.service.P_subcategoryService;
import com.gumzima.shopping.model.product.service.P_topcategoryService;
import com.gumzima.shopping.model.product.service.ProductService;
import com.gumzima.shopping.model.recipe.service.RecipeService;

@Controller
public class ProductController  implements ServletContextAware{
	private static final Logger logger=LoggerFactory.getLogger(ProductController.class);
	@Autowired
	private ProductService productService;
	
	@Autowired
	private P_topcategoryService p_topcategoryService;
	
	@Autowired
	private P_subcategoryService p_subcategoryService;
	
	@Autowired
	private RecipeService recipeService;
	
	@Autowired
	private FileManager fileManager;
	
	private ServletContext servletContext;
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext=servletContext;
		//이 타이밍을 놓치지 말고, 실제 물리적 경로를 FileManager에 대입해놓자
		fileManager.setSaveBasicDir(servletContext.getRealPath(fileManager.getSaveBasicDir()));
		fileManager.setSaveAddonDir(servletContext.getRealPath(fileManager.getSaveAddonDir()));
	}
	
	@RequestMapping(value="/admin/product/registform", method=RequestMethod.GET)
	public ModelAndView getTopList() {
		ModelAndView mav=new ModelAndView();
		List topList=p_topcategoryService.selectAll();
		mav.addObject("topList", topList);
		mav.setViewName("admin/product/regist_form");
		return mav; 
	}
	
	@RequestMapping(value = "/admin/product/sublist", method = RequestMethod.GET)
	@ResponseBody
	public List getSubList(int p_topcategory_id) {
		List<P_subcategory> subList = p_subcategoryService.selectAllById(p_topcategory_id);
		return subList;
	}
			
	@RequestMapping(value="/admin/product/category_registform")
	public String categoryRegistForm() {
		return "admin/product/category_regist_form";
	}
	
	@RequestMapping(value="/admin/product/regist", method=RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String productRegist(Product product) throws ProductRegistException {
		productService.regist(fileManager, product); //상품등록
		
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"result\":\"1\",");
		sb.append("\"msg\":\"상품 등록 성공\"");
		sb.append("}");
		return sb.toString();
	}
	
	@RequestMapping(value = "/admin/product/list", method = RequestMethod.GET)
	public ModelAndView productList() {
		ModelAndView mav = new ModelAndView("admin/product/product_list");
		List topList=p_topcategoryService.selectAll();
		mav.addObject("topList", topList);
		return mav;
	}
		
	@RequestMapping(value = "/admin/product/getProduct", method = RequestMethod.POST)
	@ResponseBody
	public List getProductList(@RequestParam(value="subId[]") List<Integer> subId, String text) {
		SearchText searchText = new SearchText();
		searchText.setSubId(subId);
		searchText.setText(text);
		List productList=productService.searchProduct(searchText);
		return productList;
	}
	
	@RequestMapping(value = "/admin/product/detail", method = RequestMethod.GET)
	public ModelAndView getDetail(int product_id) {
		ModelAndView mav = new ModelAndView("admin/product/product_detail");
		List topList=p_topcategoryService.selectAll();
		mav.addObject("topList", topList);
		Product product=(Product)productService.select(product_id);
		mav.addObject("product", product);
		return mav;
	}
	
	@RequestMapping(value="/admin/product/edit", method=RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String edit(Product product, String basicRepImg, String[] delBasicRepImg, String[] delBasicAddImg) {
		productService.update(fileManager, product, basicRepImg, delBasicRepImg, delBasicAddImg);
		
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"result\":\"1\",");
		sb.append("\"msg\":\"상품 수정 성공\"");
		sb.append("}");
		return sb.toString();
	}
	
	@RequestMapping(value="/admin/product/del", method=RequestMethod.GET, produces = "text/html;charset=utf-8")
	public String delete(int product_id) {
		productService.delete(fileManager, product_id);
		return "redirect:/admin/product/list";
	}
	
	/*---------------------------------------------------------------------
	 * 이용자 페이지 상품
	 * --------------------------------------------------------------------*/
	@GetMapping(value="/shop/product/list")
	public ModelAndView getShopProductList() {
		ModelAndView mav= new ModelAndView("shop/product/product_list");
		List topList=p_topcategoryService.selectAll();
		mav.addObject("topList", topList);
		return mav;
	}

	@RequestMapping(value = "/shop/product/sublist", method = RequestMethod.GET)
	@ResponseBody
	public List getSubcategory(int p_topcategory_id) {
		List<P_subcategory> subList=null;
		if(p_topcategory_id==0) {
			subList = p_subcategoryService.selectAll();
		}else {
			subList = p_subcategoryService.selectAllById(p_topcategory_id);
		}
		return subList;
	}
	
	@RequestMapping(value="/shop/product/detail", method=RequestMethod.GET)
	public ModelAndView detail(int product_id) {
		ModelAndView mav = new ModelAndView("shop/product/detail");
		Product product=(Product)productService.select(product_id);
		mav.addObject("product", product);
		List recipeList=(List)recipeService.selectRecipeByProduct(product_id);
		mav.addObject("recipeList", recipeList);
		return mav;
	}
	
	/*---------------------------------------------------------------------
	 * 예외 처리
	 * --------------------------------------------------------------------*/
	@ExceptionHandler(ProductRegistException.class)
	@ResponseBody
	public String handleException(ProductRegistException e) {
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"result\":\"0\",");
		sb.append("\"msg\":\""+e.getMessage()+"\"");
		sb.append("}");
		return sb.toString();
	}
	
	@ExceptionHandler(ProductUpdateException.class)
	@ResponseBody
	public String handleException(ProductUpdateException e) {
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"result\":\"0\",");
		sb.append("\"msg\":\""+e.getMessage()+"\"");
		sb.append("}");
		return sb.toString();
	}
	
	@ExceptionHandler(ProductDeleteException.class)
	@ResponseBody
	public String handleException(ProductDeleteException e) {
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"result\":\"0\",");
		sb.append("\"msg\":\""+e.getMessage()+"\"");
		sb.append("}");
		return sb.toString();
	}
	
	@ExceptionHandler(ImageRegistException.class)
	@ResponseBody
	public String handleException(ImageRegistException e) {
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"result\":\"0\",");
		sb.append("\"msg\":\""+e.getMessage()+"\"");
		sb.append("}");
		return sb.toString();
	}
}
