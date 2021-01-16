package com.gumzima.shopping.model.product.service;

import java.util.List;

import com.gumzima.shopping.common.FileManager;
import com.gumzima.shopping.model.domain.Product;
import com.gumzima.shopping.model.domain.SearchText;

public interface ProductService {
	public List selectAll();

	public List searchProduct(SearchText searchText);
	
	public Product select(int product_id);
	
	public void regist(FileManager fileManager, Product product);

	public void update(FileManager fileManager, Product product, String basicRepImg,  String[] delBasicRepImg, String[] delBasicAddImg);

	public void delete(FileManager fileManager, int product_id);
}
