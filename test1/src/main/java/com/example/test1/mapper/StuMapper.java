package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;

@Mapper
public interface StuMapper {
	
	// 검색한 이름을 가진 학생의 정보 콘솔에 출력
	Student stuInfo(HashMap<String, Object> map);
	
	// 학생들 리스트
	List<Student> stuList(HashMap<String, Object> map);
	
	// 버튼 클릭한 학생 삭제
	int deleteStudent(HashMap<String, Object> map);
	
	// 학생의 정보 출력 (시험평균점수 포함)
	Student getStudent(HashMap<String, Object> map);
	
	// 학생 여러명 삭제
	int deleteStudentList(HashMap<String, Object> map);
}
