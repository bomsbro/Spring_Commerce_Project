package com.gumzima.shopping.model.recipe.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gumzima.shopping.exception.ImageDeleteException;
import com.gumzima.shopping.exception.ImageRegistException;
import com.gumzima.shopping.exception.ProductUpdateException;
import com.gumzima.shopping.model.common.FileManager;
import com.gumzima.shopping.model.domain.Image;
import com.gumzima.shopping.model.domain.Product;
import com.gumzima.shopping.model.domain.Recipe;
import com.gumzima.shopping.model.domain.RecipeSearch;
import com.gumzima.shopping.model.domain.Recipe_Product;
import com.gumzima.shopping.model.product.repository.ProductDAO;
import com.gumzima.shopping.model.recipe.repository.RecipeDAO;
import com.gumzima.shopping.model.recipe.repository.Recipe_ProductDAO;

@Service
public class RecipeServiceImpl implements RecipeService{
	@Autowired
	private RecipeDAO recipeDAO;
	
	@Autowired
	private Recipe_ProductDAO recipe_ProductDAO;
	
	@Autowired
	private ProductDAO productDAO;
	
	public List selectAll() {
		return recipeDAO.selectAll();
	}
	
	public void regist(FileManager fileManager, Recipe recipe) {
		
		String ext=fileManager.getExtend(recipe.getFoodImg().getOriginalFilename());
		recipe.setFilename(ext);
		recipeDAO.insert(recipe);
				
		//파일 업로드는 FileManager에게 시킨다.
		//상품의 product_id를 이용하여, 대표이미지명을 결정
		String foodImg=recipe.getRecipe_id()+"."+ext;
		fileManager.saveFile(fileManager.getSaveFoodDir()+File.separator+foodImg, recipe.getFoodImg());
		
		//관련 상품 등록
		if(recipe.getMaterialList().size()>0) {
			for(int i=0; i<recipe.getMaterialList().size();i++) {
				int material=recipe.getMaterialList().get(i);
				recipe.setProduct_id(material);
				recipe_ProductDAO.insert(recipe);
			}
		}
	}
	
	public List selectByOption(RecipeSearch recipeSearch) {
		List<Recipe> selectList=null;
		List<Recipe> recipeList=new ArrayList<Recipe>();
		List materialList=new ArrayList();
		List<Recipe_Product> recipe_productList=recipe_ProductDAO.selectAll();
		if(recipeSearch.getR_category_id()==0) {
			String text=recipeSearch.getText();
			selectList=recipeDAO.selectAllByText(text);
		}else {
			selectList=recipeDAO.selectByOption(recipeSearch);
		}
		for(int i=0; i<selectList.size();i++) {
			Recipe recipe=selectList.get(i);
			for(int a=0;a<recipe_productList.size();a++) {
				Recipe_Product recipe_Product=recipe_productList.get(a);
				if(recipe.getRecipe_id()==recipe_Product.getRecipe_id()) {
					materialList.add(recipe_Product.getProduct_id());
				}
			}
			recipe.setMaterialList(materialList);
			recipeList.add(recipe);
		}
		return recipeList;
	}

	@Override
	public Recipe select(int recipe_id) {
		return recipeDAO.select(recipe_id);
	}
	
	public List selectProductByRecipe(int recipe_id) {
		List productList=new ArrayList();
		List<Integer> productIdList=recipe_ProductDAO.selectProductByRecipe(recipe_id);
		for(int i=0;i<productIdList.size();i++) {
			int product_id=productIdList.get(i);
			Product product=productDAO.select(product_id);
			productList.add(product);
		}
		return productList;
	}
	
	public List selectProductIDByRecipe(int recipe_id) {
		return recipe_ProductDAO.selectProductByRecipe(recipe_id);
	}

	public List selectRecipeByProduct(int product_id) {
		List recipeList=new ArrayList();
		List<Integer> recipeIdList=recipe_ProductDAO.selectRecipeByProduct(product_id);
		for(int i=0;i<recipeIdList.size();i++) {
			int recipe_id=recipeIdList.get(i);
			Recipe reciep=recipeDAO.select(recipe_id);
			recipeList.add(reciep);
		}
		return recipeList;
	}
	
	public void update(FileManager fileManager, Recipe recipe, String basicRepImg, String[] delBasicRepImg) {
		String ext=null;

		//대표 이미지가 수정되었다면
		if(recipe.getFoodImg()!=null) {
			fileManager.deleteFile(fileManager.getSaveFoodDir()+File.separator+delBasicRepImg[0]);//기존 대표 이미지 파일 삭제
			
			//새로운 대표 이미지 파일 생성 및 데이터 입력값 적용
			ext=fileManager.getExtend(recipe.getFoodImg().getOriginalFilename());
			recipe.setFilename(ext);

			String foodImg=recipe.getRecipe_id()+"."+ext;
			fileManager.saveFile(fileManager.getSaveFoodDir()+File.separator+foodImg, recipe.getFoodImg());
		}else {//대표이미지가 수정되지 않았다면
			ext=fileManager.getExtend(basicRepImg);
			recipe.setFilename(ext);
		}

		//관련 상품 정보 초기화 후 재입력
		recipe_ProductDAO.delete(recipe.getRecipe_id());
		
		//관련 상품 등록
		if(recipe.getMaterialList().size()>0) {
			for(int i=0; i<recipe.getMaterialList().size();i++) {
				int material=recipe.getMaterialList().get(i);
				recipe.setProduct_id(material);
				recipe_ProductDAO.insert(recipe);
			}
		}
		
		//레시피 정보 업데이트
		recipeDAO.update(recipe);
	}

	public void delete(FileManager fileManager, int recipe_id) {
		//대표 이미지 파일 삭제
		Recipe recipe=recipeDAO.select(recipe_id);
		String fileName=recipe.getRecipe_id()+"."+recipe.getFilename();
		fileManager.deleteFile(fileManager.getSaveBasicDir()+File.separator+fileName);
		
		recipeDAO.delete(recipe_id);
	}
}
