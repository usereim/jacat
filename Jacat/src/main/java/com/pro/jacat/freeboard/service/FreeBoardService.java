package com.pro.jacat.freeboard.service;

import java.util.List;

import com.pro.jacat.freeboard.vo.FreeBoardVO;

public interface FreeBoardService {
	List<FreeBoardVO> selectAllBoard();	//FreeBoardVO�� �ִ� ����Ʈ���� ���Ǿ��� ��ȸ

	FreeBoardVO selectBoardByBno(int board_num);	//�Խñ� �ܰ� ��ȸ
}
