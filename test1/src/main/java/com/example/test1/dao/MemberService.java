package com.example.test1.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberMapper membermapper;
	
	@Autowired
	HttpSession session;
	
	public HashMap<String, Object> login(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		Member member = membermapper.memberLogin(map);
		String message = member != null ? "로그인 성공" : "로그인 실패";
		String result = member != null ? "success" : "fail";
		
		if(member != null) {
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
		}
		
		resultmap.put("msg", message);
		resultmap.put("result", result);
		
		return resultmap;
	}
	
	public HashMap<String, Object> check(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		Member member = membermapper.idCheck(map);
		String message = member != null ? "이미 사용중인 아이디 입니다" : "사용 가능한 아이디 입니다";
		String result = member != null ? "fail" : "success";
		
		resultmap.put("msg", message);
		resultmap.put("result", result);
		return resultmap;
	}

	public HashMap<String, Object> logout(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		// 세션정보 삭제하는 방법은
		// 1개씩 키값을 이용해 삭제하거나, 전체를 한번에 삭제
		
		String message = session.getAttribute("sessionName") + "님 로그아웃 되었습니다";
		resultmap.put("msg", message);
		
//		session.removeAttribute("sessionId"); // 1개씩 삭제
		
		session.invalidate(); // 세션정보 전체 삭제
		
		return resultmap;
	}
	
	public HashMap<String, Object> join(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		int cnt = membermapper.memberJoin(map);
		if (cnt < 1) {
			resultmap.put("result", "fail");
		} else {
			resultmap.put("result", "success");
		}
		
		return resultmap;
	}
}
