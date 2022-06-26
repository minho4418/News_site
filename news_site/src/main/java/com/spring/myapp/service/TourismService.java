package com.spring.myapp.service;

import java.util.List;

import com.spring.myapp.advice.ErrorCode;
import com.spring.myapp.dto.Board;
import com.spring.myapp.dto.Page;
import com.spring.myapp.dto.Tourism;

public interface TourismService {
	List<Tourism> selectList(Page page);
	Tourism selectOne(int tnum);
	//열거형 반환
	ErrorCode insert(Tourism tourism) throws Exception;
	ErrorCode update(Tourism tourism,List<Integer> removeFiles) throws Exception;
	ErrorCode updateRemoveyn(int tnum);
	
	//조회수+1
	int updateReadCnt(int tnum);
	//좋아요+1
	int updateLikeCnt(int tnum);
	//싫어요+1
	int updateDisLikeCnt(int tnum);
}
