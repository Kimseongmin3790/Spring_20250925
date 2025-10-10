package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

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
		
		String message = "";
		String result = "";
		
		if (member != null && member.getCnt() >= 5) {
			message = "비밀번호를 5회 이상 잘못 입력하셨습니다.";
			result = "fail";
		} else if(member != null) {
			message = "로그인 성공";
			result = "success";
			int cnt = membermapper.loginInit(map);
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
			if(member.getStatus().equals("A")) {
				resultmap.put("url", "/mgr/member/list.do");
			} else {
				resultmap.put("url", "/main.do");
			}
			
		} else {
			Member idCheck = membermapper.idCheck(map);
			if (idCheck != null) {
				if(idCheck.getCnt() >= 5) {
					message = "비밀번호를 5회 이상 잘못 입력하셨습니다.";
				} else {
					membermapper.loginFail(map);
					message = "패스워드를 확인해주세요";
				}
				
			} else {
				message = "아이디가 존재하지 않습니다";
			}
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
		
		resultmap.put("userId", map.get("userId"));
		return resultmap;
	}
	
	public HashMap<String, Object> getMemberList(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		try {
			List<Member> list = membermapper.memberList(map);
			resultmap.put("list", list);
			resultmap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultmap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultmap;
	}
	
	public HashMap<String, Object> loginReset(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		try {
			int cnt = membermapper.loginInit(map);
			resultmap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultmap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultmap;
	}
	
	public HashMap<String, Object> getMemberInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		try {
			Member member = membermapper.idCheck(map);
			resultmap.put("info", member);
			resultmap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultmap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultmap;
	}

	public void addUserImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		membermapper.insertUserImg(map);
	}
}
