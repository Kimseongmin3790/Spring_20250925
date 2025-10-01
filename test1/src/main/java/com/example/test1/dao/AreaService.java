package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.AreaMapper;
import com.example.test1.model.Area;

@Service
public class AreaService {
	
	@Autowired
	AreaMapper areamapper;
	
	public HashMap<String, Object> areaList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Area> list = areamapper.getAreaList(map);
		int cnt = areamapper.AreaCount(map);
		
		resultMap.put("list", list);
		resultMap.put("cnt", cnt);
		
		return resultMap;
	}
	
	public HashMap<String, Object> getSiList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Area> list = areamapper.selectSiList(map);
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}
}
