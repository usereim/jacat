package com.pro.jacat.csc.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pro.jacat.csc.repository.CscRepository;
import com.pro.jacat.csc.vo.CscCommentsVO;
import com.pro.jacat.csc.vo.CscVO;

@Service
public class CscServiceImpl implements CscService {
	
	private CscRepository cscRepository;
	
	public CscServiceImpl(CscRepository cscRepository) {
		super();
		this.cscRepository = cscRepository;
	}

	@Override
	public int insertBoardsOne(CscVO csc) {
		return cscRepository.insertBoardsOne(csc);
	}

	@Override
	public List<CscVO> selectBoardsAll(CscVO csc) {
		return cscRepository.selectBoardsAll(csc);
	}

	@Override
	public CscVO selectBoardsOne(CscVO csc) {
		return cscRepository.selectBoardsOne(csc);
	}

	@Override
	public void updateBoards(CscVO csc) {
		cscRepository.updateBoards(csc);
		
	}

	@Override
	public void deleteBoards(CscVO csc) {
		cscRepository.deleteBoards(csc);
		
	}

	@Override
	public int insertComments(CscCommentsVO cscCommentsVO) {
		return cscRepository.insertComments(cscCommentsVO);
	}
	
	@Override
	public List<CscCommentsVO> selectCommentsAll(int boardsBoardNum) {
		return cscRepository.selectCommentsAll(boardsBoardNum);
	}

	@Override
	public void deleteComments(int commentNum) {
		cscRepository.deleteComments(commentNum);
		
	}

	@Override
	public void updateComments(CscCommentsVO cscCommentsVO) {
		cscRepository.updateComments(cscCommentsVO);
		
	}

}
