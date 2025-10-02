package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Area;

@Mapper
public interface AreaMapper {
	
	// 지역 목록
	List<Area> getAreaList(HashMap<String, Object> map);
	
	// 목록 숫자
	int AreaCount(HashMap<String, Object> map);
	
	// 시 목록
	List<Area> selectSiList(HashMap<String, Object> map);
	
	// 구 목록
	List<Area> selectGuList(HashMap<String, Object> map);
	
	// 동 목록
	List<Area> selectDongList(HashMap<String, Object> map);
}
