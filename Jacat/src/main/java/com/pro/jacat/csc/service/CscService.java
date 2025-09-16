package com.pro.jacat.csc.service;

import java.util.List;
import java.util.Map;

import com.pro.jacat.csc.vo.CscCommentsVO;
import com.pro.jacat.csc.vo.CscVO;

public interface CscService {
	public int insertBoardsOne(CscVO csc);
	CscVO selectBoardsOne(CscVO csc);
	void updateBoards(CscVO csc);
	void deleteBoards(CscVO csc);
	List<CscVO> selectBoardsAll(CscVO csc);
	int insertComments(CscCommentsVO cscCommentsVO);
	List<CscCommentsVO> selectCommentsAll(int boardsBoardNum);
	void deleteComments(int commentNum);
	void updateComments(CscCommentsVO cscCommentsVO);
}
