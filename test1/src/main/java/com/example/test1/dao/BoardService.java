package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Service
public class BoardService {
	
	@Autowired
	BoardMapper boardmapper;
	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> list = boardmapper.boardList(map);
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> removeBoard(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.boardRemove(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> addBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.boardInsert(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getBoardInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Board board = boardmapper.boardInfo(map);
		List<Comment> commentList = boardmapper.boardComment(map);
		
		resultMap.put("info", board);
		resultMap.put("commentList", commentList);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> editBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.boardEdit(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}
}