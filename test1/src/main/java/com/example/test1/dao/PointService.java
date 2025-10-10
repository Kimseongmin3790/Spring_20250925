package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.PointMapper;
import com.example.test1.model.Point;

@Service
public class PointService {
	
	@Autowired
	PointMapper pointmapper;

	public HashMap<String, Object> getPointList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Point> list = pointmapper.selectPointList(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
				
		return resultMap;
	}
}
