package com.gumzima.shopping.model.product.repository;

import java.util.List;

import com.gumzima.shopping.model.domain.Image;

public interface ImageDAO {
	public List selectById(int product_id);
	public Image select(int image_id);
	public void insert(Image image);
	public void delete(int image_id);
	public void deleteByProductId(int product_id);
}
