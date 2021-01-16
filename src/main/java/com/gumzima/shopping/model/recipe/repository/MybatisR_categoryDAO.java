package com.gumzima.shopping.model.recipe.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MybatisR_categoryDAO implements R_categoryDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	public List selectAll() {
		return sqlSessionTemplate.selectList("R_category.selectAll");
	}

}
