package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;


@Service
public class ProductService {
	
	@Autowired
	ProductMapper productmapper;

	public HashMap<String, Object> getFoodList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Product> list = productmapper.selectFoodList(map);
			List<Menu> menuList = productmapper.selectMenuList(map);
			resultMap.put("menuList", menuList);
			resultMap.put("list", list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> getMenuList(HashMap<String, Object> map) {
			
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
			try {
				List<Menu> menuList = productmapper.selectMenuList(map);
				resultMap.put("menuList", menuList);
				resultMap.put("result", "success");
			} catch (Exception e) {
				// TODO: handle exception
				resultMap.put("result", "fail");
				System.out.println(e.getMessage());
			}
			
			return resultMap;
		}
	
	public HashMap<String, Object> addFood(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			productmapper.insertFood(map);
			
			resultMap.put("foodNo", map.get("foodNo"));
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}

	public HashMap<String, Object> addFoodImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			productmapper.insertFoodImg(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	public HashMap<String, Object> getMenuInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Product product = productmapper.selectFoodInfo(map);
			resultMap.put("info", product);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}

}
