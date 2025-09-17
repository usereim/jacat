package com.pro.jacat.freeboard.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.freeboard.vo.FreeBoardCommentVO;
import com.pro.jacat.freeboard.vo.FreeBoardVO;

public interface FreeBoardService {
	
	
	List<FreeBoardVO> selectAllBoard();	//FreeBoardVO�� �ִ� ����Ʈ���� ���Ǿ��� ��ȸ

	FreeBoardVO selectBoardByBno(int board_num);	//�Խñ� �ܰ� ��ȸ
	
	List<FreeBoardCommentVO> selectCComment(int board_num);
	
	void insertBoard(FreeBoardVO vo, List<MultipartFile> file)	//����÷��
		throws IllegalArgumentException, IOException;
	
	int deleteBoard(int boardNum, String usersId);	//�Խñ� ���� 
	
	boolean updateBoard(FreeBoardVO vo);	//�Խñ� ����
	
	//����Է�
	boolean addComment(FreeBoardCommentVO vo);
}
