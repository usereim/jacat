package com.pro.jacat.freeboard.service;

import java.util.List;

import com.pro.jacat.freeboard.vo.FreeBoardVO;

public interface FreeBoardService {
	List<FreeBoardVO> selectAllBoard();	//FreeBoardVO에 있는 리스트들을 조건없이 조회

	FreeBoardVO selectBoardByBno(int board_num);	//게시글 단건 조회
}
