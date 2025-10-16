package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;
import com.example.test1.model.Member;

@Mapper
public interface BbsMapper {
	// 로그인
	Member login(HashMap<String, Object> map);
	// bbs리스트
	List<Bbs> selectBbsList(HashMap<String, Object> map);
	// 글 추가
	int insertBbs(HashMap<String, Object> map);
	// 선택 글 삭제
	int deleteBbsList(HashMap<String, Object> map);
	// 글 상세정보
	Bbs selectBbsInfo(HashMap<String, Object> map);
	// 글 수정
	int editBbs(HashMap<String, Object> map);
	// 모든 글 숫자
	int selectBbsCnt();
	// 파일 업로드
	int insertBbsImg(HashMap<String, Object> map);
}
