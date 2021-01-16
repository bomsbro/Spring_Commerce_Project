package com.gumzima.shopping.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.exception.ProductDeleteException;
import com.gumzima.shopping.exception.ProductRegistException;
import com.gumzima.shopping.exception.ProductUpdateException;
import com.gumzima.shopping.model.domain.Product;
import com.gumzima.shopping.model.domain.SearchText;
@Repository
public class MybatisProductDAO implements ProductDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List selectAll() {
		return sqlSessionTemplate.selectList("Product.selectAll");
	}
	
	public List searchProduct(SearchText searchText) {
		String text=searchText.getText();
		return sqlSessionTemplate.selectList("Product.searchProduct", text);
	}
	
	public List searchProductByCategory(SearchText searchText) {
		return sqlSessionTemplate.selectList("Product.searchProductByCategory", searchText);
	}
	
	public Product select(int product_id) {
		return sqlSessionTemplate.selectOne("Product.select", product_id);
	}
	
	public void insert(Product product) throws ProductRegistException{
		int result=sqlSessionTemplate.insert("Product.insert", product);
		if(result==0) {
			throw new ProductRegistException("상품 등록 실패");
		}
	}

	public void update(Product product) throws ProductUpdateException{
		int result= sqlSessionTemplate.update("Product.update", product);
		if(result==0) {
			throw new ProductUpdateException("상품 수정 실패");
		}
	}

	public void delete(int product_id) throws ProductDeleteException{
		int result=sqlSessionTemplate.delete("Product.delete", product_id);
		if(result==0) {
			throw new ProductDeleteException("상품 삭제 실패");
		}
		
	}
}
