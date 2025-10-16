package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.example.test1.controller.BoardController;
import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;
import com.example.test1.model.Member;

@Service
public class BbsService {

    private final BoardController boardController;
	
	@Autowired
	BbsMapper bbsMapper;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	PasswordEncoder passwordEncoder;

    BbsService(BoardController boardController) {
        this.boardController = boardController;
    }
	
	public HashMap<String, Object> login(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		try {
			Member member = bbsMapper.login(map);
			boolean loginFlg = passwordEncoder.matches((String) map.get("pwd"), member.getPassword());
			if (loginFlg) {
				session.setAttribute("sessionId", member.getUserId());
				resultmap.put("result", "success");
			}
		} catch (Exception e) {
			// TODO: handle exception
			resultmap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultmap;
	}
	
	public HashMap<String, Object> getBbsList(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		try {
			System.out.println(map);
			int cnt = bbsMapper.selectBbsCnt();
			System.out.println(cnt);
			List<Bbs> list = bbsMapper.selectBbsList(map);
			resultmap.put("cnt", cnt);
			resultmap.put("list", list);
			resultmap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultmap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultmap;
	}
	
	public HashMap<String, Object> addBbs(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		try {
			bbsMapper.insertBbs(map);
			resultmap.put("bbsNum", map.get("bbsNum"));
			resultmap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultmap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultmap;
	}
	
	public HashMap<String, Object> deleteBbsList(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		try {
			bbsMapper.deleteBbsList(map);
			resultmap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultmap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultmap;
	}
	
	public HashMap<String, Object> getBbsInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		try {
			Bbs bbs = bbsMapper.selectBbsInfo(map);
			resultmap.put("info", bbs);
			resultmap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultmap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultmap;
	}
	
	public HashMap<String, Object> editBbs(HashMap<String, Object> map) {
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		
		try {
			bbsMapper.editBbs(map);
			resultmap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultmap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultmap;
	}
	
	public void addBbsImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		int cnt = bbsMapper.insertBbsImg(map);
	}
}
