package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	// 로그인
	Member memberLogin(HashMap<String, Object> map);
	// 중복체크
	Member idCheck(HashMap<String, Object> map);
	// 회원가입
	int memberJoin(HashMap<String, Object> map);
	// 프로필 이미지 등록
	int insertUserImg(HashMap<String, Object> map);
	// 회원 목록
	List<Member> memberList(HashMap<String, Object> map);
	// 로그인 실패 횟수 증가
	void loginFail(HashMap<String, Object> map);
	// 로그인 실패 횟수 초기화
	int loginInit(HashMap<String, Object> map);
}
