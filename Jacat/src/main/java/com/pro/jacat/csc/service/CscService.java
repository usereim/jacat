package com.pro.jacat.csc.service;

import java.util.List;
import java.util.Map;

import com.pro.jacat.csc.vo.CscVO;

public interface CscService {
	public void insertBoardsOne(CscVO csc);
	List<CscVO> selectBoardsAllByType(String type);
	CscVO selectBoardsOne(Map<String, Object> map);
}
