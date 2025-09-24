package com.pro.jacat.freeboard.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pro.jacat.freeboard.vo.FreeBoardCommentVO;
import com.pro.jacat.freeboard.vo.FreeBoardReportVO;
import com.pro.jacat.freeboard.vo.FreeBoardVO;

public interface FreeBoardService {
	
	
	List<FreeBoardVO> selectAllBoard();	//FreeBoardVO에 있는 리스트들을 조건없이 조회

	FreeBoardVO selectBoardByBno(int board_num);	//게시글 단건 조회
	
	void insertBoard(FreeBoardVO vo, List<MultipartFile> file)	//파일첨부
		throws IllegalArgumentException, IOException;
	
	int deleteBoard(int boardNum, String usersId);	//게시글 삭제 
	
	boolean updateBoard(FreeBoardVO vo,List<MultipartFile> files);	//게시글 수정
	
	//댓글입력
	boolean addComment(FreeBoardCommentVO vo);
	
	//대댓글 조회
	List<FreeBoardCommentVO> selectCComment(int board_num);
	
	//신고기능
	void insertReport(FreeBoardReportVO vo);
	
	//댓글 수정
	boolean updateComment(FreeBoardCommentVO vo);
	
	//조회수 증가
	void visit(FreeBoardVO visit);
}
