package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Mapper
public interface ProductMapper {
	// 제품 목록
	List<Product> selectFoodList(HashMap<String, Object> map);
	
	// 메뉴 목록
	List<Menu> selectMenuList(HashMap<String, Object> map);
	
	// 음식 추가
	int insertFood(HashMap<String, Object> map);
	
	// 음식 이미지 추가
	int insertFoodImg(HashMap<String, Object> map);
	
	// 음식 상세정보
	Product selectFoodInfo(HashMap<String, Object> map);
}
