package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Mapper
public interface BoardMapper {
	// 게시글 목록
	List<Board> boardList(HashMap<String, Object> map);
	
	// 게시글 삭제
	int boardRemove(HashMap<String, Object> map);
	
	// 게시글 추가
	int boardInsert(HashMap<String, Object> map);
	
	// 게시글 상세정보 조회
	Board boardInfo(HashMap<String, Object> map);
	
	// 게시글 수정
	int boardEdit(HashMap<String, Object> map);
	
	// 댓글 목록
	List<Comment> boardComment(HashMap<String, Object> map);
	
	// 댓글 등록
	int commentInsert(HashMap<String, Object> map);
	
	// 댓글 삭제
	int commentDelete(HashMap<String, Object> map);
	
	// 조회수 증가
	int boardCnt(HashMap<String, Object> map);
}
