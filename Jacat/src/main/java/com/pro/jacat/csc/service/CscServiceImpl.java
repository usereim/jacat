package com.pro.jacat.csc.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pro.jacat.csc.repository.CscRepository;
import com.pro.jacat.csc.vo.CscVO;

@Service
public class CscServiceImpl implements CscService {
	
	private CscRepository cscRepository;
	
	public CscServiceImpl(CscRepository cscRepository) {
		super();
		this.cscRepository = cscRepository;
	}

	@Override
	public void insertBoardsOne(CscVO csc) {
		cscRepository.insertBoardsOne(csc);
	}

	@Override
	public List<CscVO> selectBoardsAllByType(String type) {
		return cscRepository.selectBoardsAllByType(type);
	}

	@Override
	public CscVO selectBoardsOne(Map<String, Object> map) {
		return cscRepository.selectBoardsOne(map);
	}

}
