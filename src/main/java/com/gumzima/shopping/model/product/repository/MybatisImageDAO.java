package com.gumzima.shopping.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gumzima.shopping.exception.ImageDeleteException;
import com.gumzima.shopping.exception.ImageRegistException;
import com.gumzima.shopping.model.domain.Image;

@Repository
public class MybatisImageDAO implements ImageDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectById(int product_id) {
		return sqlSessionTemplate.selectList("Image.selectByProductId", product_id);
	}

	@Override
	public Image select(int image_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Image image) throws ImageRegistException{
		int result=sqlSessionTemplate.insert("Image.insert", image);
		if(result==0) {
			throw new ImageRegistException(" 이미지 데이터 등록 실패");
		}
	}

	@Override
	public void delete(int image_id) throws ImageDeleteException{
		int result=sqlSessionTemplate.delete("Image.delete", image_id);
		if(result==0) {
			throw new ImageDeleteException("이미지 테이터 삭제 실패");
		}
	}

	@Override
	public void deleteByProductId(int product_id) throws ImageDeleteException{
		int result=sqlSessionTemplate.delete("Image.deleteByProductId", product_id);
		if(result==0) {
			throw new ImageDeleteException("이미지 테이터 삭제 실패");
		}
	}

}
