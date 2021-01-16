package com.gumzima.shopping.model.product.repository;

import java.util.List;

import com.gumzima.shopping.model.domain.Product;
import com.gumzima.shopping.model.domain.SearchText;

public interface ProductDAO {
	public List selectAll();
	
	public List searchProduct(SearchText searchText);

	public List searchProductByCategory(SearchText searchText);
	
	public Product select(int product_id);

	public void insert(Product product);
	
	public void update(Product product);
	
	public void delete(int product_id);
}
