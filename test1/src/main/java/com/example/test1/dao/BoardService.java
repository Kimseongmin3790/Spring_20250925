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
		int cnt = boardmapper.selectBoardCnt(map);
		
		resultMap.put("cnt", cnt);
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
		
		resultMap.put("boardNo", map.get("boardNo"));
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> getBoardInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.boardCnt(map);
		Board board = boardmapper.boardInfo(map);
		
		List<Comment> commentList = boardmapper.boardComment(map);
		
		List<Board> fileList = boardmapper.selectFileList(map);
		
		resultMap.put("fileList", fileList);
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
	
	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = boardmapper.commentInsert(map);
			resultMap.put("result", "success");
			resultMap.put("msg", "댓글이 등록되었습니다.");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("msg", "서버 오류가 발생했습니다. 다시 시도해주세요.");
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> RemoveComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.commentDelete(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> deleteBoardList(HashMap<String, Object> map) {
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = boardmapper.deleteBoardList(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}

	public void addBoardImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		int cnt = boardmapper.insertBoardImg(map);
	}
	
}